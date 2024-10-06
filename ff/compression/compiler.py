import os
import pathlib
import re
import zlib

from ..constants import FFType, get_logger
from .utilities import compress, get_dword, set_dword

logger = get_logger(__name__)


class File:
    """
    This class is used to represent a file in the FF archive
    """

    _decompressed: bytes | None = None

    def __init__(self, name: str, offset: int, data: bytes, *, prefix: str) -> None:
        self.name = name
        self.offset = offset
        self.data = data
        self.prefix = prefix

    @property
    def compressed(self) -> bytes:
        """
        Returns the compressed data of the file
        """
        return self.data

    @compressed.setter
    def compressed(self, value: bytes) -> None:
        self.data = value

    @property
    def decompressed(self) -> bytes:
        """
        Returns the decompressed data of the file
        """
        if self._decompressed is None:
            self._decompressed = zlib.decompress(self.compressed)
        return self._decompressed

    @decompressed.setter
    def decompressed(self, value: bytes) -> None:
        self._decompressed = value

    @property
    def extracted_path(self) -> pathlib.Path:
        """
        Returns the path where the file will be extracted
        """
        path = pathlib.Path(os.path.abspath(__file__)).parent.parent / "source" / self.prefix / pathlib.Path(self.name)
        path.parent.mkdir(parents=True, exist_ok=True)
        return path

    def extract(self) -> None:
        """
        Extracts the file to the path based on the name
        """
        logger.info(f"Extracting {self.name} to {self.extracted_path}")

        with open(self.extracted_path, "w+b") as f:
            f.write(self.decompressed.replace(b"\r\n", b"\n"))


class Headers:
    """
    This class is used to represent the headers of the FF file
    """

    def __init__(self, _compressed: bytes, _decompressed: bytes) -> None:
        self._compressed = _compressed
        self._decompressed = _decompressed

    @property
    def type(self) -> FFType:
        """
        Returns the type of the FF file
        """
        return FFType(self._decompressed[:8].decode("utf-8"))

    @property
    def version(self) -> int:
        """
        Returns the version of the FF file
        """
        return get_dword(self._decompressed, 0)

    @property
    def length(self) -> int:
        """
        Returns the reported length of the decompressed data
        """
        return get_dword(self._compressed, 8)

    def update(self, *, compressed: bytes | None = None, decompressed: bytes | None = None) -> None:
        """
        Updates the headers with the new compressed or decompressed data
        """
        if compressed is not None:
            self._compressed = compressed
        if decompressed is not None:
            self._decompressed = decompressed


class FFFile:
    """
    This class is used to represent an FF file in its entirety
    """

    _compressed: bytes | None
    _decompressed: bytes | None
    _files: dict[str, File]
    path: pathlib.Path

    def __init__(self, path: str | pathlib.Path) -> None:
        self._compressed = None
        self._decompressed = None
        self._files = {}
        self.path = pathlib.Path(path)
        self.headers = Headers(self.compressed, self.decompressed)

    @property
    def zlib_start(self) -> int:
        """
        Returns the offset of the zlib compressed data
        """
        return self.compressed.find(b"\x78")  # zlib magic

    @property
    def compressed(self) -> bytes:
        """
        Returns the compressed data of the FF file, AKA the original data just read in bytes
        """
        if self._compressed is None:
            with open(self.path, "rb") as f:
                self._compressed = f.read()
        return self._compressed

    @compressed.setter
    def compressed(self, value: bytes) -> None:
        self._compressed = value
        self.headers.update(compressed=value)

    @property
    def decompressed(self) -> bytes:
        """
        Returns the zlib compressed portion of the data.
        """
        if self._decompressed is None:
            self._decompressed = zlib.decompress(self.compressed[self.zlib_start :])
        return self._decompressed

    @decompressed.setter
    def decompressed(self, value: bytes) -> None:
        self._decompressed = value
        self.headers.update(decompressed=value)

    @property
    def files(self) -> dict[str, File]:
        """
        Returns a dictionary of the files in the FF file
        """
        if not self._files:
            self.find_files()
        return self._files

    def save(self, path: str | None = None) -> None:
        """
        Saves the FF file to the specified path or the original path
        """
        path: pathlib.Path = pathlib.Path(path) if path else self.path

        # Reconstruct the compressed data - starting with the headers
        data = self.compressed[: self.zlib_start]
        # Update the decompressed's reported length
        decompressed = set_dword(self.decompressed, len(self.decompressed) - 0x24, 0)
        data += compress(decompressed, self.compressed[self.zlib_start :], check=False)
        # Write the data to the file
        with open(path, "wb") as f:
            f.write(data)

    def find_files(self) -> None:
        """
        Finds all the files in the FF file and stores them in the files dictionary
        """
        matches = re.finditer(r"[\w\/]{3,}\.\w{2,}".encode(), self.decompressed)

        for match in matches:
            filename = match.group(0).decode()
            file_start = match.end() + 1
            file_end = self.decompressed.find(b"\xff\xff\xff\xff", file_start)

            # Filter out non-zlib files
            if not (
                hex(self.decompressed[file_start]) == "0x78"
                and hex(self.decompressed[file_start + 1]) in ["0x01", "0x5e", "0x9c", "0xda"]
            ):
                continue

            self._files[filename] = File(
                filename, match.start(), self.decompressed[file_start:file_end], prefix=self.path.stem
            )

    def replace_file(self, file: File) -> None:
        """
        Replaces the data of a file in the FF file with the
        data located in the extracted location
        """
        # Read the file's data
        with open(file.extracted_path, "rb") as f:
            data = f.read()
        # Go back to carriage returns, since that's what the game uses
        data = data.replace(b"\n", b"\r\n")
        # Set the file's length dword
        self._decompressed = set_dword(self._decompressed, len(data), file.offset - 8)
        # Compress the data
        compressed = compress(data, file.compressed, check=False)
        self._decompressed = self.decompressed.replace(file.compressed, compressed)
        file.compressed = compressed

    def replace_files(self, *files: pathlib.Path) -> None:
        """
        Takes a list of files and replaces them in the FF file
        """
        _files: list[File] = []

        for file in files:
            normalized_file = pathlib.Path(file).absolute()
            normalized_file = pathlib.Path(*normalized_file.parts[normalized_file.parts.index("source") + 2 :])
            name = normalized_file.as_posix()

            if not os.path.exists(file):
                raise FileNotFoundError(f"{file} does not exist")

            if not file.is_file():
                raise ValueError(f"{file} is not a file")

            if name not in self.files:
                raise ValueError(f"{file} not found in {self.path}")

            if pathlib.Path(os.path.abspath(__file__)).parent.parent / "source" not in file.absolute().parents:
                raise ValueError(f"{file} is not a source file")

            _files.append(self.files[name])

        for file in _files:
            self.replace_file(file)

    def extract(self) -> None:
        """
        Extracts all the files in the FF file
        """
        for name, file in self.files.items():
            try:
                file.extract()
            except zlib.error as exc:
                logger.error(f"Failed to decompress {name}: {exc}")
