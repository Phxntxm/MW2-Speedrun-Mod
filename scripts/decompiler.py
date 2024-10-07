import argparse
import os
import sys
from pathlib import Path

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from ff.compression import FFFile
from ff.constants import get_logger

logger = get_logger(__name__)
ff_dir = Path(__file__).parent.parent / "ff" / "files"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("files", help="FF files to decompile", nargs="+")
    args = parser.parse_args()
    # Setup absolute files to compile
    files = [Path(file).absolute() for file in args.files]

    for file in files:
        ff = FFFile(file)
        logger.info(f"Extracting files from {file}")
        ff.extract()


if __name__ == "__main__":
    main()
