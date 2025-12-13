# actuarialangle

Package **actuarialangle** provides commands to typeset the "angle"
symbol denoting a duration in actuarial notation, such as in symbols
for the present value of certain or life annuities, and an over
angle bracket used to emphasize joint status in symbols of life
contingencies.

## License

LaTeX Project Public License, version 1.3c or (at your option) any
later version.

## Version

2.1 (2019-06-13)

## Author

Vincent Goulet <vincent.goulet@act.ulaval.ca>, based on code from an
unknown author for `\actuarialangle` and friends.

## Installation

The package is part of TeX Live and MiKTeX. If it is not already
installed on your system, run `actuarialangle.dtx` through LaTeX with,
for example,

    pdflatex actuarialangle.dtx

and copy `actuarialangle.sty` where LaTeX can find it.

## Documentation

File `actuarialangle.pdf` contains the complete documentation of the
package. If needed, the documentation can be generated from the
sources using the following commands:

    pdflatex actuarialangle.dtx
    makeindex -s gglo.ist -o actuarialangle.gls actuarialangle.glo
    pdflatex actuarialangle.dtx

## Version history

See the documentation.
