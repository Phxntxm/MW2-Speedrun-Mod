import argparse
from collections import defaultdict
from pathlib import Path
import os
import sys
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from ff.compression import FFFile
from ff.constants import get_logger

logger = get_logger(__name__)
source_dir = Path(__file__).parent.parent / "ff" / "source"
ff_dir = Path(__file__).parent.parent / "ff" / "files"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("files", help="Files to compile into FF file", nargs="+")
    args = parser.parse_args()
    # Setup absolute files to compile
    files = [(source_dir / Path(file)).absolute() for file in args.files]
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
