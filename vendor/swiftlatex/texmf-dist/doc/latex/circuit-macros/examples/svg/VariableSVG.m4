.PS
# `Variable.m4'
cct_init(svg_font(sans-serif,11bp__))

define(`elen_',dimen_)
down_
[ { variable(`capacitor') }
  move right; down_
  { variable(`resistor',uN) }
  move right; down_
  { variable(`capacitor(,C)') }
  move right; down_
  { variable(`inductor') }
  move right; down_
  { variable(`inductor(,W)') }
  ]
[
  skp = 0.4
  hskip = linewid*0.5
  cskip = hskip
Orig: Here
  { move right cskip
    move right elen_; move up 0.15 then down 0.15 then right_ hskip
    line invis right_ elen_ "C"; move right_ hskip
    line invis right_ elen_ "S" }
  Loopover_(`char',
   `move down skp ifelse(char,A,*0.5)
    { line invis right_ cskip "char"
      variable(`capacitor(,C)',char); move right_ hskip
      variable(`capacitor(,C)',char`'C); move right_ hskip
      variable(`capacitor(,C)',char`'S) }',
   A,P,L,N)
  ] with .w at last [].e+(0.4,0)

 command "</g>" # end font
.PE
