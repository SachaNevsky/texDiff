The settings of font creation were created for the case of running this
distribution under MikTeX and TeXLive, which mean that most font headers
are created automatically by font utilities. If it is not happen please
edit setter.tex file and follow instructions below.


Please make sure that there are subdirectories with following names:
wrk
wrk\lh-lcy
wrk\lh-ot2
wrk\lh-t2a
wrk\lh-t2b
wrk\lh-t2c
wrk\lh-t2d
wrk\lh-x2
wrk\lh-xSlav
wrk\lh-temp
Any of them could be necessary during creation of METAFONT etc. files.

Run plain tex with files started with numerals:
01cm-lh.tex  - to create fonts for LCY encoding (DOS based encoding)
02cm-wn.tex  - to create fonts for OT2 encoding (AmS bases Cyrillic encoding)
03cm-vf.tex  - to create 7-bit fonts (encoding of N.Glonti fonts)
               like a part for virtual 8-bit Latin-Cyrillic font (obsolete?)

11ex-rs.tex  - to create fonts with Old Slav letters (in modern shapes)
11ex-rx.tex  - to create fonts for X2 encoding
12ex-la.tex
13ex-lb.tex
14ex-lc.tex
15ex-ld.tex  - to create fonts for T2(A,B,C,D) encodings
            
99CMstd.tex  - to create cm-based fonts in more or less standard encodings
               (01cm-lh.tex+02cm-wn.tex+03cm-vf.tex)
99T2enc.tex  - to create ex-based fonts for LaTeX T2*/X2 encodings
               (11ex-rs.tex---15ex-ld.tex)
99allenc.tex - to create cm-based and ex-based fonts
               (99CMstd.tex+99T2enc.tex)

After texing just copy subdirs with created mf-files as a whole from `wrk'
directory to `texmf/fonts/source/lh' directory
