
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
u=1cm;
path p[];
p1:=(.5u,.5u)--(1.5u,.5u)--(.5u,1.5u)
 --(1.5u,1.5u)--(.5u,.5u)--cycle;
fill (p1 shifted (0,2.5u))
 rotatedaround ((u,3.5u),90);
draw p1 shifted (u,4u);
fill p1 shifted (3.5u,3u);
p2 =(2u,2u)..(u,3.5u)..(2u,5u)
 ..(4.5u,4u)..(7u,5u);
pickup pencircle scaled 4pt;
draw p2;
endfig;
end;
