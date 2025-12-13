## The Problem Being Solved

Some journals accept the reference list only as `\bibitem`s.
If you use BibTeX, there is no problem:
just paste the content of the `.bbl` file into your document.
However, there were no out-of-the-box way to do the same for `biblatex`,
and you had to struggle with searching appropriate `.bst` files,
or formatting your reference list by hand,
or something like that.

Now you haven't to.

## Usage
In preamble, after the `biblatex` package is loaded via `\usepackage[...]{biblatex}`:
```latex
\usepackage{biblatex2bibitem}
```

At the very end of document:
```latex
\printbibitembibliography
```

The desired `bibitem`s will be written directly to the PDF file.

When it's time to switch to `bibitem`s (e.g. before sending the paper to the journal),
just copy them to the to your `.tex` file, remove `biblatex` commands and load `cite` package.

### Disclaimer

This package itself is a hack.
Moreover, it is (as for 02 March 2020) under rather an active development.
New features may appear and disappear, and the API may be unstable.
Thus, you may want to download `biblatex2bibitem.sty` and keep it near your article
instead of (or in addition to) having installing it system-wide.

## Tips

### Linebreaks in generated bibliography

You can pass `block=par` option to `biblatex` like that:

```latex
\usepackage[block=par,...]{biblatex}
```
but not like that (see also https://github.com/plk/biblatex/issues/968):
```latex
\printbibliography[block=par,env=bibitembibliography]
```

It will add linebreaks in generated `bibitem`s and make the code a bit more beautiful :)

### (Un)desired spaces

If you really want to have a space after the title of an e.g. an article, just
```latex
\renewcommand{\ignorespacesaftertitlecase}{}
```

### `bibitem` separators

By default, generated `bibitem`s are separated by a line with a percent sign on it to make the readng of the cde easier.
You can tweak this by e.g.
```latex
\renewcommand{\printgeneratedbibitemseparator}{\ttfamily\%\\}
```
(for putting all the `bibitem`s into monotype font) or e.g.
```latex
\renewcommand{\printgeneratedbibitemseparator}{}
```
(for disabling "blank" lines but not linebreaks when copying).

### Other redefinable commands

Don't forget about `\makeatletter` and `\makeatother`!

+ `\print@begin@thebibliography` - default: `\textbackslash begin\{thebibliography\}\{99\}`

+ `\print@end@thebibliography`   - default: `\textbackslash   end\{thebibliography\}      `


## See also

+ https://github.com/plk/biblatex/issues/783

+ https://github.com/plk/biblatex/issues/292

+ https://tex.stackexchange.com/questions/12175/biblatex-submitting-to-a-journal (a hopeless discussion)

+ https://github.com/odomanov/biblatex-gost/issues/20 (in Russian)

## Repostories

+ [CTAN](https://ctan.org/pkg/biblatex2bibitem)

+ [GitLab](https://gitlab.com/Nickkolok/biblatex2bibitem)

## License

LPPL - LaTeX Project Public License v1.3c+, DFSG compat.

## Authors

+ Nikolai Avdeev aka @nickkolok

+ [@odomanov](https://github.com/odomanov/)
