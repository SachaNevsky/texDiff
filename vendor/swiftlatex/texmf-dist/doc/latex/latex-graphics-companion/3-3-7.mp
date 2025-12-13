input graph
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
draw begingraph(2.5in,1.75in);
gdraw "yearm.dat" dashed evenly;
gdraw "yearw.dat";
glabel.lft
 (btex (solid) Women etex, 1960,30);
glabel.lft
 (btex (dashed) Men etex ,1870,30);
glabel.bot
 (btex Number of burials per year
 ($n \approx 4300$) etex,OUT);
endgraph;


endfig;
end;
