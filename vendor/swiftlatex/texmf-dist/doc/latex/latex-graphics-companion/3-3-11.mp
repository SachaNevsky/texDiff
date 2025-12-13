input graph
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
draw begingraph(2.5in,1.5in);
numeric p[]; path r;
for j := 0 upto 100: p[j]:=0; endfor
gdata ("ages.dat",y, age:=(scantokens y1);
 p[age]:=p[age] + 1;);
r:=(0,0)
 for j := 1 upto 100: --(j,p[j]) endfor;
gdraw r;
frame.llft;
endgraph;

endfig;
end;
