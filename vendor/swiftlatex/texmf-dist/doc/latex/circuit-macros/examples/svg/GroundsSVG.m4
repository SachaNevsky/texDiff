.PS
# `GroundsSVG.m4'
cct_init(svg_font(sans-serif,11bp__))

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
   "`ground'" wid 36bp__ at (Ground,B)
   "`ground'(,T)" at (GT,B)+(0,12bp__)
   "(,,F)" at (GF,B)
   "(,,E)" at (GE,B)}


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
   "(,,S)" at (GS,C)
   "(,,S,90)" at (GS90,C)
   "(,,Q)" at (GQ,C)
   "(,,L)" at (GL,C)
   "(,,P)" at (GP,C)

 command "</g>" # end font
.PE
