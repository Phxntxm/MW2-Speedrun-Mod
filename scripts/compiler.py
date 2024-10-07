import argparse
import os
import sys
from collections import defaultdict
from pathlib import Path

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from ff.compression import FFFile
from ff.constants import get_logger

logger = get_logger(__name__)
source_dir = Path(__file__).parent.parent / "ff" / "source"
ff_dir = Path(__file__).parent.parent / "ff" / "files"


def normalize_files(files: list[str]) -> list[Path]:
    _files: list[Path] = []

    for file in files:
        # Check if file exists
        _file = Path(file)
        # If it doesn't exist, then it's possible this is the github workflow
        #  that can only pass files relative to the source directory
        if not _file.exists():
            _file = Path(source_dir / _file)
        # If it still doesn't exist, then fail out
        if not _file.exists():
            raise FileNotFoundError(f"File {_file} not found")
        _files.append(_file.absolute())

    return _files


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("files", help="Files to compile into FF file", nargs="+")
    args = parser.parse_args()
    # Normalize files
    files = normalize_files(args.files)
    # Setup a dict for ff: [source] pairs
    ff_files = defaultdict(list)

    # Group files by ff file
    for file in files:
        ff_files[ff_dir / f"{file.relative_to(source_dir).parts[0]}.ff"].append(file)

    # Compile files into FF files
    for ff_file, source_files in ff_files.items():
        ff_class = FFFile(ff_file)
        logger.info(f"Replacing files in {ff_class.path} with {source_files}")
        ff_class.replace_files(*source_files)
        logger.info(f"Saving changes to {ff_class.path}")
        ff_class.save()


if __name__ == "__main__":
    main()
