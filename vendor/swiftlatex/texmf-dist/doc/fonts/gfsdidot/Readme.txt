This directory contains all the font properties list (VPL)
for the GFS Didot family and few other VPL files
needed to build them.

The different VPL files are:
       didot*7a.vpl   VPL files for each serie and shape of the GFS Didot
                      and the encoding OT1. These files have been tuned individually
                      (each! a long work) and only the metrics of the characters
                      have been included automatically.
       ts1-gfsdidot_model.vpl
                      VPL file used as a model to build all the GFS Didot
                      VPL fonts for the TS1 encoding (Text Companion encoding).
                      This file has been manually crafted but all the specific
                      parts have been marked (with special strings or comments)
                      
                      By using some scripts available in the directory "../tools" 
                      all the GFS Didot fonts for the TS1 encoding can be generated.
                      The main file to use is "../tools/MetricsTS1Fonts.sh".

                      Since not all characters for the TS1 encoding are available
                      in the GFS Didot Postscript fonts, a supplementary font
                      TeXGyre Pagella was used to retrieve the misssing characters.

                      This model should be used when the Postscript font GFS Didot
                      in regular form is used (since this font contains more characters
                      than the other GFS Didot Postcript fonts).
       ts1-gfsdidot_model_1.vpl
                      similar to the previous one but more characters are retrieved from
                      the font TeXGyre Pagella. It should be used when the GFS Didot Postscript
                      fonts in non regular shape and serie are used
       ts1-gfsdidot*.vpl
                      The final VPL font file for the GFS Didot font and the TS1 encoding.
       gdidot*6a.vpl  The final VPL used to produce the greek fonts. These
                      files are generated fully automatically.
       gfsudidotmath8a.vpl
                      The files for producing the math font. This file has been tuned manually.  
