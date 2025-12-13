smartunits
==========

A [LaTeX](http://en.wikipedia.org/wiki/LaTeX) package that implements
automatic conversions between (some) metric and Imperial units.  All units are
printed using siuntx

Example
-------

```tex
\documentclass{article}
\usepackage{smartunits}
\begin{document}
      \SmartUnitSettings{metric imperial, places=1}
      \SmartUnit{km=100.0,figures=1}   % 100 km (60 mi)
      \SmartUnit{miles=62.15,places=1} % 100 km (62.2 mi)
      \SmartUnit{cm=10}                % 10 cm (3.9")
      \SmartUnit{celsius=20}           % 20 C (68.0 F)
      \SmartUnit{miles=5.0}            % 8.0 km (5.0 mi)
      \SmartUnit{miles=5.0, figures=1} % 8 km (5 mi)
      \SmartUnit{hours=0, minutes=59}  % 0:59 (12:59 AM) 
      \SmartUnit{hours=12, minutes=12} % 12:12 (12:12 PM)
      \SmartUnit{kg=10.0, places=1}    % 10.0kg (22.0 lbs) 
      \SmartUnit{pound=10.0,figures=1} % 5kg (10 lbs)
      \SmartUnit{l=10.0, places=1}     % 10.0l (2.6gal)
      \SmartUnit{L=10.0, places=1,uk}  % 10.0L (2.2gal)
\end{document}
```


Units supported
---------------

Currently smartunits converts between the following five classes of units:

    ============    ==============
       Metric          Imperial
    ------------    --------------    -------------
    kilometers      miles             (distance)
    centimeters     feet and inches   (length)
    Celsius         Fahrenheit        (temperature)
    24-hour time    12-hour time      (time)
    litres          USA/UK gallons    (volume)
    kilograms       pounds            (weight)
    ============    ==============    =============

It is quite easy to extend the code to other units. I am happy to consider new requests.

Requirements
------------

The package requires
[pgfkeys](https://www.ctan.org/pkg/pgfkeys) and
[siunitx](https://www.ctan.org/pkg/siunitx).

### Author

Copyright (c) 2016 [Andrew Mathas](mailto:andrew.mathas@gmail.com)

Released under the [LaTeX Project Public
License](http://www.latex-project.org/lppl.txt) v1.3c or later
