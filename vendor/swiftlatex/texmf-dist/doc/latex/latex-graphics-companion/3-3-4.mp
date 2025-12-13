input boxes
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
boxjoin(a.e=b.w-(30,0));
boxit.one("One");
circleit.two("Two");
drawboxed(one,two);
label.lft("1.",one.w);
label.rt("2.",two.e);
label.top("a.",
 point .5*length  (one.c{dir 45}..two.c)
   of (one.c{dir 45}..two.c) );
draw one.c{dir 45}..two.c
 cutbefore bpath one
 cutafter bpath two;
endfig;
end;
