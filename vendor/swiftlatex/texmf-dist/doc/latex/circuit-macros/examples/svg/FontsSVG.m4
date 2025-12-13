.PS
# FontsSVG.m4
gen_init
  textht = 0.2

define(`ft',`{ svg_font(`$1',`$2',`$3',"`$1'")}; move down 0.5; right_')

B: box wid 4 ht 7 
  move to B.nw+(2,-0.5)

  ft(Arial)
  ft(Helvetica)
  ft(Times)
  ft(Courier)
  ft(Cursive)
  ft(Verdana)
  ft(Georgia)
  ft(Palatino)
  ft(Garamond)
  ft(Bookman)
# ft(Comic Sans MS)
  ft(Trebuchet MS)
  ft(Arial Black)
  ft(Impact)

  textht = 0.1
  "These may be vewer-dependent" above ljust at B.sw
.PE
