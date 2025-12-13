# biblatex-ajc2020unofficial

An *unofficial* `biblatex` style files for Australasian Journal of Combinatorics.
Note that the journal (as for 01 March 2020) does not accept `biblatex`,
so you probably want to use [`biblatex2bibitem`](https://gitlab.com/Nickkolok/biblatex2bibitem).

This is de-facto fork of [`biblatex-math`](https://github.com/konn/biblatex-math).

## License

LPPL - LaTeX Project Public License v1.3c+, DFSG compat.

## Options

<dl>
<dt><code>sentencedtitle</code> (default: <code>false</code>)</dt>
<dd>
Whether to make title alphabet sentence-style or not.
If <code>true</code>, for example, <code>The Proof of Riemann Hypothesis</code> will be rendered as "The proof of riemann hypothesis". To prevent letters to be downcased, you can use braces: <code>The Proof of {Riemann} Hypothesis</code> will result in <code>The proof of Riemann hypothesis</code>.
You also have to embrace maths with <code>{</code> and <code>}</code>, as in <code>A short proof of {$1 + 1 \neq 2$}</code>, otherwise LaTeX halts with an error.
</dd>
<dt><code>dashed</code> (default: <code>false</code>)</dt>
<dd>Whether to omit the same author(s) by <code>_____</code>, as in <code>amsrefs</code>.
**Not recommended for AJC, but left here for compatibility reasons.**</dd>
</dl>

## Usage

1. Copy the two files ( `biblatex-ajc2020unofficial.bbx` and `biblatex-ajc2020unofficial.cbx` ) into the folder with your paper
or install them globally (manually or from CTAN);

2. Use `biblatex` with `style=ajc2020unofficial` option, e.g.
```latex
\usepackage[backend=biber,style=ajc2020unofficial]{biblatex}

```

## Project pages

+ [GitLab](https://gitlab.com/Nickkolok/biblatex-ajc2020unofficial)

+ [CTAN](https://ctan.org/pkg/biblatex-ajc2020unofficial)
