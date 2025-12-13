# Correction Spacings: eqnarray(*), aligned, alignedat, and gathered

## Descriptions

We will realignment some expression environments spacing.
It is a correction in the horizontal spacing of the alignment.

## Version

1.1

## Usage

### Preamble

```
\usepackage{amsmath}% optional: if you use aligned, alignedat, or gathered environments
\usepackage{correctmathalign}
```

#### Remark

The problem with the amsmath package (2017/11/05 2.16a) was solved by the original. See the options \texttt{alignedleftspaceyes}, \texttt{alignedleftspaceno}, and \texttt{alignedleftspaceyesifneg}.
We dealt with versions prior to amsmath.sty (dtx) 2016/03/10 v2.15b.


### Options

 * latexorg: original behavior of LaTeX/amsmath package
 * fleqn: corresponds to class file and/or amsmath package's fleqn option

## File with Original Definitions

 * eqnarray: latex.ltx
 * \start@aligned and gathered: amsmath.sty (before 2016/03/10 v2.15b)

## Author

Yuwsuke Kieda

## License

BSD 2-Clause License
