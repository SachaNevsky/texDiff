
This package defines two commands: \dotlessi and \dotlessj, which give 
you access to dotless i's and j's in math mode.  They are intended for 
symbols in non English languages.

If the default math font is used, they are equivalent to \imath and 
\jmath; if a different font is used (like \mathrm, \mathbf, \mathsf) 
these commands look in the corresponding font tables to find their 
codes.  In text mode, they expand to \i and \j.  For example:

$f_{\mathrm{m\acute{\dotlessj}n}}$

License:     MIT
________
Javier Bezos --- http://www.texnia.com






