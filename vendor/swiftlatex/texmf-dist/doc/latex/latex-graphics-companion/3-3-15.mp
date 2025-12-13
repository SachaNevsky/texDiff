input graph
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
path m; numeric n,width;
width:=20; defaultscale:=0.6; n:=0;
def bar(expr name,value) =
 gfill(n,0)--(n,value)--
 (n+width,value)--(n+width,0)--cycle
 withcolor (value/100,value/100,value/100);
 picture p;
 p = name infont defaultfont
     scaled defaultscale rotated 90;
 glabel.rt
   (image(unfill bbox p; draw p),(n,10));
 n:=n+width;
enddef;
draw begingraph(2.5in,1.75in);
setrange((0,0),(11*width,100));
autogrid(,otick.lft);
gdata("chap.dat",c,bar(c1,(scantokens c2)););
endgraph;
endfig;
end;
