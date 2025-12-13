input boxes
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
boxjoin(a.se=b.nw);
boxit.one("One");
boxit.two("Two");
drawboxed(one,two);
drawarrow one.n{up}..two.n;
endfig;
end;
