
---
title:  Markdown Package User Manual
author: Vít Novotný
date:   v\markdownVersion{} (\markdownLastModified{})
---


<link href="https://afeld.github.io/emoji-css/emoji.css" rel="stylesheet" />

Introduction
============
The [Markdown package][pkg] converts [markdown][] markup to \TeX{} commands. The
functionality is provided both as a Lua module and as plain \TeX{}, \LaTeX{}, and
\Hologo{ConTeXt} macro packages that can be used to directly typeset \TeX documents
containing markdown markup. Unlike other convertors, the Markdown package
does not require any external programs, and makes it easy to redefine how each
and every markdown element is rendered.  Creative abuse of the markdown
syntax is encouraged. ;-)

 [markdown]: https://daringfireball.net/projects/markdown/basics/
             (Daring Fireball: Markdown Basics)
 [pkg]:      https://ctan.org/pkg/markdown
             (CTAN: Package markdown)


This document is a user manual for the [Markdown package][pkg]. It provides
tutorials and code examples. For an in-depth description of the package
requirements, interfaces, and implementation, please refer to the [technical
documentation][techdoc].

 [techdoc]: http://mirrors.ctan.org/macros/generic/markdown/markdown.pdf
            (A Markdown Interpreter for TeX)


Requirements
------------

The package requires a working \TeX{} distribution. [\TeX{} Live][tl] ≥ 2013 is
known to work and so are recent installation of [Mik\TeX{}][mik]. If you are
using a minimal installation of a \TeX{} distribution, please consult the
[technical documentation][techdoc] for a detailed list of required packages.

 [tl]: https://www.tug.org/texlive/ (TeX Live - TeX Users Group)
 [mik]: https://miktex.org/ (Home - MiKTeXorg)

Installation
------------

The package comes pre-installed with [\TeX{} Live][tl] ≥ 2016 and with recent
installations of [MikTeX][mik]. Unless you explicitly wish to use the latest
version of the package, you are encouraged to skip this step.

To install the package, first download the package from the repository
using Git:
``` sh
git clone https://github.com/witiko/markdown
``````
Next, enter the directory named `markdown` and interpret the file named
`markdown.ins` file using a Unicode-aware \TeX{} engine, such as XeTeX or
LuaTeX:
``` sh
cd markdown
luatex markdown.ins
``````
This should produce the following files:

 * `markdown.lua`, the Lua module,
 * `markdown-cli.lua`, the Lua command-line interface,
 * `markdown.tex`, the plain \TeX{} macro package,
 * `markdown.sty`, the \LaTeX{} package, and
 * `t-markdown.tex`, the \Hologo{ConTeXt} module.

### Local Installation

To perform a local installation, place the above files into your \TeX{}
directory structure. This is generally where the individual files should be
placed:

 * `<TEXMF>/tex/luatex/markdown/markdown.lua`
 * `<TEXMF>/scripts/markdown/markdown-cli.lua`
 * `<TEXMF>/tex/generic/markdown/markdown.tex`
 * `<TEXMF>/tex/latex/markdown/markdown.sty`
 * `<TEXMF>/tex/context/third/markdown/t-markdown.tex`

