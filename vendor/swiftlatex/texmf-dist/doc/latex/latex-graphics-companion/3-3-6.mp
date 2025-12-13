input boxes
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
defaultfont:="ptmb8r";
vardef labelarrow
 (suffix BoxA,BoxB) expr Line =
  drawarrow Line
  cutbefore bpath BoxA
  cutafter bpath BoxB;
  point (.5*length Line) of Line
enddef;
color yellow,orange;
yellow:=red+green;  orange:=red+(green/2);
boxjoin(a.n=b.s-(0,.5in));
defaultscale:=1.5; circmargin:=4pt;
circleit.In("in"); circleit.One("1"); circleit.Two("2");
circleit.Three("3"); circleit.Four("4");
boxjoin(); circmargin:=16pt; circleit.X(""); X.c=Four.c;
drawunboxed(One,Two,Three,Four,In,X);
drawarrow In.n--One.s;
label.rt("a",labelarrow(One,Two) One.c--Two.c)
  withcolor red;
label.rt("b",labelarrow(Two,Three) Two.c--Three.c)
  withcolor green;
label.rt("b",labelarrow(Three,Four) Three.c--Four.c)
  withcolor green;
label.rt("a",labelarrow(Four,Two) Four.c{dir335}..
  {dir205}Two.c)  withcolor red;
label.lft("a",labelarrow(Three,Two) Three.c{dir205}..
  {dir335}Two.c)  withcolor red;
label.lft("b",labelarrow(Four,One) Four.c{dir180}..
  tension2..One.c)   withcolor green;
label.rt("b",labelarrow(One,One) One.c{dir45}..One.c+(40,0)
  ..{dir120}One.c) withcolor green;
label.rt("a",labelarrow(Two,Two) Two.c{dir65}..Two.c+(40,0)
  ..{dir100}Two.c)  withcolor red;
fill bpath One withcolor blue;
fill bpath Two withcolor yellow;
fill bpath Three withcolor orange;
draw bpath Four;  draw pic Two;
draw pic One withcolor white;
draw pic Three withcolor white;
pickup pencircle scaled 2pt;
draw bpath X dashed evenly withcolor (1 , .75, .8);
endfig;
end;
