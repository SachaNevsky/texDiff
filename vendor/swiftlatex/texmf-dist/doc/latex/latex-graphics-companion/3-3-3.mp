input boxes
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
boxjoin(a.n=b.s-(20,60));
boxit.one("One");
circleit.two("Two");
drawboxes(one,two);
boxjoin();
boxit.three("Three");
three.w=one.e+(20,0);
fill bpath three withcolor green;
draw bpath three;
draw pic(three) withcolor red;
drawarrow one.c--two.c
 cutbefore bpath one
 cutafter bpath two;
endfig;
end;
