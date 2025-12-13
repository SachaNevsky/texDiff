Dear friends,

To convert a PSTricks-code picture into a graphic file ".pdf", process
the file "convert.tex" through the following steps:

  1) latex convert.tex (you automatically get the output file "convert-fig1.tex", then put the definitions in the preamble
     of the convert.tex file in that of the convert-fig1.tex file).
  2) latex convert-fig1.tex
  3) dvips convert-fig1.dvi
  4) call the file "convert-fig1.ps" by the Ghostview progam to convert this file into its
   eps version (you can rename the result, say "fig1.eps").
  5) use the eps2pdf program to convert the file "fig1.eps" into the file "fig1.pdf".

The file "test.pdf" gives an illustration for a partition of a plane domain.
Check your file "fig1.pdf" to see this partition.

Enjoy!
