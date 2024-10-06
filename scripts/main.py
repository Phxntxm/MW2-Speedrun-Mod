import argparse
import enum
import glob
import os
import pathlib
import sys
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from ff.compression import FFFile
from ff.constants import get_logger

logger = get_logger(__name__)


class Mode(enum.StrEnum):
    COMPILE = "compile"
    DECOMPILE = "decompile"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "mode",
        choices=[Mode.COMPILE, Mode.DECOMPILE],
        help="Mode to run in. Choices are [compile, decompile]",
        metavar="mode",
    )
    ff_file_group = parser.add_mutually_exclusive_group(required=True)
    ff_file_group.add_argument("--ff", help="FF file to compile/decompile")
    ff_file_group.add_argument("--decompile-all", help="Decompile all FF files in the directory", action="store_true")
    parser.add_argument(
        "--source", help="Source file to compile - required when using compile", required=False, nargs="+"
    )
    args = parser.parse_args()

    if args.decompile_all:
        for ff_file in glob.glob("ff/files/*.ff"):
            ff = FFFile(ff_file)
            logger.info(f"Extracting files from {ff_file}")
            ff.extract()
        return

    assert args.ff.endswith(".ff"), "Input file must be an .ff file"
    if args.mode == Mode.COMPILE:
        assert args.source, "Source file is required when compiling"

    ff = FFFile(args.ff)

    match args.mode:
        case Mode.COMPILE:
            logger.info(f"Replacing files in {args.ff} with {args.source}")
            ff.replace_files(*[pathlib.Path(s) for s in args.source])
            logger.info(f"Saving changes to {args.ff}")
            ff.save()
        case Mode.DECOMPILE:
            logger.info(f"Extracting files from {args.ff}")
            ff.extract()


if __name__ == "__main__":
    main()
