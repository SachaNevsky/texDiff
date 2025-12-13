# Kana Parser for LuaTeX

## Author: Adam Zahumenský
-----------------------------

This is a LuaTeX package that allows for transliteration of Japanese syllabic alphabets, hiragana and katakana, to latin and vice versa.
The intention of this package is to assist in learning of the kana alphabets and allow users to write kana directly using latin, convert between the two kanas or romanize kana using simple macros.
I used the most common Hepburn romanization system while keeping to ASCII character set, hence not supporting long latin characters and instead using direct vowel transliteration (ou instead of ō).

The package features three functional macros, one for each target alphabet (latin, hiragana, katakana), which transliterate as much of the provided text as possible to the target alphabet.
The macros accept a multi-paragraph argument containing the text to transliterate.
Before using of any of these macros, use the \parserInit macro once to initialize the parser.

Some syllables such as "ji" support multiple kana representations. Refer to kanaparser.tex for the list of these syllables and use the \toggleChars macro to toggle between their representations.
Default choices are based on usage frequency.

To remove ambiguity of syllables beginning with a vowel and following the 'n' character, this package features an isolator character, ' (apostrophe). Refer to examples.tex for its usage.

To use geminated consonants in syllables such as tta using the little tsu (sokuon) character, double the desired consonant instead of typing 't'. Hence type ecchi instead of etchi.

To output Japanese characters you need to use a font with support for these characters. An example of this is ipafont.
LuaTeX cannot load otf/ttf fonts natively, use the luaotfload.sty helper bundled in TeXLive to do that.
Refer to examples.txt for font usage, ipafont is required to use the ipagp.otf font referenced in the file.

License: BSD
Supported Lua version: 5.2
Last package revision: 19 June 2018