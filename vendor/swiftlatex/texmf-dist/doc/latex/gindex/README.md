## gindex

This package provides a way to generate the format of index entries from within LaTeX.

What it does is to generate blocks like this for each first-level entry:
```
\setcounter{indexsubitems}{2}%
\indexitem{blah1}{1}%
  \indexsubitem{subblah1}{3}%
  \indexsubitem{subblah2}{5}%
\indexnoitem{}{}%
```

Then you can define `\indexitem` and the like to whatever you want.

### Recent changes

```
0.2   2019-10-07
      - Fix - Misplaced R in page_precedence.
      - Fix - The last item was discarded.
      - \indexspecial, for literal unformatted entries.
      - delim_n now set with a macro (\indexpagessep).
      - gindex.ist does not add headings anymore. A new style
        gindexh.ist does.

0.1   2019-10-01
      - First released version, with the most basic tools.
``` 

License:     MIT
________
Javier Bezos --- http://www.texnia.com





