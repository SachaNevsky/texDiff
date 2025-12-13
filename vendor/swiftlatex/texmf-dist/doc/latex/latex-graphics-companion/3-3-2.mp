input boxes
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
boxjoin(a.se=b.nw-(10,-10));
boxit.one("One");
boxit.two("Two");
drawunboxed(one,two);
drawarrow one.n{dir 45}..two.n;
endfig;
end;
