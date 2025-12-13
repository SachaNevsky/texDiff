
defaultfont:="ptmr8r";
warningcheck:=0;
beginfig(1)
boolean timetofillbox; timetofillbox := true;
partway := 0.9;
l := .75in; u := 1.75in; n := 4;
theta := 360/n;
z1 = (0,u);
for i := 2 upto n: z[i] = z1 rotated ((i-1)*theta); endfor
forever:
 path p;
 p := z1
 for j := 2 upto n: --z[j] endfor  --cycle;
 if timetofillbox:
  fill p;
  timetofillbox := false;
 else:
  unfill p;
  timetofillbox := true;
 fi
 pair Z[];
 for j := 1 upto n:  Z[j] := partway[z[j-1],z[j]];  endfor
 Z1 := partway[z[n],z1];
 for j := 1 upto n:  x[j] := xpart Z[j]; y[j] := ypart Z[j];  endfor
 if not timetofillbox: l := abs(z1); fi
 exitif l < .05u;
endfor
endfig;
end;
