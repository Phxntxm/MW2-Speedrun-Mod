"""Add the timer's helper clock menu to the game's patch.ff.

Scripts have no real-time clock, and the game clock stands still while the game is
paused. Menus can read the real clock with milliseconds(), but the only values a
menu can write to a dvar are fixed text. So the helper menu "sr_clock" answers one
bit at a time: when a script opens it, it stores milliseconds() in a menu variable
and sets dvar sr_c<N> to 1 for every bit N that is set, then sets sr_c_done.

The vanilla game only loads a fixed list of zones, so the menu has to live in one
of them. patch.ff is the last one loaded and ends with a run of text entries
followed by one empty rawfile, none of which refer to other data by position. That
makes its tail the one place where data can change size safely. The menu takes
the slot of the last text entry, a playlist message of the Microsoft Store
multiplayer build that single player never shows.

usage: python scripts/build_clock_menu.py <stock patch.ff> <output patch.ff>
"""

import argparse
import os
import struct
import sys
import zlib
from pathlib import Path

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from ff.constants import get_logger

logger = get_logger(__name__)

# Has to match the number of sr_c dvars that maps/_utility.gsc reads back
CLOCK_BITS = 24
MENU_NAME = "sr_clock"
MENU_FILE = f"ui/scriptmenus/{MENU_NAME}.menu"  # where the game looks for a script-opened menu
SACRIFICED_TEXT = b"PATCH_PLAYLIST_REQUIRES_DLC_GDK"

ASSET_MENUFILE = 25
ASSET_LOCALIZE = 27
ASSET_RAWFILE = 36

HEADER_SIZE = 40  # stream size, external size, eight block sizes
ASSET_LIST_SIZE = 32  # script string count and pointer, asset count and pointer
VIRTUAL_BLOCK = 3

# In the stream a pointer is either null or this marker, meaning "the data follows".
INLINE = b"\xff" * 8
NULL = b"\x00" * 8

# Menu expression codes, from the operator name table in iw4sp.exe.
OP_RIGHT_PAREN = 1
OP_MODULUS = 4
OP_GREATER_EQUAL = 11
OP_LEFT_PAREN = 16
OP_MILLISECONDS = 34
OP_LOCALVARINT = 78

EVENT_TEXT = 0
EVENT_IF = 1
EVENT_SET_LOCAL_VAR_INT = 4


def cstring(text: str) -> bytes:
    return text.encode("ascii") + b"\x00"


def op(code: int) -> tuple:
    return ("op", code)


def statement(tokens: list[tuple]) -> bytes:
    """A compiled expression: a 48-byte header, 24 bytes per token, then the string operands."""
    entries = b""
    strings = b""
    for kind, value in tokens:
        if kind == "op":
            entries += struct.pack("<IIIIQ", 0, 0, value, 0, 0)
        elif kind == "int":
            entries += struct.pack("<IIIIiI", 1, 0, 0, 0, value, 0)
        elif kind == "str":
            entries += struct.pack("<IIII", 1, 0, 2, 0) + INLINE
            strings += cstring(value)
        else:
            raise ValueError(kind)
    # entry count, entries pointer, no supporting data, then the evaluator's own scratch fields
    header = struct.pack("<II", len(tokens), 0) + INLINE + NULL + bytes(24)
    return header + entries + strings


def handler(event_type: int, data: bytes) -> bytes:
    return INLINE + bytes([event_type]) + bytes(7) + data


def text_handler(script: str) -> bytes:
    return handler(EVENT_TEXT, cstring(script))


def set_local_int_handler(name: str, tokens: list[tuple]) -> bytes:
    return handler(EVENT_SET_LOCAL_VAR_INT, INLINE + INLINE + cstring(name) + statement(tokens))


def if_handler(tokens: list[tuple], handlers: list[bytes]) -> bytes:
    # The condition is stored before the handlers it guards.
    return handler(EVENT_IF, INLINE + INLINE + statement(tokens) + handler_set(handlers))


def handler_set(handlers: list[bytes]) -> bytes:
    return struct.pack("<II", len(handlers), 0) + INLINE + INLINE * len(handlers) + b"".join(handlers)


def set_dvar(name: str, value: int) -> str:
    return f'"setdvar" "{name}" {value} ; '


def clock_handlers() -> list[bytes]:
    # Every compiled expression opens with a parenthesis that is never closed, and a
    # function call is closed by a right parenthesis without an opening one.
    handlers = [
        set_local_int_handler("sr_t", [op(OP_LEFT_PAREN), op(OP_MILLISECONDS), op(OP_RIGHT_PAREN)]),
    ]
    for bit in range(CLOCK_BITS):
        # Bit N is set when the value modulo 2^(N+1) is at least 2^N. Stock menus use
        # these operators; none uses the bitwise ones.
        is_set = [
            op(OP_LEFT_PAREN),
            op(OP_LEFT_PAREN),
            op(OP_LOCALVARINT),
            ("str", "sr_t"),
            op(OP_RIGHT_PAREN),
            op(OP_MODULUS),
            ("int", 1 << (bit + 1)),
            op(OP_RIGHT_PAREN),
            op(OP_GREATER_EQUAL),
            ("int", 1 << bit),
        ]
        handlers.append(if_handler(is_set, [text_handler(set_dvar(f"sr_c{bit}", 1))]))
    handlers.append(text_handler(set_dvar("sr_c_done", 1)))
    return handlers


