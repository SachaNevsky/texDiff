
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
input graph
path m;
numeric n,width;
width:=20;
defaultscale:=0.6;
n:=0;
def bar(expr name,value,r,g,b) =
 path q;
 q:=(n,0)--(n,value)--
 (n+width,value)--(n+width,0)--cycle;
 gfill q withcolor (r,g,b);
 gdraw q;
 picture p;
 p = name infont defaultfont
     scaled defaultscale
     rotated 90;
 glabel.rt(image(unfill bbox p; draw p),(n,10));
 n:=n+width;
enddef;
draw begingraph(2.4in,1.75in);
setrange((0,0),(11*width,100));
drawoptions(withcolor red);
autogrid(,otick.lft);
drawoptions();
gdata ("chap.dat",c,
  bar(c1,(scantokens c2),
(scantokens c3),(scantokens c4),(scantokens c5)););
endgraph;
endfig;
end;
