input graph
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
path m[],w[];
def wcheck(expr decade,value) =
 augment.w1(decade,0);
 augment.w1(decade,value);
 augment.w1(decade+5,value);
 augment.w1(decade+5,0);
enddef;
def mcheck(expr decade,value) =
 augment.m1(decade+5,0);
 augment.m1(decade+5,value);
 augment.m1(decade+10,value);
 augment.m1(decade+10,0);
enddef;
draw begingraph(3.75in,2in);
gdata ("decade.dat",y,
  wcheck((scantokens y1),(scantokens y2));
  mcheck((scantokens y1),(scantokens y3)););
gfill m1--cycle;
gdraw w1;
glabel.bot (btex Number of burials per decade
     ($n \approx 4300$) etex,OUT);
frame.llft;
endgraph rotated 90;

endfig;
end;
