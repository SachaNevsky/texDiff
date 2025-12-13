input graph
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
draw begingraph(2.5in,1.75in);
gdraw "yearm.dat"
 plot btex $\bullet$ etex;
gdraw "yearw.dat"
 plot btex $\circ$ etex;
glabel.bot
 (btex Burials etex,OUT);
glabel.lft
 (btex Number etex rotated 90,OUT);
endgraph;


endfig;
end;
