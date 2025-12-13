
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
defaultscale:=1.4;         u=1pt;
picture p,q;               gap:=18u;
for i := 0 upto 6:
 z[i]=(0u,i * gap * u);
endfor;
draw z0--z6;
dotlabels.lft(0,1,2,3,4,5,6);
q=thelabel.urt(btex Poly\TeX etex ,z0);
draw q;
draw q reflectedabout(z0,z0+(2u,0));
draw q shifted(0,gap) withcolor red;
fill bbox q shifted(0,2*gap*u) withcolor green;
draw q shifted(0,2*gap*u) withcolor white;
draw q scaled 2 shifted(0,5*gap*u);
p=q rotatedabout(z0,45);
draw p shifted(10u,3*gap*u);
draw bbox currentpicture withcolor green;
endfig;
end;