def menu_def() -> bytes:
    """The 0x1e8-byte menu structure, with the values the stock script-opened popup (painter) uses."""
    menu = bytearray(0x1E8)
    menu[0x00:0x08] = INLINE  # name
    struct.pack_into("<ffffBB", menu, 0x08, 0.0, 0.0, 640.0, 480.0, 4, 4)  # rect and its alignment
    struct.pack_into("<I", menu, 0x50, 4)  # visible
    struct.pack_into("<ffff", menu, 0x58, 1.0, 1.0, 1.0, 1.0)  # text colour
    struct.pack_into("<i", menu, 0xC4, -1)  # no item under the cursor
    struct.pack_into("<Iff", menu, 0xC8, 1, 1.0, 0.1)  # fade settings
    menu[0xE0:0xE8] = INLINE  # onOpen
    menu[0x1E0:0x1E8] = INLINE  # expression data
    return bytes(menu)


def menu_file_asset() -> tuple[bytes, int]:
    """The whole menu file as it appears in the stream, and how many aligned objects it contains."""
    handlers = handler_set(clock_handlers())
    asset = (
        INLINE + struct.pack("<II", 1, 0) + INLINE  # menu file: name, one menu, menu list
        + cstring(MENU_FILE)
        + INLINE  # the one menu follows
        + menu_def()
        + bytes(48)  # expression data with nothing in it; stock menus always have one
        + cstring(MENU_NAME)
        + handlers
    )
    aligned_objects = 8 + CLOCK_BITS * 8
    return asset, aligned_objects


def find_tail(stream: bytes, asset_count: int) -> tuple[int, int]:
    """Offsets of the last text entry and of the rawfile that closes the zone."""
    asset_array = HEADER_SIZE + ASSET_LIST_SIZE
    types = [struct.unpack_from("<I", stream, asset_array + 16 * i)[0] for i in range(asset_count)]
    if types[-1] != ASSET_RAWFILE or types[-2] != ASSET_LOCALIZE:
        raise ValueError("this patch.ff does not end with a text entry and a rawfile")

    # The closing rawfile is {name, two zero lengths, buffer} then "patch" and one byte.
    rawfile = len(stream) - (24 + len(b"patch\x00") + 1)
    if stream[rawfile:] != INLINE + NULL + INLINE + b"patch\x00\x00":
        raise ValueError("unexpected closing rawfile")

    # A text entry is two inline pointers, the text, then its name.
    name_start = stream.rfind(b"\x00", 0, rawfile - 1) + 1
    if stream[name_start:rawfile - 1] != SACRIFICED_TEXT:
        raise ValueError(f"the last text entry is not {SACRIFICED_TEXT.decode()}")
    entry = stream.rfind(INLINE + INLINE, 0, name_start)
    text_end = stream.index(b"\x00", entry + 16)
    if text_end + 1 != name_start:
        raise ValueError("could not delimit the last text entry")
    return entry, rawfile


def build(stock: bytes) -> bytes:
    zlib_start = stock.index(b"\x78")
    stream = zlib.decompress(stock[zlib_start:])

    string_count, _, _, asset_count, _, _ = struct.unpack_from("<IIQIIQ", stream, HEADER_SIZE)
    if string_count:
        raise ValueError("expected a zone without script strings")
    if stream.find(cstring(MENU_FILE)) >= 0:
        raise ValueError("this patch.ff already contains the clock menu")

    entry, rawfile = find_tail(stream, asset_count)
    asset, aligned_objects = menu_file_asset()

    out = bytearray(stream[:entry] + asset + stream[rawfile:])
    struct.pack_into("<I", out, HEADER_SIZE + ASSET_LIST_SIZE + 16 * (asset_count - 2), ASSET_MENUFILE)
    struct.pack_into("<I", out, 0, len(out) - HEADER_SIZE)

    # The block size is the memory the game reserves. It includes padding before each
    # aligned object, which the stream does not hold, so reserve the worst case; a
    # block that is larger than needed is harmless, one that is too small is not.
    block = 8 + 4 * VIRTUAL_BLOCK
    reserved = struct.unpack_from("<I", out, block)[0] + len(asset) + 8 * aligned_objects
    struct.pack_into("<I", out, block, reserved)

    return stock[:zlib_start] + zlib.compress(bytes(out), 9)


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("stock", type=Path, help="Unmodified patch.ff from the game's zone folder")
    parser.add_argument("output", type=Path, help="Where to write the patch.ff with the clock menu")
    args = parser.parse_args()

    logger.info(f"Adding the {MENU_NAME} menu to {args.stock}")
    built = build(args.stock.read_bytes())
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_bytes(built)
    logger.info(f"Saved {args.output} ({len(built)} bytes)")


if __name__ == "__main__":
    main()
