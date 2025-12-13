
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
pickup pencircle scaled 4pt
   yscaled .2pt rotated 60;
n:=4;
for i := (n*20) step -(n) until (n):
 c:=((n*20)-i)/(n*2);
 draw (i,0)..(0,i)..(-i,0)
      ..(0,-(i-n))..(i-n,0)
 withcolor ((100-i)/100,i/100,0);
endfor
endfig;
end;
