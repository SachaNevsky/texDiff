
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
path p,q;
u=.5cm;
q=(0u,0u)--(6u,0u)--(4u,3u);
draw q;
p=(0u,0u){curl 4000}..(6u,0u)
  ..{curl 4000}(4u,3u);
draw p;
endfig;
end;
