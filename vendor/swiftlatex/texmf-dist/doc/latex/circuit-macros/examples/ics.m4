divert(-1)

   Macros defining some integrated circuits

define(`lg_pinsep',3*L_unit)  logic pin separation in logic units
define(`lg_chipwd',18*L_unit) default chip width

                     `Chip outline sizes'
define(`chip_gen',` box invis wid lg_chipwd ht lg_pinsep*eval(`$1'/2+1)
  arcd(last box.n, lg_pinsep/2, 180, 360)
  { line to last box.ne chop -linewid bp__/2 }
  { line from last arc.start to last box.nw chop -linewid bp__/2 }
  line from last box.nw to last box.sw then to last box.se then to last box.ne
 ')

                     `A sequence of pins along the east or west side of a chip:
                      lg_pinseq(initial pin no,final pin no,
                                e|w,initial offset,pinnum_root,Labelroot,[not])'
lg_pinseq(1,8,w)
define(`lg_pinseq',`for_($1,$2,1,
   `lg_pin( Chip.s`$3'+(0,eval($4+m4x)*lg_pinsep),
      $6`'m4x,Pin`'eval($5`'m4x),`$3'`$7',eval($5`'m4x))') ')

define(`ic6116',`[ Chip: box wid_ lg_chipwd ht_ 15*lg_pinsep
   lg_pin(Chip.sw_+(0,lg_pinsep),GND,Pin12,w,12)
   lg_pin(Chip.sw_+(0,2*lg_pinsep),lg_bartxt(CS),Pin18,wN,18)
   lg_pinseq(0,2,w,4,9+,D)
   lg_pinseq(3,7,w,4,10+,D)
   lg_pin(Chip.sw_+(0,13*lg_pinsep),R/lg_bartxt(W),Pin21,w,21)
   lg_pin(Chip.sw_+(0,14*lg_pinsep),V\hbox{\tiny CC},Pin24,w,24)
   lg_pin(Chip.se_+(0,lg_pinsep),lg_bartxt(OE),Pin20,eN,20)
   lg_pinseq(0,7,e,3,8-,A)
   lg_pinseq(8,9,e,3,31-,A)
   lg_pin(Chip.se_+(0,13*lg_pinsep),A10,Pin19,e,19)
    `$1']')

define(`ic6502',`[ Chip: box wid_ lg_chipwd ht_ 24*lg_pinsep
   lg_pin(Chip.sw_+(0,lg_pinsep),V\hbox{\tiny SS},Pin21,w,21)
   lg_pin(Chip.sw_+(0,2*lg_pinsep),V\hbox{\tiny SS},Pin1,w,1)
   lg_pin(Chip.sw_+(0,4*lg_pinsep),R/lg_bartxt(W),Pin34,w,34)
   lg_pinseq(0,7,w,6,33-,D)
   lg_pin(Chip.sw_+(0,15*lg_pinsep),lg_bartxt(RESET),Pin40,wN,40)
   lg_pin(Chip.sw_+(0,17*lg_pinsep),SYNC,Pin7,w,7)
   lg_pin(Chip.sw_+(0,19*lg_pinsep),lg_bartxt(NMI),Pin6,wN,6)
   lg_pin(Chip.sw_+(0,21*lg_pinsep),RDY,Pin2,w,2)
   lg_pin(Chip.sw_+(0,22*lg_pinsep),SO,Pin38,w,38)
   lg_pin(Chip.sw_+(0,23*lg_pinsep),V\hbox{\tiny CC},Pin8,w,8)
   lg_pin(Chip.se_+(0,lg_pinsep),{\large$\phi$}\hbox{\tiny 1}(in),Pin39,e,39)
   lg_pin(Chip.se_+(0,4*lg_pinsep),
     {\large$\phi$}\hbox{\tiny 2}(out),Pin37,e,37)
   lg_pinseq(0,11,e,6,9+,A)
   lg_pinseq(12,15,e,6,10+,A)
   lg_pin(Chip.se+(0,23*lg_pinsep),lg_bartxt(IRQ),Pin4,eN,4)
    `$1']')

define(`ic6522',`[ Chip: box wid_ lg_chipwd ht_ 24*lg_pinsep
   lg_pin(Chip.sw_+(0,lg_pinsep),V\hbox{\tiny SS},Pin1,w,1)
   lg_pin(Chip.sw_+(0,3*lg_pinsep),CS1,Pin24,w,24)
   lg_pin(Chip.sw_+(0,4*lg_pinsep),{\large$\phi$},Pin25,w,25)
   lg_pin(Chip.sw_+(0,5*lg_pinsep),lg_bartxt(CS2),Pin23,wN,23)
   lg_pin(Chip.sw_+(0,7*lg_pinsep),RS0(A0),Pin38,w,38)
   lg_pin(Chip.sw_+(0,8*lg_pinsep),RS1(A1),Pin37,w,37)
   lg_pin(Chip.sw_+(0,9*lg_pinsep),RS2(A2),Pin36,w,36)
   lg_pin(Chip.sw_+(0,10*lg_pinsep),RS3(A3),Pin35,w,35)
   lg_pinseq(0,7,w,12,33-,D)
   lg_pin(Chip.sw_+(0,21*lg_pinsep),R/lg_bartxt(W),Pin22,w,22)
   lg_pin(Chip.sw_+(0,22*lg_pinsep),lg_bartxt(IRQ),Pin21,wN,21)
   lg_pin(Chip.sw_+(0,23*lg_pinsep),V\hbox{\tiny CC},Pin20,w,20)
   lg_pinseq(0,7,e,1,10+,PB)
   lg_pinseq(1,2,e,8,17+,CB)
   lg_pinseq(0,7,e,12,2+,PA)
   lg_pinseq(1,2,e,19,41-,CA)
   lg_pin(Chip.se_+(0,23*lg_pinsep),lg_bartxt(RESET),Pin34,eN,34)
    `$1']')

define(`ic74LS138',`[ Chip: box wid_ lg_chipwd ht_ 11*lg_pinsep
   lg_pin(Chip.sw_+(0,lg_pinsep),GND,Pin8,w,8)
   lg_pin(Chip.sw_+(0,2*lg_pinsep),lg_bartxt(G2a),Pin4,wN,4)
   lg_pin(Chip.sw_+(0,3*lg_pinsep),lg_bartxt(G2b),Pin5,wN,5)
   lg_pin(Chip.sw_+(0,5*lg_pinsep),A,Pin1,w,1)
   lg_pin(Chip.sw_+(0,6*lg_pinsep),B,Pin2,w,2)
   lg_pin(Chip.sw_+(0,7*lg_pinsep),C,Pin3,w,3)
   lg_pin(Chip.sw_+(0,9*lg_pinsep),G1,Pin6,w,6)
   lg_pin(Chip.sw_+(0,10*lg_pinsep),V\hbox{\tiny CC},Pin16,w,16)
   lg_pinseq(0,6,e,2,15-,Y,n)
   lg_pin(Chip.se_+(0,9*lg_pinsep),Y7,Pin7,eN,7)
    `$1']')

define(`ic4017',`[ Chip: chip_gen(16)
  Loopover_(`x',
   `lg_pin(Chip.nw-(0,lg_pinsep*m4Lx),x,Pin`'m4Lx,w,m4Lx)',
    PL, Q3, I3, I0, CLE, Q0, TC, GND)
  Loopover_(`x',
   `lg_pin(Chip.se+(0,lg_pinsep*m4Lx),x,Pin`'eval(m4Lx+8),e,eval(m4Lx+8))',
    MR, U/D, Q1, I1, I2, Q2, CLK, Vcc)
   `$1']')

define(`ic4510',`[ Chip: chip_gen(16)
  Loopover_(`x',
   `lg_pin(Chip.nw-(0,lg_pinsep*m4Lx),x,Pin`'m4Lx,w,m4Lx)',
    PL, Q3, I3, I0, CLE, Q0, TC, GND)
  Loopover_(`x',
   `lg_pin(Chip.se+(0,lg_pinsep*m4Lx),x,Pin`'eval(m4Lx+8),e,eval(m4Lx+8))',
    MR, U/D, Q1, I1, I2, Q2, CLK, Vcc)
   `$1']')

define(`icVS1053',`[ Chip: chip_gen(32)
  Loopover_(`x',
   `lg_pin(Chip.nw-(0,lg_pinsep*m4Lx),x,Pin`'m4Lx,w,m4Lx)',
    LOUT,ROUT,GBUF,AGND,AGND,DREG,Vcc,3V3,GND,MISO,MOSI,sclk,RST,CS,DCS,DCS)
  Loopover_(`x',
   `lg_pin(Chip.se+(0,lg_pinsep*m4Lx),x,Pin`'eval(m4Lx+16),e,eval(m4Lx+16))',
    SDCD,RX,TX,7,6,5,4,3,2,1,0,GND,3V3,AGND,MIC-,MIC+)
   `$1']')

divert(0)dnl
