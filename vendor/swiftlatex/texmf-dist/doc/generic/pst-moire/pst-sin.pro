moireDict begin
/pst-sin {
0 0 translate
2 dict begin
/A1 0.5 def % amplitude
/TRAME {
-50 E1 2 mul 50 {/n exch def
gsave
    n E1 mul unit % x
    A1 unit 360 Tr div n E1 mul mul sin mul % y
    translate
    linecolor
    linewidth
     -6 unit -6 m mul unit moveto
      6 unit 6 m mul unit lineto
     stroke
grestore
     } for
} def
Runit neg dup
Runit 2 mul dup
rectclip
    TRAME
end
} def
end
