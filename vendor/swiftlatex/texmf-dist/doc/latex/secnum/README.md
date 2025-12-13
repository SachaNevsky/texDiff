
# secnum

This package provides a macro \setsecnum to format section numbering intuitively.

## Usage

One can simply use `\setsecnum{1.1.1}` to set the section numbering
format as `arabic.arabic.arabic` and depth to be 3.

## Installation

The installation is the same as usual Tex packages.

0. Put the source file `secnum.dtx` in a empty folder and go to there.

1. Run the following to create the package file `secnum.sty` (as well as this file `README.md`)

       XeTeX secnum.dtx

2. Move the following file into proper directories searched by TeX.
   The recommended directory is

       tex/latex/secnum

3. To produce the documentation run the following

       XeLaTeX secnum.dtx

4. The recommended directory for the documentation is

       doc/latex/secnum

## Download

One can also download the generated files from the [github release](https://github.com/GauSyu/secnum/releases).

