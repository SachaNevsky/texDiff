# The Metafont Implementation of the Universal font

## Version 2.1, 2019/08/26
## by Christian Holm

This is the universal package containing my implementation of Herbert
Bayers `universal' font in Metafont, with LaTeX2e support.


## Installation

## Using Autotools 

	autoreconf -i -f 
	./configure 
	make 
	make install
	
## By hand

To install the package do:

1. Make sure you have created the following directories:

		 <TeX-base>/tex/latex/universa/
		 <TeX-base>/doc/latex/universa/
		 <TeX-base>/fonts/source/public/universa/
		 
	Where _TeX-base_ is the root of you TeX installation. The most
	common values of _TeX-base_ is

		/usr/local/lib/texmf (teTeX on Unix-like systems)
		C:\EMTEX             (emTeX on DOS-like systems)
	 
	 but could also be something like:

		/home/johndoe/lib/texmf  (user installation on Unix-like systems)
		D:\Program Files\TeX     (Some wierd Windows95 installation)

2. Put the files `universa.ins' and `universa.dtx' in some temporary
   directory.

3. Do
		latex universa.ins
		
	1. If you `docstrip` program is set up correctly, that is,
		`docstrip.cfg` exists and contains the line
		
			\BaseDirectory{<TeX-base>}

	   then all files will be put in the right directories, and you
	   need to do nothing more.

	2. If no `docstrip.cfg' is present on the system, then you need to
	   move the files your self. You should move the files as
	   specified below:

			*.mf       => <TeX-base>/fonts/source/public/universa/
			*.fd       => <TeX-base>/tex/latex/universa/
			uni.sty    => <TeX-base>/tex/latex/universa/
			unidoc.sty => <TeX-base>/doc/latex/universa/
			copyright  => <TeX-base>/doc/latex/universa/

	4. In any case you need to move the files below as specified
       below:
	   
			universa.dtx    => <TeX-base>/tex/latex/universa/
			universa.ins    => <TeX-base>/tex/latex/universa/
			README.md       => <TeX-base>/tex/latex/universa/
			
	  so that you can produce the documentation. You can of course
	  compress those file to save disk space.

5. If you are using some TeX distribution that has a database (that is
   proberly the case if your TeX distribution uses `kpathsea'), you
   should update that database.

6. To produce the documentation go to the directory where you put
	`unidoc`, i.e., `<TeX-base>/doc/latex/universa/`, and do
	
		latex universa.dtx
		latex universa.dtx
		makeindex -s gind -o uni.ind uni.idx
		makeindex -s gglo -o uni.gls uni.glo
		latex universa.dtx
		latex universa.dtx
		
	This should leave you with a file `uni.dvi` (or `uni.pdf`). You
    can remove the files
    
		uni.idx uni.glo uni.log uni.aux uni.toc uni.ilg uni.out

	You may need to substitute `makeindex` with what is relevant for
	your system, e.g., `makeindx` in emTeX.

I hope you will enjoy this package.

Please read the file `copyright` in the documentation directory, for
the copyright notice.
    
