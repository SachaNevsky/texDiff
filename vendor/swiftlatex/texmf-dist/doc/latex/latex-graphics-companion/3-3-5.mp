input boxes
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
vardef labelarrow
 (suffix BoxA,BoxB) expr Line =
  drawarrow Line
  cutbefore bpath BoxA
  cutafter bpath BoxB;
  point (.5*length Line) of Line
enddef;
defaultscale:=2;
boxjoin(a.e=b.w-(.75in,1.5in));
boxit.one("One");  circleit.two("Two");
drawboxed(one,two);
label.lft("1.",one.w);
label.rt("2.",two.e);
label.top("a.",labelarrow(one,two)
 one.c{dir90}..tension0.8..{dir90}two.s);
endfig;
end;
