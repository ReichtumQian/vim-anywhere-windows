
This repository is an updated version of [rahuliyer95's version](https://github.com/rahuliyer95/vim-anywhere), specifically tailored for Windows.

## Installation

**Requirements**:

1. AutoHotKey v2.
2. Your preferred text editor.

**Installation**:

1. Download the ZIP file of this repo and extract its contents to a folder.
2. (Optional) Add your editor to `PATH` environment variable.
3. Update the `VimPath` variable in `run.ps1` to point to your editor's executable path.
4. Execute the `vim-anywhere.ahk` script.

## How to use

1. (Optional) Select the text you want to edit.
2. Press `Ctrl + Alt + V` to open your editor and paste the selected text.
3. Edit the text and save the changes.
4. The edited text will be automatically copied to the clipboard.

To continuously copy the edited text without exiting the editor, use `keep_copy.ps1` instead of `run.ps1`.

## Licenses

MIT.