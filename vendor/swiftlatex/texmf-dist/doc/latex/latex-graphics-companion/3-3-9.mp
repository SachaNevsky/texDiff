input graph
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
draw begingraph(2.5in,1.75in);
gfill "yearw.dat" withcolor red;
autogrid(grid.bot,itick.rt)
  withcolor .5white;
frame.llft;
endgraph;



endfig;
end;
