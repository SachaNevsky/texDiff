input graph
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
numeric r,last; path c,w;
r:=5; c:=fullcircle scaled 2r;
last:=0.0;
def wedge (expr lang,value,perc) =
 numeric current,n,half,xoff,yoff;
 picture p;
 n:=perc*3.6;
 current:=last+n;    half:=last+(n/2);
 w:=buildcycle((0,0)--(2r,0) rotated last,
  c, (2r,0)--(0,0) rotated current);
 gfill w withcolor (0,0.8-(perc/100),0);
 gdraw w;
 if perc > 5:
 p = lang infont defaultfont
    scaled defaultscale;
 glabel(image(unfill bbox p; draw p),
  3/4r*dir(half));
 fi;
 last:=current;
enddef;
draw begingraph(3in,3in);
defaultscale:=0.7;
gdata ("langs.dat",c,
  wedge(c1, (scantokens c2),
   (scantokens c3)););
autogrid(,);  frame withcolor white;
endgraph;
endfig;
end;
