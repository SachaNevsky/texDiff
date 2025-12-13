|
--------:| ----------------------------------------------------------------
nameauth:| Name authority mechanism for consistency in text and index
  Author:| Charles P. Schaum
  E-mail:| charles dot schaum@comcast.net
 License:| Released under the LaTeX Project Public License 1.3c or later
     See:| http://www.latex-project.org/lppl.txt

Short description:

The nameauth package automates the correct formatting and indexing of names
for professional writing. This aids the use of a name authority and the
editing process without needing to retype name references.

Files  Distribution

README       This file
nameauth.pdf Documentation
examples.tex Some longer example macros from the documentation

Makefile     Automates building with GNU make 3.81
nameauth.dtx Documented LaTeX file containing both code and documentation

Manual Installation

Download the package from

www.ctan.org/tex-archive/macros/latex/contrib/nameauth

Unpack nameauth.zip in an appropriate directory.

If you have a make utility compatible with GNU make, either in
GNU/Linux, a BSD variant, OSX, or Cygwin in Windows you can type

make inst

to install the package into your $TEXMFHOME tree or

make install

to install the package into your $TEXMFLOCAL tree for all users.
The latter requires sudo privileges.

Other useful targets include:

(release process)

make release The default target, same as just ``make''.

make clean Removes all intermediate files. Left are
the files listed above plus nameauth.sty.

make distclean Leave only nameauth.dtx, examples.tex,
and Makefile.

make zip Generate a zip file ready for distribution.

(testing process)

make testing Release files, plus compiles examples.tex.

make release ENGINE=<command>
Here, <command> can be pdflatex (default),
xelatex, lualatex, dvilualatex, or latex.

make testing ENGINE=<command> See above.

It is not necessary, however, to use GNU make. One can generate
the package files manually. Since the files nameauth.ins and README.txt
are contained in the .dtx file itself, the first step is to generate
the installer driver nameauth.ins, plus the file README.txt, which will
also trigger the extraction of nameauth.sty and produce the first pass of
the package documentation nameauth.pdf:

pdflatex -shell-escape -recorder -interaction=batchmode nameauth.dtx

Next one adds a table of contents and all cross-references, this also
should finalize page numbers for glossary and index input files:

pdflatex --recorder --interaction=nonstopmode nameauth.dtx

The next commands generate the glossary/index output files:

makeindex -q -s gglo.ist -o nameauth.gls nameauth.glo
makeindex -q -s gind.ist -o nameauth.ind nameauth.idx

The final two commands integrate the glossary (changes) and index:

pdflatex --recorder --interaction=nonstopmode nameauth.dtx
pdflatex --recorder --interaction=nonstopmode nameauth.dtx

Now one can either keep README.txt or rename it to README, e.g.:

mv README.txt README

Normally one creates the following directories for a user:

$TEXMFHOME/source/latex/nameauth dtx file
$TEXMFHOME/tex/latex/nameauth sty file
$TEXMFHOME/doc/latex/nameauth pdf file, README, examples.tex

and creates the following directories for the local site:

$TEXMFLOCAL/source/latex/nameauth dtx file
$TEXMFLOCAL/tex/latex/nameauth sty file
$TEXMFLOCAL/doc/latex/nameauth pdf file, README, examples.tex

The above environment variables often are /usr/local/texlive/texmf-local
and ~/texmf.

The make process normally renames the README.txt file created from the
dtx file to just README by using mv (move / rename utility in the *nix
userland). Windows distributions of TeX and LaTeX often keep the txt file
because of using file extensions instead of ``magic numbers'' to identify
files.

Run mktexlsr with the appropriate level of permissions to complete the
install.

Testing notes:

See the nameauth manual.

License

This material is subject to the LaTeX Project Public License:
http://www.ctan.org/tex-archive/help/Catalogue/licenses.lppl.html

Happy TeXing!
