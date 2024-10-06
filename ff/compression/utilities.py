import zlib

from ..constants import get_logger

logger = get_logger(__name__)


def end_pos(data: bytes, start: int) -> int:
    return data.find(b"\xff\xff\xff\xff", start)


def get_dword(data: bytes, offset: int) -> int:
    return int.from_bytes(data[offset : offset + 4], byteorder="little", signed=False)


def set_dword(data: bytes, dword: int, offset: int, *, reverse=False) -> bytes:
    _bytes = dword.to_bytes(4, byteorder="little")

    if reverse:
        _bytes = _bytes[::-1]

    return data[0:offset] + _bytes + data[offset + 4 :]


def compress(data: bytes, original: bytes, *, check: bool = True) -> bytes:
    compressed = zlib.compress(data, level=9)
    if check and len(compressed) > len(original):
        raise ValueError(f"Compressed data is too big - Original size: {len(original)}, New size: {len(compressed)}")
    elif len(compressed) < len(original):
        compressed += b"\x00" * (len(original) - len(compressed))
    return compressed
