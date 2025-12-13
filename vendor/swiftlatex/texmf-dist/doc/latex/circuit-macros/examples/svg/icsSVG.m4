divert(-1)

   Macros defining some integrated circuits

define(`lg_pinsep',3*L_unit)  logic pin separation in logic units
define(`lg_chipwd',18*L_unit) default chip width

                     `A sequence of pins along the east or west side of a chip:
                      lg_pinseq(initial pin no,final pin no,
                                e|w,initial offset,pinnum_root,Labelroot,[not])'
define(`lg_pinseq',`for_($1,$2,1,
   `lg_pin( Chip.s`$3'+(0,eval($4+m4x)*lg_pinsep),
      $6`'m4x,Pin`'eval($5`'m4x),`$3'`$7',eval($5`'m4x))') ')

define(`ic6116',`[ Chip: box wid_ lg_chipwd ht_ 15*lg_pinsep
   lg_pin(Chip.sw_+(0,lg_pinsep),GND,Pin12,w,12)
   lg_pin(Chip.sw_+(0,2*lg_pinsep),,Pin18,wN,18)
   "svg_small(CS,75)" wid textht*1.5 at (Chip.w,last line) ljust
   { line right last "".wid from last "".nw+(1,0)*textoffset }

   lg_pinseq(0,2,w,4,9+,D)
   lg_pinseq(3,7,w,4,10+,D)
   lg_pin(Chip.sw_+(0,13*lg_pinsep),,Pin21,w,21)
   "svg_small(R/W,75)" wid textht*2.0 at (Chip.w,last line) ljust
   { line right last "".wid/2 from last "".n+(2,0)*textoffset }

   lg_pin(Chip.sw_+(0,14*lg_pinsep),V`'svg_small(CC,75),Pin24,w,24)
   lg_pin(Chip.se_+(0,lg_pinsep),,Pin20,eN,20)
   "svg_small(OE,75)" wid textht*1.5 at (Chip.e,last line) rjust
   { line left last "".wid from last "".ne+(-1,0)*textoffset }

   lg_pinseq(0,7,e,3,8-,A)
   lg_pinseq(8,9,e,3,31-,A)
   lg_pin(Chip.se_+(0,13*lg_pinsep),A10,Pin19,e,19)
    `$1']')

define(`ic6502',`[ Chip: box wid_ lg_chipwd ht_ 24*lg_pinsep
   lg_pin(Chip.sw_+(0,lg_pinsep),V`'svg_small(SS,75),Pin21,w,21)
   lg_pin(Chip.sw_+(0,2*lg_pinsep),V`'svg_small(SS,75),Pin1,w,1)
   lg_pin(Chip.sw_+(0,4*lg_pinsep),,Pin34,w,34)
   "svg_small(R/W,75)" wid textht*2.0 at (Chip.w,last line) ljust
   { line right last "".wid/2 from last "".n+(2,0)*textoffset }

   lg_pinseq(0,7,w,6,33-,D)
   lg_pin(Chip.sw_+(0,15*lg_pinsep),,Pin40,wN,40)
   "svg_small(RESET,75)" wid textht*3.8 at (Chip.w,last line) ljust
   { line right last "".wid from last "".nw+(1,0)*textoffset }

   lg_pin(Chip.sw_+(0,17*lg_pinsep),SYNC,Pin7,w,7)
   lg_pin(Chip.sw_+(0,19*lg_pinsep),,Pin6,wN,6)
   "svg_small(NMI,75)" wid textht*2.1 at (Chip.w,last line) ljust
   { line right last "".wid from last "".nw+(1,0)*textoffset }

   lg_pin(Chip.sw_+(0,21*lg_pinsep),RDY,Pin2,w,2)
   lg_pin(Chip.sw_+(0,22*lg_pinsep),SO,Pin38,w,38)
   lg_pin(Chip.sw_+(0,23*lg_pinsep),V`'svg_small(CC,75),Pin8,w,8)
   lg_pin(Chip.se_+(0,lg_pinsep),CK`'svg_small(1,75)(in),Pin39,e,39)
   lg_pin(Chip.se_+(0,4*lg_pinsep),CK`'svg_small(2,75)(out),Pin37,e,37)
   lg_pinseq(0,11,e,6,9+,A)
   lg_pinseq(12,15,e,6,10+,A)
   lg_pin(Chip.se+(0,23*lg_pinsep),,Pin4,eN,4)
   "svg_small(IRQ,75)" wid textht*2.0 at (Chip.e,last line) rjust
   { line left last "".wid from last "".ne+(-1,0)*textoffset }
    `$1']')

define(`ic6522',`[ Chip: box wid_ lg_chipwd ht_ 24*lg_pinsep
   lg_pin(Chip.sw_+(0,lg_pinsep),V`'svg_small(SS,75),Pin1,w,1)
   lg_pin(Chip.sw_+(0,3*lg_pinsep),CS1,Pin24,w,24)
   lg_pin(Chip.sw_+(0,4*lg_pinsep),CK,Pin25,w,25)
   lg_pin(Chip.sw_+(0,5*lg_pinsep),,Pin23,wN,23)
   "svg_small(CS2,75)" wid textht*2.2 at (Chip.w,last line) ljust
   { line right last "".wid from last "".nw+(1,0)*textoffset }

   lg_pin(Chip.sw_+(0,7*lg_pinsep),RS0(A0),Pin38,w,38)
   lg_pin(Chip.sw_+(0,8*lg_pinsep),RS1(A1),Pin37,w,37)
   lg_pin(Chip.sw_+(0,9*lg_pinsep),RS2(A2),Pin36,w,36)
   lg_pin(Chip.sw_+(0,10*lg_pinsep),RS3(A3),Pin35,w,35)
   lg_pinseq(0,7,w,12,33-,D)
   lg_pin(Chip.sw_+(0,21*lg_pinsep),,Pin22,w,22)
   "svg_small(R/W,75)" wid textht*2.0 at (Chip.w,last line) ljust
   { line right last "".wid/2 from last "".n+(2,0)*textoffset }

   lg_pin(Chip.sw_+(0,22*lg_pinsep),,Pin21,wN,21)
   "svg_small(IRQ,75)" wid textht*2.0 at (Chip.w,last line) ljust
   { line right last "".wid from last "".nw+(1,0)*textoffset }

   lg_pin(Chip.sw_+(0,23*lg_pinsep),V`'svg_small(CC,75),Pin20,w,20)
   lg_pinseq(0,7,e,1,10+,PB)
   lg_pinseq(1,2,e,8,17+,CB)
   lg_pinseq(0,7,e,12,2+,PA)
   lg_pinseq(1,2,e,19,41-,CA)
   lg_pin(Chip.se_+(0,23*lg_pinsep),,Pin34,eN,34)
   "svg_small(RESET,75)" wid textht*3.8 at (Chip.e,last line) rjust
   { line left last "".wid from last "".ne+(-1,0)*textoffset }

    `$1']')

define(`ic74LS138',`[ Chip: box wid_ lg_chipwd ht_ 11*lg_pinsep
   lg_pin(Chip.sw_+(0,lg_pinsep),GND,Pin8,w,8)
   lg_pin(Chip.sw_+(0,2*lg_pinsep),,Pin4,wN,4)
   "svg_small(G2a,75)" wid textht*2.0 at (Chip.w,last line) ljust
   { line right last "".wid from last "".nw+(1,0)*textoffset }

   lg_pin(Chip.sw_+(0,3*lg_pinsep),,Pin5,wN,5)
   "svg_small(G2b,75)" wid textht*2.0 at (Chip.w,last line) ljust
   { line right last "".wid from last "".nw+(1,0)*textoffset }

   lg_pin(Chip.sw_+(0,5*lg_pinsep),A,Pin1,w,1)
   lg_pin(Chip.sw_+(0,6*lg_pinsep),B,Pin2,w,2)
   lg_pin(Chip.sw_+(0,7*lg_pinsep),C,Pin3,w,3)
   lg_pin(Chip.sw_+(0,9*lg_pinsep),G1,Pin6,w,6)
   lg_pin(Chip.sw_+(0,10*lg_pinsep),V`'svg_small(CC,75),Pin16,w,16)
   lg_pinseq(0,6,e,2,15-,Y,n)
   lg_pin(Chip.se_+(0,9*lg_pinsep),Y7,Pin7,eN,7)
    `$1']')

divert(0)dnl
