# MW2 Speedrun Mod
The purpose of this repository is to hold on to the FF files, and the source to those FF files, and provide releases that can be extracted.

### Installation
Go to the releases page and download the latest release. This is the folder that your files will be located:

```
C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Modern Warfare 2\zone\english
```

If you have a custom steam directory, then you probably know where that is. Your files will be in 
```
STEAMDIR\steamapps\common\Call of Duty Modern Warfare 2\zone\english
```

Make a backup of this entire english folder, so you can return to the normal game's setup. Then, extract the content from the zip file into the location.

Additionally, if you are playing in a different language - this folder will be that language.

### VMeter installation
If you just want the in-game velocity meter, the steps for this are the exact same as above, **except** you will only extract the `common.ff` file into the folder.

## Contribution
If you are making changes to this repo, first: only change things through a branch that then gets merged into master. Second: DO NOT TOUCH THE FF FILES. Instead, only change the files in `ff/source` - a pipeline will run to compile the changes in here into the FF file - and commit that to the branch. When something is merged into main, a pipeline will run to create a release zipping up all the FF files.

Each folder inside of `ff/source` corresponds to a specific ff file. For example, `ff/source/common` is the folder that `ff/files/common.ff` was decompiled to.

The script is made easy to use, so that you can **test locally**, just do not commit changes to the FF files.

#### Script usage
First, make sure python3.11 or higher is installed. This can be installed from here: https://www.python.org/downloads/ When installing, make sure that the option to "add to path" is checked, it is under some "advanced" section or something - I don't know, I don't use windows.

Depending on your system, the command may be `py` (common on windows), `python` or `python3`. If you do not know what to use, try these commands followed by `--version` (with a space between them) to make sure it is 3.11 or higher. Use that in place of `python` in the following commands

Note: The backslashes become forward slashes if you are on windows.

Decompiling:
```
python scripts/main.py decompile --decompile-all
```
Note: This should pretty much never be needed. They are already decompiled, that is precisely what's located in `ff/source`.

Compiling:
```
python scripts/main.py compile --ff ff/files/common.ff --source ff/source/common/maps/_utility.gsc
```

This example would compile the file `maps/_utility.gsc` into the `common.ff` FF file. If you need to compile multiple files, put spaces after each file, and provide them all to the `--source` flag. IE: `--source file.gsc file2.gsc file3.gsc`