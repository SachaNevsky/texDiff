
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
u=2pt;
labeloffset:=10pt;
defaultfont:="ptmb8r";
dotlabel.ulft ("upper left",(100u,100u));
label.urt (btex upper right etex,(100u,100u));
label.llft ("lower left",(100u,100u));
label.lrt (btex $x_1,y_1$ etex,(100u,100u));
draw (50u,100u)--(150u,100u);
draw (100u,125u)--(100u,75u);
endfig;
end;
