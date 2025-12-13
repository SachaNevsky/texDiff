%!
% PostScript prologue for pst-eucl.tex.
% Version 1.03 2020/01/09
% For distribution, see pstricks.tex.
%
/tx@EcldDict 40 dict def tx@EcldDict begin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Pi
/Pi 3.14159265359 def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% e
/E 2.718281828459045 def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x -> true (if |x| < 1E-6)
/ZeroEq { abs 1E-6 lt } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x1 y1 x2 y2 -> a b c (ax-by+c=0 with a^2+b^2=1)
/EqDr {
  4 copy 3 -1 roll sub 7 1 roll exch sub 5 1 roll 4 -1 roll
  mul 3 1 roll mul exch sub
  2 index dup mul 2 index dup mul add sqrt
  4 -1 roll 1 index div exch
  4 -1 roll 1 index div exch
  4 -1 roll 1 index div exch pop
} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% orthogonal projection of M1 onto (OM2)
%% x1 y1 x2 y2 -> x3 y3
/Project {
  2 copy dup mul exch dup mul add 5 1 roll 2 copy 5 -1 roll mul exch
  5 -1 roll mul add 4 -1 roll div dup 4 -1 roll mul exch 3 -1 roll mul
} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% a b c (ax2+bx+c=0) -> x1 y1
/SolvTrin {
  /c exch def /b exch def /a exch def
  b dup mul a c mul 4 mul sub dup 0 lt
  { pop 0 0 } %% no solutions
  {sqrt dup b neg add a 2 mul div exch b add neg 2 a mul div }
  ifelse } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x1 y1 x2 y2 -> Dist
/ABDist { 3 -1 roll sub dup mul 3 1 roll sub dup mul add sqrt } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x1 y1 x2 y2 -> x2-x1  y2-y1
/ABVect { 3 -1 roll exch sub 3 1 roll sub exch } bind def
%/ABVect { 3 -1 roll sub 3 1 roll exch sub exch } bind def  %% wrong version
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x1 y1 x2 y2 x3 y3 x4 y4 -> x y
/InterLines {
  EqDr /D1c exch def /D1b exch def /D1a exch def
  EqDr /D2c exch def /D2b exch def /D2a exch def
  D1a D2b mul D1b D2a mul sub dup ZeroEq
%   { pop pop pop 0 0 } %% parallel lines  % --- hv 20110714
   { pop 0 0 } %% parallel lines             --- hv 20110714
   {
    /Det exch def
    D1b D2c mul D1c D2b mul sub Det div
    D1a D2c mul D2a D1c mul sub Det div
   } ifelse  } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% a b c R -> x1 y1 x2 y2
