# CHANGELOG

## **v0.6.0** &mdash; *Released: 1 May 2015*

* Updated for Deprecation Day
* Added keywords
* Added Travis CI build support

## **v0.5.2** &mdash; *Released: 17 January 2015*

* Fixed all deprecations

## **v0.5.1** &mdash; *Released: 16 December 2014*

* Added a description to the `white-cursor.darkThemes` configuration option to make using it more clear

## **v0.5.0** &mdash; *Released: 12 December 2014*

* Updated to work properly with the Shadow DOM

## **v0.4.1** &mdash; *Released: 22 October 2014*

* Created a `.white-cursor-image` mixin so that the white cursor can be used where appropriate with just a style change

## **v0.4.0** &mdash; *Released: 4 October 2014*

* Attempts to autodetect whether a dark syntax theme is loaded (from the theme name) and enables or disables the white cursor appropriately.
* Offers a command `white-cursor:toggle` to turn the white cursor on or off.
* Added configuration option `white-cursor.enabled` that can be set to `always`, `detect` or `never`
* Added configuration option `white-cursor.darkThemes` to match dark themes that do not contain the words `dark` or `syntax` in them

## **v0.3.0** &mdash; *Released: 19 June 2014*

* Switched to a completely CSS-based solution [found on Reddit](http://www.reddit.com/r/Atom/comments/28m5nu/change_your_text_cursor_to_white/)

## **v0.2.0** &mdash; *Released: 17 June 2014*

* Removed excess directives from the package to reduce load and activation times

## **v0.1.0** &mdash; *Released: 17 June 2014*

* Provides a white I-bar cursor in the editor for use with dark backgrounds
