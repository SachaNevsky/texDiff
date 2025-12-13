.PS
# `Grounds.m4'
cct_init

sep = 0.65
Ground: ground
   move right sep
GT: ground(,T)
   move right sep
GF: ground(,,F)
   move right sep
GE: ground(,,E)
   move right sep

B: Here+(0,-0.5) ; {
   "{\tt `ground'}" wid 32bp__ at (Ground,B)
   "{\tt `ground'(,T)}" at (GT,B)+(0,7bp__)
   "{\tt (,{,}F)}" at (GF,B)
   "{\tt (,{,}E)}" at (GE,B)}


GS: ground(,,S)
   move right sep
GS90: [ground(,,S,90) ] with .n at Here
   move right sep from GS90.n
GQ: ground(,,Q)
   move right sep
GL: ground(,,L)
   move right sep
GP: ground(,,P)

C: Here+(0,-0.5)
   "{\tt (,{,}S)}" at (GS,C)
   "{\tt (,{,}S,90)}" at (GS90,C)
   "{\tt (,{,}Q)}" at (GQ,C)
   "{\tt (,{,}L)}" at (GL,C)
   "{\tt (,{,}P)}" at (GP,C)

.PE
