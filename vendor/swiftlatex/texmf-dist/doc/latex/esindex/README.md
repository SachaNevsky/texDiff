## esindex

Generates automatically sort keys. Originally only for Spanish, but
version 1.5 provides tools for it to be adapted to other languages, so
that, for example,
```
\esindex{\textit{Höhe}}
```
can be made equivalent to
```
\index{Hoehe@\textit{Höhe}}
```

This package is based on the principle that sort keys should be
generated in most cases in the context where the entry appears
in the document.

### Recent changes

```
1.7   2019-10-10
      - Fix - because of a change in a macro name, it stopped
        working with xe/lua
      - Multi-level comparisons (up to 3), to better sort the items.
      
1.6   2019-09-30
      - Package option 'babel', which wraps each entry not in the main
        language with \foreignlanguage (or other macro).

1.5   2019-01-28
      - Macro \esindexactual, to replace all ocurrences of an entry
        with a new text.
      - Package option 'nospanish', for it to be adapted to other
        languages.
      - \esindexreplace, \esindexlastchar, \esindexkey now work with
        xe/lua.
``` 

License:     MIT
________
Javier Bezos --- http://www.texnia.com





