# dviinfox.pl

Perl script which prints information about a DVI file.
It supports not only the standard DVI format of TeX, but also
the extended DVI format of pTeX containing vertical direction.
It also accepts XDV format of XeTeX containing native font
definitions.

This is a joint effort of
Dag Langmyhr (Department of Informatics, University of Oslo)
and Hironobu Yamashita (Japanese TeX Development Community).

## Sample Output

Standard DVI (e.g. tests/font.dvi)

    font.dvi: DVI format 2; 4 pages
      Magnification: 1000/1000
      Size unit: 1000x25400000/(1000x473628672)dum = 0.054dum = 1.000sp
      Page size: 433ptx627pt = 15.253cmx22.049cm
      Stack size: 11
      Comment: " TeX output 2017.06.03:0419"
      Font  20:    cmsl10 at 10.000 (design size 10.000, checksum=1890463818)
      Font  19:    cmtt10 at 10.000 (design size 10.000, checksum=3756670072)
      Font  18:    cmbx12 at 14.400 (design size 12.000, checksum=3268824736)
      Font  16:    cmbx12 at 24.880 (design size 12.000, checksum=3268824736)
        (snip)
      Font   6:      cmr7 at  7.000 (design size  7.000, checksum=3650330706)
      Font   0:    cmex10 at 10.000 (design size 10.000, checksum=4205933842)

pTeX DVI (e.g. tests/playtate.dvi)

    playtate.dvi: DVI format 2; id 3 (pTeX DVI); 20 pages
      Magnification: 1000/1000
      Size unit: 1000x25400000/(1000x473628672)dum = 0.054dum = 1.000sp
      Page size: 450ptx697pt = 15.842cmx24.509cm
      Stack size: 2
      Comment: " TeX output 2017.06.03:0357"
      Font  75:    tmin10 at 48.000 (design size 10.000, checksum=3919565046)
      Font  74:     cmr10 at 48.000 (design size 10.000, checksum=1274110073)

XeTeX XDV (e.g. tests/native.xdv)

    native.xdv: DVI format 7 (XeTeX XDV); 1 page
      Magnification: 1000/1000
      Size unit: 1000x25400000/(1000x473628672)dum = 0.054dum = 1.000sp
      Page size: 406ptx633pt = 14.304cmx22.247cm
      Stack size: 3
      Comment: " XeTeX output 2017.06.03:0407"
      Native Font  36: c:/w32tex/share/texmf-dist/fonts/opentype/public/tex-gyre/texgyretermes-regular.otf at 10.000 (flags 0x6200, face index 0)
            +features: Colored=0x115511ff, Slant=0x10000, Embolden=0x7ae
      Native Font  35: c:/w32tex/share/texmf-dist/fonts/opentype/public/tex-gyre/texgyretermes-regular.otf at 10.000 (flags 0x6200, face index 0)
            +features: Colored=0x220022ff, Slant=0x10000, Embolden=0x7ae
        (snip)
      Native Font  21: c:/w32tex/share/texmf-dist/fonts/opentype/public/tex-gyre/texgyretermes-regular.otf at 10.000 (flags 0x0200, face index 0)
            +features: Colored=0x220022ff
      Native Font  14: c:/w32tex/share/texmf-dist/fonts/opentype/public/lm/lmroman10-regular.otf at 10.000 (flags 0x0000, face index 0)

## License

The script is licensed under MIT License.

## References

- Current development place by Hironobu Yamashita
    - https://github.com/aminophen/tex-assort
- Previous version 1.03 (2013/11/03 11:17) by Dag Langmyhr
    - http://dag.at.ifi.uio.no/public/bin/dviinfo

## Additional Notes

The perl script was originally named "dviinfo" by Dag Langmyhr,
and renamed "dviinfox" in 2017, to be easily distinguished from
another program written in C by Valentino Kyriakides
(Dviinfo revision 1.3 1993/11/23 22:49:30).
The C program seems to be derived from NeXTSTEP app in 1990s,
and it has nothing to do with our perl script.

## Release Date

2017-06-04
