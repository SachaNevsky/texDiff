input graph
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
draw begingraph(2.5in,1.75in);
gfill "yearw.dat" withcolor red;
for y=10,20,30:
  itick.lft(format("%g",y),y);
endfor
otick.top("19th century",1850);
otick.top("20th century",1950);
frame.llft;
autogrid(,);
endgraph;


endfig;
end;
