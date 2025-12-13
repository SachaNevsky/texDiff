input graph
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
path s; numeric x,y;
draw begingraph(2.5in,1.75in);
gdata ("students.dat",c,
 x:=(scantokens c1) * 12;
 y:=(scantokens c2);
 augment.s((x-5,0)--
 (x-5,y)-- (x+5,y)--
 (x+5,0));
 if y < 0: glabel.top(c2,(x,0)); fi
 if y > 0: glabel.bot(c2,(x,0)); fi
);
gfill s--cycle withcolor .5white;
frame.llft;
endgraph;
endfig;
end;
