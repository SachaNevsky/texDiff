LaTeX-Template for Inline Images
================================

If you want your document to be self contained, you might want to decare inline images in base64 encoding.

Just use:

    \usepackage{inline-images}
    …
    \inlineimg{<filename>}{<base64 encoded raw image data>}

This creates a file `<filename>.base64` containning a copy of  the raw image data, then a sytsem shell is executed to convert the raw data to the binary image and a file `<filename>` is created, which is then include in your document.

**Note:** The LaTeX compiler must be able to execute system commands, so option `--shell-escape` is required.

**Note:** It is desiged for Unix systems and it requires the command line tool `base64` installed. Compilation calls `base64 -d <filename>.img.base64 > <filename>.img`.


Example
=======

This [example code]:

```latex
\documentclass[a5]{article}
\usepackage[paperwidth=6cm,paperheight=4cm]{geometry}

\usepackage{inline-images}

\newcommand{\img}{iVBORw0KGgoAAAANSUhEUgAAAMgAAADIC … BQ8f/JOcTkviE7+QAAAABJRU5ErkJggg==}

\begin{document}
\inlineimg{example.png}{\img}

© 2018 Marc Wäckerlin
\end{document}
```

After compilation:

   xelatex --shell-escape -synctex=1 -interaction=nonstopmode example.tex

Results in this [example document]:

![example screenshot](screenshots/example.jpg)


Need More
=========

If you are missing a feature or a configuration option, consult the [project] page. Just open a [ticket] and the [author] will care about it. Or extend it, it's [lgpl].



[example code]: screenshots/screenshot.tex "screenshot of the example document"
[example document]: examples/example.pdf "full example document"
[ticket]: https://mrw.sh/templates/inline-images/issues "open issues and tickets for my LaTeX-templates project"
[author]: https://marc.wäckerlin.ch "Marc Wäckerlin"
[project]: https://mrw.sh/templates/inline-images "the main project page"
[lgpl]: https://www.gnu.org/licenses/lgpl-3.0 "Library GNU Public License"

