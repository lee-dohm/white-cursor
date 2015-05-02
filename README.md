# White Cursor Atom Package [![Build Status](https://travis-ci.org/lee-dohm/white-cursor.svg?branch=master)](https://travis-ci.org/lee-dohm/white-cursor) [![Dependency Status](https://david-dm.org/lee-dohm/white-cursor.svg)](https://david-dm.org/lee-dohm/white-cursor)

Provides a white I-bar cursor in editor views for use with dark backgrounds.

![White Cursor animation](https://raw.githubusercontent.com/lee-dohm/white-cursor/master/WhiteCursor.gif)

## Usage

By default the white cursor is always enabled. However, if you set the `white-cursor.enabled` setting to `detect`, then when Atom is loaded or any time you change the themes, the White Cursor package attempts to determine whether you have a dark syntax theme set. If so, it enables the white cursor. You can override its autodetection for the current session by using the `White Cursor: Toggle` command from the Command Palette.

### Commands

* `white-cursor:toggle` &mdash; Toggles the white cursor on or off.

### Configuration

* `white-cursor.enabled` &mdash; Accepts one of three values:
    * `always` &mdash; White cursor is always enabled **(default)**
    * `detect` &mdash; Detects whether a dark syntax is being used and enables the white cursor accordingly
    * `never` &mdash; White cursor is always *disabled*
* `white-cursor.darkThemes` &mdash; An array of theme package names (lowercased and hyphenated) that should be treated as dark syntax themes even if they do not contain both `dark` and `syntax` in the name

### Styles

The `.white-cursor-image` mixin is available in case there are situations where you need a white I-bar cursor in some areas of the UI even when you're using a light theme. For example, with the [Term2 package](https://atom.io/packages/term2) you can add the following to your `styles.less`:

```LESS
@import "packages/white-cursor/stylesheets/white-cursor";

.terminal {
  .white-cursor-image;
}
```

## Copyright

Copyright &copy; 2014-2015 [Lee Dohm](http://www.lee-dohm.com). See [LICENSE](https://github.com/lee-dohm/white-cursor/blob/master/LICENSE.md) for details.
