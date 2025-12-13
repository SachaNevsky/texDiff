.PS
#Banking.m4

gen_init

  scale = 2.54                # use cm
  svg_font(Arial Black,11 bp__,2 bp__)
  boxwid = 6.8
  boxht = 4.5
  linethick_(1.5)

  define(`heading',
   `<tspan font-style=\"bold\" font-size=\"120%\" fill=\"white\">`$1'</tspan>')
  define(`subheading',
   `<tspan fill=\"white\" font-size=\"75%\" font-style=\"bold\">[`$1']</tspan>')
  define(`wtext',`<tspan fill=\"white\">`$1'</tspan>')

  C: circle diam 2.6 colored "mediumblue"
  Person: box rad boxht/4 colored "mediumblue" with .n at C.s+(0,C.rad/8) \
   "heading(Personal Banking)" \
   "" \
   "heading(Customer)" \
   "subheading(Person)" \
   "" \
   "wtext(A customer of the bank`,' with)" \
   "wtext(personal bank accounts.)"

  A1: arrow thick 1.5 dashed down 3.5 from Person.s
  svg_font(Arial,11 bp__,2 bp__)
  { box invis fill 1 ht 0.4 wid 1.0 "Uses" at A1 }
  command "</g>"
  Internet: box colored "steelblue" \
   "heading(Internet Banking System)" \
   "subheading(Software system)" \
   "" \
   "wtext(Allows customers to view)" \
   "wtext(information about their bank)" \
   "wtext(accounts`,' and make payments.)"

  svg_font(Arial,11 bp__,2 bp__)
  A2: arrow thick 1.5 dashed right 5.4 from Internet.e \
   "Sends e-mail" above "using" below
  command "</g>"
  Email: box colored "slategrey" \
   "heading(E-mail System)" \
   "subheading(Software system)" \
   "" \
   "wtext(Internal Microsoft Exchange)" \
   "wtext(e-mail system.)"

  A3:arrow thick 1.5 dashed from Email.nw+(0.4,0) to Person.se+(0.3,Person.ht/5)
  svg_font(Arial,11 bp__,2 bp__)
  { box invis fill 1 ht 0.4 wid 3.3 "Sends e-mails to" at A3 }
  command "</g>"

# etc  

  command "</g>" # font
.PE
