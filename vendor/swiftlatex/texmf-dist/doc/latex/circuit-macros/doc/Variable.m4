.PS
# `Variable.m4'
cct_init

define(`elen_',dimen_); down_
[ { variable(`capacitor') }; move right
  { variable(`resistor',uN) }; move right
  { variable(`capacitor(,C)') }; move right
  { variable(`inductor') }; move right
  { variable(`inductor(,W)') }
  ]
[
  skp = 0.4
  hskip = linewid*0.5
  cskip = hskip
Orig: Here
  { move right cskip+elen_+hskip
    line invis right_ elen_ "\tt C"; move right_ hskip
    line invis right_ elen_ "\tt S" }
  Loopover_(`char',
   `move down skp ifelse(char,A,*0.5)
    { line invis right_ cskip "\tt char"
      variable(`capacitor(,C)',char); move right_ hskip
      variable(`capacitor(,C)',char`'C); move right_ hskip
      variable(`capacitor(,C)',char`'S) }',
   A,P,L,N)
  ] with .w at last [].e+(0.4,0)
.PE