where `<TEXMF>` corresponds to a root of your \TeX{} distribution, such as
`/usr/share/texmf` and `~/texmf` on UN\*X systems or
`C:\Users\`\meta{Your username}`\texmf` on Windows systems. When in doubt,
consult the manual of your \TeX{} distribution.

### Portable Installation

Alternatively, you can also store the above files in the same folder as your
\TeX{} document and distribute them together. This way your document can be
portably typeset on legacy \TeX{} distributions.


First Document
--------------

In this section, we will take the necessary steps to typeset our first markdown
document in \TeX{}. This will serve as our first hands-on experience with the
package and also as a reassurance that the package has been correctly installed.

### Using Lua

Using a text editor, create a text document named `document.tex` with the
following content:
``` tex
\input markdown
\input hello
\bye
```````

#### Using the Lua Module

Using a text editor, create a text document named `hello.lua` with the
following content:
``` lua
#!/usr/bin/env texlua
local kpse = require("kpse")
kpse.set_program_name("luatex")
local markdown = require("markdown")
local convert = markdown.new()
print(convert("Hello *world*!"))
```````
Next, invoke LuaTeX from the terminal:
``` sh
texlua hello.lua > hello.tex
luatex document.tex
``````
A PDF document named `document.pdf` should be produced and contain the text
“Hello *world*!” Invoking pdfTeX should have the same effect:
``` sh
texlua hello.lua > hello.tex
pdftex document.tex
``````

#### Using the Lua Command-Line Interface

Using a text editor, create a text document named `hello.md` with the
following content:
``` md
Hello *world*!
``````
Next, invoke LuaTeX from the terminal:
``` sh
texlua ⟨CLI pathname⟩ -- hello.md hello.tex
luatex document.tex
``````
where \meta{CLI pathname} corresponds to the location of the Lua CLI script file,
such as `~/texmf/scripts/markdown/markdown-cli.lua` on UN\*X systems or
`C:\Users\`\meta{Your username}`\texmf\scripts\markdown\markdown-cli.lua` on Windows
systems. Use the command `kpsewhich markdown-cli.lua` to locate the Lua CLI
script file using [Kpathsea][].

 [Kpathsea]: https://tug.org/kpathsea/ (Kpathsea - TeX Users Group)

A PDF document named `document.pdf` should be produced and contain the text “Hello
*world*!” Invoking pdfTeX should have the same effect:
``` sh
texlua ⟨CLI pathname⟩ -- hello.md hello.tex
pdftex document.tex
``````

### Using Plain \TeX{}

Using a text editor, create a text document named `document.tex` with the
following content:
``` tex
\input markdown
\markdownBegin
Hello *world*!
\markdownEnd
\bye
```````
Next, invoke LuaTeX from the terminal:
``` sh
luatex document.tex
``````
A PDF document named `document.pdf` should be produced and contain the text
“Hello *world*!” Invoking pdfTeX should have the same effect:
``` sh
pdftex --shell-escape document.tex
```````

### Using \LaTeX{}

Using a text editor, create a text document named `document.tex` with the
following content:
``` tex
\documentclass{article}
\usepackage{markdown}
\begin{document}
\begin{markdown}
Hello *world*!
\end{markdown}
\end{document}
```````
Next, invoke LuaTeX from the terminal:
``` sh
lualatex document.tex
``````
A PDF document named `document.pdf` should be produced and contain the text “Hello
*world*!” Invoking pdfTeX should have the same effect:
``` sh
pdflatex --shell-escape document.tex
``````

***

As the next step, try typesetting the example documents distributed along with
the Markdown package:
``` sh
git clone https://github.com/witiko/markdown
cd markdown/examples
lualatex latex.tex
``````
A PDF document named `latex.pdf` should be produced. Open the text documents
`latex.tex` and `example.md` in a text editor to see how the example documents
are structured. Try changing the documents and typesetting them as follows:
``` sh
lualatex latex.tex
``````
to see the effect of your changes.

### Using \Hologo{ConTeXt}

Using a text editor, create a text document named `document.tex` with the
following content:
``` tex
\usemodule[t][markdown]
\starttext
\startmarkdown
Hello *world*!
\stopmarkdown
\stoptext
```````
Next, invoke LuaTeX from the terminal:
``` sh
context document.tex
``````
A PDF document named `document.pdf` should be produced and contain the text “Hello
*world*!” Invoking pdfTeX should have the same effect:
``` sh
texexec --passon=--shell-escape document.tex
``````

***

As the next step, try typesetting the example documents distributed along with
the Markdown package:
``` sh
git clone https://github.com/witiko/markdown
cd markdown/examples
context context.tex
``````
A PDF document named `context.pdf` should be produced. Open the text documents
`context.tex` and `example.md` in a text editor to see how the example documents
are structured. Try changing the documents and typesetting them as follows:
``` sh
context context.tex
``````
to see the effect of your changes.

Examples
========

In this section, I will describe the individual parts of the Markdown package.
Each part will be shown by example, leaving the implementation details to the
[technical documentation][techdoc].

 [techdoc]: http://mirrors.ctan.org/macros/generic/markdown/markdown.pdf
            (A Markdown Interpreter for \TeX{})

/markdown-interfaces.md
/markdown-options.md
/markdown-tokens.md

