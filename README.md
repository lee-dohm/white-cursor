# White Cursor Atom Package

Provides a white I-bar cursor in editor views for use with dark backgrounds.

![White Cursor animation](https://s3.amazonaws.com/lee-dohm/WhiteCursor.gif)

## Installation

The package can be installed by using the Settings screen and searching for `white-cursor`.

It can also be installed from the command line with the command:

```bash
apm install white-cursor
```

## Use

When Atom is loaded or any time you change the themes, the White Cursor package attempts to determine whether you have a dark syntax theme set. If so, it enables the white cursor. You can override its autodetection for the current session by using the `White Cursor: Toggle` command from the Command Palette.

### Commands

* `white-cursor:toggle` &mdash; Toggles the white cursor on or off.

## Copyright

Copyright &copy; 2014 [Lee Dohm](http://www.lee-dohm.com). See [LICENSE](https://github.com/lee-dohm/white-cursor/blob/master/LICENSE.md) for details.
