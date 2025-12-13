moireDict begin
/pst-cosine {
/amplitud 2.5 def
/period 2 def
/cos1 [
-8 0.05 8 {/x exch def % 320 pts
 x unit
 360 x mul period div cos amplitud mul 
 } for
] def
%
/drawcos {
newpath
cos1 0 get cos1 1 get moveto
0 2 cos1 length 2 sub {/i exch def
 cos1 i get cos1 i 1 add get lineto
  } for
  stroke
} def
gsave
Runit neg dup
Runit 2 mul dup
rectclip
0 -8 unit translate
nr {
 0 E1 translate
 drawcos
} repeat
grestore
} def
end
