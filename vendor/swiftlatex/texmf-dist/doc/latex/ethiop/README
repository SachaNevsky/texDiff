
Ethiopian Language Support for the Babel Package
------------------------------------------------

Version 0.7

by Berhanu Beyene, Manfred Kudlek,
   Olaf Kummer, and Jochen Metzinger

This is a collection of fonts and TeX macros that
enable you to typeset the characters of the languages
of Ethiopia. Its main distribution is through CTAN in the
directory language/ethiopia/ethiop/ .

The fonts are based on EthTeX which was originally distributed
by Abass B. Alamnehe. The genuine EthTeX package can be
found on CTAN in the directory language/ethiopia/ethtex/ .

The TeX macros use the Babel package by Johannes L. Braams,
they are derived from language.skeleton provided with that
package.



How to Install
--------------

1. Check the prerequisites for this package.
  - Make sure you have installed TeX and Metafont.
  - Make sure that cmbase.mf and romand.mf from the
    Computer Modern fonts are accessible to Metafont.
  - Make sure that you have installed LaTeX2e with
    a release date of 1996/12/01 or later.
    (CTAN: macros/latex/base/ )
  - Make sure that you have installed the Babel package with
    a release date of 1997/01/23 (version 3.6h) or later.
    (CTAN: macros/latex/packages/babel/ )

2. If a previous version of this package is installed, remove
all the files, especially the font files that were generated 
by Metafont after the first installation.

3. Depending on how you obtained this package it might be
necessary to unpack/uncompress an archive. Now all the files
mentioned in MANIFEST should be present.

4. Generate the TeX files from their docstrip source.
To do this, run
  tex ethiop.ins
in the directory where the files ethiop.ins and
ethiop.dtx reside.

5. The files ethiop.ins and ethiop.dtx can be removed, or you
can run
  latex ethiop.dtx
to generate the source code documentation. This is not
required.

6. Move the files to their destination.

The files        are                         and are needed by
    *.tfm        TeX font metric files       TeX
    *.fd         font defintions             TeX
    *.sty        style files                 TeX
    *.ldf        Babel language definitions  TeX
    *.tex        TeX sources                 TeX
    *.mf         Metafont sources            Metafont

The exact location where the files belong depends on your
installation. As a first approximation, install them
near other files with the same extension.

7. Remove the font files that might be left over from a
previous version of ethiop, that is all files
eth*.gf and eth*.pk .

8. Verify the installation by generating the documentation.
Run `latex ethiodoc' and have a look at the file ethiodoc.dvi
which contains the documentation and usage samples.



After the Installation
----------------------

Do not worry, most installations complete without any problems.
However, if the procedure described above does not work, I suggest
the following actions:
  - If the run on ethiop.ins fails, the files might have
    been corrupted during transmission or one of the necessary
    files might not be accessible to TeX.
  - If LaTeX complains about a missing input file, check whether
    the files *.fd and *.sty are accessible and readable.
  - If LaTeX complains about a missing font, check the
    placement of the files *.tfm .
  - If LaTeX issues warning messages, you might have an old version
    of LaTeX or Babel.
  - If LaTeX issues strange errors, you might have an old version
    of LaTeX or Babel.
  - If LaTeX issues strange errors, the files might have been
    corrupted during transmission. Conversions of CR, LF, and
    so on might cause this problem.
  - If the previewer or the printer driver complains about missing
    fonts and does not automatically call Metafont to generate
    these font, either adapt your installation or generate
    the fonts by hand. Depending on your installation you
    must run something like
      mf '\mode=localfont; input dsrom10'
    for each of the fonts.
  - If Metafont is called and complains about missing source
    files, check whether these (*.mf) are placed correctly.
  - If Metafont is called and complains about strange paths,
    you are probably generating the font at a lower resolution
    than 200 dpi. There is little you can do except ignoring
    the errors or telling Metafont to do so. Please report
    such errors only if they occur at resolutions above
    200 dpi.
  - If the previewer or the printer driver complains about missing
    characters, check whether you have deleted all files from
    previous versions of this font.
  - If the previewer or the printer driver complains about a
    checksum error, check whether you have deleted all files from
    previous versions of this font.

If that does not help, you might want to have a look at
http://www.informatik.uni-hamburg.de/TGI/mitarbeiter/wimis/kummer/ethiop_eng.html
where possible updates and bug reports will occur first. If this
does not help and your friendly TeXnician is unavailable, drop us
a mail. We will try to help you, if time permits.

We are always glad to hear about improvements and bug reports.
General comments are appreciated, too.

Universitaet Hamburg
FB Informatik, AB TGI
- Ethiopian Language Project Team -
Vogt-Koelln-Strasse 30
22527 Hamburg
Germany

mailto:ethiop@informatik.uni-hamburg.de
http://www.informatik.uni-hamburg.de/TGI/mitarbeiter/wimis/kummer/ethiop_eng.html
