# Package numberpt #

Typeset counters spelled out in Portuguese.

Author: Miguel V. S. Frasson
[mvsfrasson@gmail.com](mailto:mvsfrasson@gmail.com)

This material is subject to the
[LaTeX Project Public License 1.3c](https://ctan.org/license/lppl1.3)

## What it does ##

Package `numberpt` defines commands to display counters speeled out in
Portuguese.

For example,
``` TeX
\renewcommand{\thechapter}{\Numberpt{chapter}}
```
makes chapter titles to be rendered as
> **Capítulo Um**
> **Capítulo Dois**

The styles are
* `\numberpt` for _all lowercase_
* `\Numberpt` for _First word capitalized_
* `\Numberpt` for _All Capitalized_
* `\NUMBERPT` for _ALL UPPERCASE_

## Options ##

In Portuguese, both “catorze” or “quatorze” (for 14) are correct.

In European Portuguese, the spelled out forms for 16, 17 and 19 are
“dezasseis”, “dezassete” and “dezanove”.  In Brazilian Portuguese, the
forms are “dezesseis”, “dezessete” and “dezenove”.

The package has options
* `catorze` (default) and `quatorze` to select form for 14.
* `dezesseis` (default) and `dezasseis` to select Brazilian or European Portuguese forms for 16, 17 and 19.

## Documentation ##

Full documentation on [numberpt.pdf].
