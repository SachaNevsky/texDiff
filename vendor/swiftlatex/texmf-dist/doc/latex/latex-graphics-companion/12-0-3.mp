
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
input graph
path m,w,last;
draw begingraph(2.4in,1.75in);
setrange((1800,0),(whatever,whatever));
gdata ("decade.dat",y,
  last:=((scantokens y1),0);
  augment.w(y1,y2);
  augment.m(y1,y3););
gfill (1800,0)--w--last--cycle
  withcolor red;
gfill (1800,0)--m--last--cycle
  withcolor green;
pickup pencircle scaled 3pt ;
gdraw w dashed withdots;
pickup pencircle scaled .75pt ;
glabel.bot (btex Number of burials per decade
     ($n \approx 4300$) etex,OUT);
endgraph;
endfig;
end;
