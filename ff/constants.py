import enum
import logging


class FFType(enum.StrEnum):
    regular = "IWffu100"


class Formatter(logging.Formatter):

    grey = "\x1b[38m"
    yellow = "\x1b[33m"
    red = "\x1b[31m"
    cyan = "\x1b[36m"
    reset = "\x1b[0m"

    format = f"[%(name)s] [%(levelname)s] - %(message)s"

    FORMATS = {
        logging.DEBUG: f"{grey}{format}{reset}",
        logging.INFO: f"{cyan}{format}{reset}",
        logging.WARNING: f"{yellow}{format}{reset}",
        logging.ERROR: f"{red}{format}{reset}",
        logging.CRITICAL: f"{red}{format}{reset}",
    }

    def format(self, record):
        log_fmt = self.FORMATS.get(record.levelno)
        formatter = logging.Formatter(log_fmt)
        return formatter.format(record)


def get_logger(name: str, *, level: int = logging.INFO) -> logging.Logger:
    logger = logging.getLogger(name)
    logger.setLevel(level)

    ch = logging.StreamHandler()
    ch.setLevel(level)
    ch.setFormatter(Formatter())
    logger.addHandler(ch)

    return logger
