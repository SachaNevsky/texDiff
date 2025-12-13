
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
u=2.5cm;
path p;
p= (0,0) {dir 130}..
   {dir -130}(0.25u,0){dir 130}..
   {dir -130}(0.5u,0){dir 130}..
   {dir -130}(0.75u,0){dir 130}..
   {dir -130}(u,0);
draw p rotated -90;
endfig;
end;