/InterLineCircle {
  /CR exch def /Dc exch def neg /Db exch def /Da exch def
  ABVect /Vy exch def /Vx exch def
  %% Dc==0 then O belong to the line
  %% First project O on the line -> M (-ca;-cb)
  %% l'abscisse de M sur (OM) divisee par R donne le cosinus
  %Dc neg dup Db mul exch Da mul 2 copy 0 0
  %ABDist dup CR gt { pop pop pop 0 0 0 0 }
  %{ ZeroEq { pop pop Db Da } if Atan /alpha exch def
  Dc abs CR gt { 0 0 0 0 }
  { Db neg Da neg Atan /alpha exch def
  Dc CR div dup dup mul 1 exch sub sqrt exch Atan /beta exch def
  alpha beta add dup cos CR mul exch sin CR mul
  alpha beta sub dup cos CR mul exch sin CR mul
  4 copy ABVect Vy mul 0 le exch Vx mul 0 le and
  { 4 2 roll } if } ifelse
 } def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% R R' OO' -> x1 y1 x2 y2
/InterCircles {
  /OOP exch def /CRP exch def /CR exch def
  OOP dup mul CRP dup mul sub CR dup mul add OOP div 2 div
  dup dup mul CR dup mul exch sub dup
  0 lt { pop pop 0 0 0 0 } { sqrt 2 copy neg } ifelse
} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x y theta -> x' y' (rotation of theta)
/Rotate {
  dup sin /sintheta exch def cos /costheta exch def /y exch def /x exch def
  x costheta mul y sintheta mul sub
  y costheta mul x sintheta mul add
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% N -> x y
/GetNode {
  tx@NodeDict begin
    tx@NodeDict 1 index known { load GetCenter } { pop 0 0 } ifelse
  end
} bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x -> ch(x)
/ch { dup Ex exch neg Ex add 2 div } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x -> sh(x)
/sh { dup Ex exch neg Ex sub 2 div } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x -> e^(x)
/Ex { E exch exp } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% x f g -> x y n
/NewtonSolving {
  /g exch def /f exch def 0
  { %%% STACK: x0 n
    1 add exch %% one more loop
    dup ZeroEq
    { dup 0.0005 add fgeval
      1 index 0.0005 sub fgeval sub .001 div }
    { dup 1.0005 mul fgeval
      1 index 0.9995 mul fgeval sub .001 2 index mul div } ifelse  %%% STACK: n x0 fg'(x0)
    %%% compute x1=x0-fg(x0)/fg'(x0)
    1 index fgeval exch div dup 4 1 roll sub exch %% stack: dx x0 n
    3 -1 roll ZeroEq              %% exit if root found
    1 index 100 eq or { exit } if %% or looping for more than 100 times
  } loop
  dup 100 lt { exch dup /x exch def f } { pop 0 0 } ifelse
  3 -1 roll
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/fgeval { /x exch def f g sub } bind def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% calculate the line coefficents Ax+By+C=0
%% x1 y1 x2 y2 -> A B C
/LineCoefABC {
  0 index 3 index sub % A=y2-y1
  4 index 3 index sub % B=x1-x2
  3 index 5 index mul 6 index 4 index mul sub % C=x2y1-x1y2
  7 3 roll pop pop pop pop
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% calculate the 2-order determinant
%% |a11 a12|
%% |a21 a22|
%% a11 a12, a21 a22 -> X
/DeterminantTwo {
  4 1 roll mul 3 1 roll mul exch sub
} def
%% calculate the 3-order determinant
%% |a11 a12 a13|
%% |a21 a22 a23|
%% |a31 a32 a33|
%%   8   7   6    5   4   3    2   1   0
%% a11 a12 a13, a21 a22 a23, a31 a32 a33 -> X
/DeterminantThree {
  % |a22 a23, a32 a33| * (-1)^(1+1)a11
  8 index abs 1E-5 lt { %a11=0
    0
  } {
    4 index 4 index 3 index 3 index DeterminantTwo
    9 index mul
  } ifelse
  % |a12 a13, a32 a33| * (-1)^(1+2)a21
  6 index abs 1E-5 lt { %a12=0
    0 sub
  } {
    8 index 8 index 4 index 4 index DeterminantTwo
    7 index mul sub
  } ifelse
  % |a12 a13, a22 a23| * (-1)^(1+3)a31
  3 index abs 1E-5 lt { %a13=0
    0 add
  } {
    8 index 8 index 7 index 7 index DeterminantTwo
    4 index mul add
  } ifelse
  10 1 roll pop pop pop pop pop pop pop pop pop
} def
%% calculate the 4-order determinant
%% |a11 a12 a13 a14|
%% |a21 a22 a23 a24|
%% |a31 a32 a33 a34|
%% |a41 a42 a43 a44|
%%  15  14  13  12   11  10   9   8    7   6   5   4    3   2   1   0
%% a11 a12 a13 a14, a21 a22 a23 a24, a31 a32 a33 a34, a41 a42 a43 a44 -> X
/DeterminantFour {
  % |a22 a23 a24, a32 a33 a34, a42 a43 a44| * (-1)^(1+1)a11
  15 index abs 1E-5 lt { %a11=0
    0
  } {
    10 index 10 index 10 index 9 index 9 index 9 index 8 index 8 index 8 index DeterminantThree
    16 index mul
  } ifelse
  % |a12 a13 a14, a32 a33 a34, a42 a43 a44| * (-1)^(1+2)a21
  12 index abs 1E-5 lt { %a21=0
    0 sub
  } {
    15 index 15 index 15 index 10 index 10 index 10 index 9 index 9 index 9 index DeterminantThree
    13 index mul sub
  } ifelse
  % |a12 a13 a14, a22 a23 a24, a42 a43 a44| * (-1)^(1+3)a31
  8 index abs 1E-5 lt { %a31=0
    0 add
  } {
    15 index 15 index 15 index 14 index 14 index 14 index 9 index 9 index 9 index DeterminantThree
    9 index mul add
  } ifelse
  % |a12 a13 a14, a22 a23 a24, a32 a33 a34| * (-1)^(1+4)a41
  4 index abs 1E-5 lt { %a41=0
    0 sub
  } {
    15 index 15 index 15 index 14 index 14 index 14 index 13 index 13 index 13 index DeterminantThree
    5 index mul sub
  } ifelse
  17 1 roll pop pop pop pop pop pop pop pop
  pop pop pop pop pop pop pop pop
} def
%% calculate the 5-order determinant
%% |a11 a12 a13 a14 a15|
%% |a21 a22 a23 a24 a25|
%% |a31 a32 a33 a34 a35|
%% |a41 a42 a43 a44 a45|
%% |a51 a52 a53 a54 a55|
%%  24  23  22  21  20   19  18  17  16  15   14  13  12  11  10    9   8   7   6   5    4   3   2   1   0
%% a11 a12 a13 a14 a15, a21 a22 a23 a24 a25, a31 a32 a33 a34 a35, a41 a42 a43 a44 a45, a51 a52 a53 a54 a55-> X
/DeterminantFive {
  % |a22 a23 a24 a25, a32 a33 a34 a35, a42 a43 a44 a45, a52 a53 a54 a55| * (-1)^(1+1)a11
  24 index abs 1E-5 lt { %a11=0
    0
  } {
    18 index 18 index 18 index 18 index 17 index 17 index 17 index 17 index 16 index 16 index 16 index 16 index 15 index 15 index 15 index 15 index DeterminantFour
    25 index mul
  } ifelse
  % |a12 a13 a14 a15, a32 a33 a34 a35, a42 a43 a44 a45, a52 a53 a54 a55| * (-1)^(1+2)a21
  20 index abs 1E-5 lt { %a21=0
    0 sub
  } {
    24 index 24 index 24 index 24 index 18 index 18 index 18 index 18 index 17 index 17 index 17 index 17 index 16 index 16 index 16 index 16 index DeterminantFour
    21 index mul sub
  } ifelse
  % |a12 a13 a14 a15, a22 a23 a24 a25, a42 a43 a44 a45, a52 a53 a54 a55| * (-1)^(1+3)a31
  15 index abs 1E-5 lt { %a31=0
    0 add
  } {
    24 index 24 index 24 index 24 index 23 index 23 index 23 index 23 index 17 index 17 index 17 index 17 index 16 index 16 index 16 index 16 index DeterminantFour
    16 index mul add
  } ifelse
  % |a12 a13 a14 a15, a22 a23 a24 a25, a32 a33 a34 a35, a52 a53 a54 a55| * (-1)^(1+4)a41
  10 index abs 1E-5 lt { %a41=0
    0 sub
  } {
    24 index 24 index 24 index 24 index 23 index 23 index 23 index 23 index 22 index 22 index 22 index 22 index 16 index 16 index 16 index 16 index DeterminantFour
    11 index mul sub
  } ifelse
  % |a12 a13 a14 a15, a22 a23 a24 a25, a32 a33 a34 a35, a42 a43 a44 a45| * (-1)^(1+5)a51
  5 index abs 1E-5 lt { %a51=0
    0 add
  } {
    24 index 24 index 24 index 24 index 23 index 23 index 23 index 23 index 22 index 22 index 22 index 22 index 21 index 21 index 21 index 21 index DeterminantFour
    6 index mul add
  } ifelse
  26 1 roll pop pop pop pop pop pop pop pop pop pop
  pop pop pop pop pop pop pop pop pop pop
  pop pop pop pop pop
} def
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
% END ps-euclide.pro
