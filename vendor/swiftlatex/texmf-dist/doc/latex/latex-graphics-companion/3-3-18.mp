input graph
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
draw begingraph(2.5in,2.5in);
n:=10;
defaultscale:=0.7;
pickup pensquare scaled 3pt;
setrange((1700,0),(whatever,whatever));
gdata("stones.dat", s,
gdraw ((scantokens s2),n)--
  ((scantokens s3),n);
glabel.lft(s1,(scantokens s2)-3,n);
n:=n+16;);
pickup pensquare scaled .5pt;
frame.bot;
autogrid(otick.bot,);
endgraph;

endfig;
end;
