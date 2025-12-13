input graph
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
draw begingraph(2.5in,1.75in);
setrange(origin,(100,100));
numeric p[]; path r;
for j := 0 step 10 until 100:
  p[j]:=0; endfor
def check(expr age) =
 if age < 100:
   xage:=round(age/10) * 10;
   p[xage]:=p[xage] + 1; fi
enddef;
gdata ("ages.dat",y,
  check((scantokens y1)););
r:=(0,0) for j := 0 step 10  until 100:
   --(j,p[j]) endfor --(100,0);
gfill r -- cycle withcolor blue;
frame.llft;
endgraph;
endfig;
end;
