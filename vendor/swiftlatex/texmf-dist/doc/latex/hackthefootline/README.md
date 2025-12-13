# hackthefootline
## Arbitrary footline selection and configuration for LaTeX beamer's standard themes.

Some `beamer` themes provide footlines -- and some do not.  
Now, if one wants to have a footline, he is restricted to the (outer) themes providing them or loads multiple themes. On top of that, these provided footlines are only configurable by redefining them as a whole, which is quite uncomfortable and yields many lines of additional code.

`hackthefootline` is a package taking over, defining and redefining different footlines, so they can be configured using key-value syntax. Also, it is possible (but *not* recommended as it might distract your audience) to switch between different footline types during a presentation.



### Dependencies
`hackthefootline` depends on the packages `ifthen` and `pgfkeys` and -- obviously -- on the `beamer` class.  

Additional sophisticated features included also require `appendixnumberbeamer` (only when using beamer v3.48 and older), `etoolbox`, `calc` and `numprint`, but these four dependencies can be resolved by passing some options to the `hackthefootline` package.

### License
This work is licensed under the LPPL 1.3c or any later version.
