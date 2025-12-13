input graph
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
def sq(expr x,y,num,perc) =
 gfill(x,y)--(x+10,y)--
  (x+10,y+10)--(x,y+10)--cycle
 withcolor (perc/100,perc/100,perc/100);
 glabel(num,(x+5,y+5))
   if perc < 50: withcolor white  fi;
enddef;
defaultscale:=0.7;
draw begingraph(70mm,80mm);
setrange((20,10),(110,110));
autogrid(,);
gdata ("pot.dat",c,
 sq((scantokens c1)*10,
 (scantokens c2)*10,
 c3, (scantokens c4)););
endgraph;

endfig;
end;
