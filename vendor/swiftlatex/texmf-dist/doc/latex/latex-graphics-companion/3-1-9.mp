
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
size=75;
path p[];
def pointtopair(expr x,y,z)=
(-x*cosd a + y*sind a,
 -x*sind a * sind b -y*cosd a * sind b
  + z*cosd b)
enddef;
%
%basic path (the shape of the boundary)
%can be molded, can be constrained etc
p1:= (0,3size){right}..
  {down}(1.1size,1.75size){down}..
  (.35size,.75size)..(.175size,.375size)..
  {left}origin;
%path with regular---nearly so---
%distributed points
n:=0;%number of points along the curve
p10:= point 0 of p1 hide(n:=n+1)..
   for t:=1 upto 19: hide(n:=n+1)
   point .05t of p1..endfor
 point 1 of p1 hide(n:=n+1)..
   for t:=1 upto 13: hide(n:=n+1)
   point 1+t/14 of p1..endfor
 point 2 of p1 hide(n:=n+1)..
   for t:=1 upto 3: hide(n:=n+1)
   point 2+t/4 of p1..endfor
 point 3 of p1 hide(n:=n+1)..
   for t:=1 upto 3: hide(n:=n+1)
   point 3+t/4 of p1..endfor
   origin;
%viewing angle parameters
b:=-10; a:=60;
p100:= for k=0 upto n-1:
    pointtopair(0,xpart(point k of p10),
                  ypart(point k of p10))..
    endfor pointtopair(0,0,0);
p200:= for k=0 upto n-1:
    pointtopair(xpart(point k of p10), 0,
                ypart(point k of p10))..
    endfor pointtopair(0,0,0);
p300:= for k=0 upto n-1:
    pointtopair(0,-xpart(point n-k of p10),
          3size-ypart(point n-k of p10))..
    endfor pointtopair(0,0,0);
p400:= for k=0 upto n-1:
    pointtopair(-xpart(point n-k of p10),
     0, 3size-ypart(point n-k of p10))..
    endfor pointtopair(0,0,0);
%
fill (-1.5size,-size)--(-1.5size,5size)--
     (1.5size,5size)--(1.5size,-size)--cycle;
%
drawoptions(withcolor white);
%
pickup pencircle scaled .5pt;
%Top ring and hang up (rope)
draw point 0 of p100..
     point 0 of p100 + (0,.1size)..cycle;
draw point 0 of p100 + (0,.1size)..
     point 0 of p100 + (0,3size);
%Draw boundary curves
draw p100; draw p200; draw p300; draw p400;
%
%Draw (partially hidden) regular surfaces
pickup pencircle scaled .1pt;
for k=0 step 1 until n:
  draw point k of p200..point n-k of p300;
endfor
for k=0 upto n:
  draw point k of p400..point n-k of p100;
endfor
fill p100..reverse p200..cycle withcolor black;
%Front
pickup pencircle scaled .1pt;
draw p100; draw p200;
draw point 0 of p100--origin;
%
%Draw regular surface which is in sight
for k=0 step 1 until n:
  draw point k of p100..point n-k of p200;
endfor
endfig;
end;
