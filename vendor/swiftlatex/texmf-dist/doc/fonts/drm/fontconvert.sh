#!/usr/local/bin/fontforge
# +AMDG

Open($1)
Generate($1:r + ".otf")
#Open($1:r + ".otf")
#addLookup("ffilig",gsub_ligature,,[["liga",[["latn",["dflt"]]]]],"");
