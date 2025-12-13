divert(-1)
   svg.m4                       Initialization for SVG output.

* Circuit_macros Version 9.2, copyright (c) 2020 J. D. Aplevich under      *
* the LaTeX Project Public Licence in file Licence.txt. The files of       *
* this distribution may be redistributed or modified provided that this    *
* copyright notice is included and provided that modifications are clearly *
* marked to distinguish them from this distribution.  There is no warranty *
* whatsoever for these files.                                              *

define(`m4picprocessor',dpic)
define(`m4postprocessor',svg)
                                Default is to produce svg for web documents
ifdef(`m4textprocessor',,`define(`m4textprocessor',xml)')

ifdef(`libgen_',,`include(libgen.m4)divert(-1)')dnl

# The following definitions are still subject to change.
# The use of changecom may cause difficulty for non-GNU m4.
# ---------------------------------------------------------------------------#
#
# If either nosvgformat or Inkscape is defined then the svg formatting
# macros are turned off.  Text formatting can then be done in Inkscape.

dnl Put define(`Inkscape') in the source for Inkscape input
ifelse(ifdef(`Inkscape',T)`'ifdef(`nosvgformat',T),T,
`define(`svg_it',`$1')
define(`svg_tt',`$1')
define(`svg_norm',`$1')
define(`svg_bf',`$1')
define(`svg_small',`$1')
define(`svg_fsize',`$1')
define(`svg_sub',`$1')
define(`svg_sup',`$1')
define(`svg_font',`$1')
define(`svg_symbol',`$1')
define(`svg_micro',`$1')
define(`svg_ohm',`$1')
define(`svg_lt',`$1')
define(`svg_gt',`$1')
',
`define(`svg_tspan',`patsubst(<tspan `$1'
>`$2'</tspan>,",\\")')
define(`svg_font',`
command "<g patsubst(ifelse(`$1',,,
index(`$1',font),0,`$1',
index(`$1',style),0,`$1',
style="font-family:`$1'")
,",\\")>"
  ifelse(`$2',,,`textht=(`$2')*dptextratio; ')dnl
  ifelse(`$3',,,`textoffset=`$3'; ')dnl
  `$4'
  ifelse(`$4',,,`command "</g>"')')
`e.g. svg_font(Times) 
      svg_font(Times,11bp__,1bp__,"text" at A) 
      svg_font(font-family="Times")
      svg_font(font-family="Times" font-style="italic")
      svg_font(style="font-family:Times; font-style:italic")
Some fairly safe choices: Arial, Helvetica, Times, Courier, Verdana, Georgia,
  Palatino, Garamond, Bookman, Cursive, Trebuchet MS, Arial Black, Impact.
'
`see http://www.ascii.cl/htmlcodes.htm
 and http://webdesign.about.com/od/localization/l/blhtmlcodes-gr.htm'
define(`svg_symbol',`changecom(,)`$1'changecom(`#',)')
define(`svg_it',`<tspan font-style=\"italic\">`$1'</tspan>')
define(`svg_tt',`<tspan font-family=\"Courier\">`$1'</tspan>')
define(`svg_norm',`<tspan font-style=\"normal\">`$1'</tspan>')
define(`svg_bf',`<tspan font-style=\"bold\">`$1'</tspan>')

dnl To get %% in a sprintf string, set the size explicitly,
dnl  eg sprintf("x`'svg_sub(%g,50%)",i)

define(`svg_small',`svg_fsize(`$1',ifelse(`$2',,66,`$2'))')
define(`svg_fsize',`<tspan font-size=\"ifelse(`$2',,100,`$2')%\">`$1'</tspan>')

dnl This is black magic but seems necessary to work with Firefox
dnl Arg 2: size of subscript font in percent
dnl Arg 3: vertical shift, e.g. svg_sub(1,,0.5ex) 
dnl Arg 4 shifts the subscript horizontally e.g., svg_sup(1,,,-0.5ex)
define(`svg_sup',`<tspan font-size=\"ifelse(`$2',,70,`$2')%\"
 dy=\"-ifelse(`$3',,1.5ex,`$3')\" dx=\"ifelse(`$4',,,`$4')\">`$1'</tspan><tspan
 font-size=\"ifelse(`$2',,70,`$2')%\" dy=\"ifelse(`$3',,1.5ex,`$3')\"
 dx=\"-0.5ex\"> </tspan>')dnl note the space

dnl This is black magic but seems necessary to work with Firefox
dnl Arg 2: size of subscript font in percent
dnl Arg 3: vertical shift, e.g. svg_sub(1,,0.5ex) 
dnl Arg 4 shifts the subscript horizontally
define(`svg_sub',`<tspan font-size=\"ifelse(`$2',,70,`$2')%\"
 dy=\"ifelse(`$3',,0.66ex,`$3')\" dx=\"ifelse(`$4',,,`$4')\">`$1'</tspan><tspan
 font-size=\"ifelse(`$2',,70,`$2')%\" dy=\"-ifelse(`$3',,0.66ex,`$3')\"
 dx=\"-0.5ex\"> </tspan>')dnl note the space

define(`svg_alpha',`svg_symbol(&`#'945;)')
define(`svg_beta',`svg_symbol(&`#'946;)')
define(`svg_chi',`svg_symbol(&`#'967;)')
define(`svg_comma',`svg_symbol(&`#'44;)')
define(`svg_Delta',`svg_symbol(&`#'916;)')
define(`svg_delta',`svg_symbol(&`#'948;)')
define(`svg_epsilon',`svg_symbol(&`#'949;)')
define(`svg_eta',`svg_symbol(&`#'951;)')
define(`svg_Gamma',`svg_symbol(&`#'915;)')
define(`svg_gamma',`svg_symbol(&`#'947;)')
define(`svg_iota',`svg_symbol(&`#'953;)')
define(`svg_kappa',`svg_symbol(&`#'954;)')
define(`svg_Lambda',`svg_symbol(&`#'923;)')
define(`svg_lambda',`svg_symbol(&`#'955;)')
define(`svg_micro',`svg_symbol(&`#'956;`$1')')
define(`svg_mu',`svg_symbol(&`#'956;)')
define(`svg_nu',`svg_symbol(&`#'957;)')
define(`svg_ohm',`svg_symbol(&`#'937;)')
define(`svg_Omega',`svg_symbol(&`#'937;)')
define(`svg_omega',`svg_symbol(&`#'969;)')
define(`svg_Phi',`svg_symbol(&`#'934;)')
define(`svg_phi',`svg_symbol(&`#'966;)')
define(`svg_Pi',`svg_symbol(&`#'928;)')
define(`svg_pi',`svg_symbol(&`#'960;)')
define(`svg_Psi',`svg_symbol(&`#'936;)')
define(`svg_psi',`svg_symbol(&`#'968;)')
define(`svg_rho',`svg_symbol(&`#'961;)')
define(`svg_Sigma',`svg_symbol(&`#'931;)')
define(`svg_sigma',`svg_symbol(&`#'963;)')
define(`svg_tau',`svg_symbol(&`#'964;)')
define(`svg_Theta',`svg_symbol(&`#'920;)')
define(`svg_theta',`svg_symbol(&`#'952;)')
define(`svg_upsilon',`svg_symbol(&`#'965;)')
define(`svg_Xi',`svg_symbol(&`#'926;)')
define(`svg_xi',`svg_symbol(&`#'958;)')
define(`svg_zeta',`svg_symbol(&`#'950;)')
define(`svg_lt',`svg_symbol(&`#'60;)')
define(`svg_gt',`svg_symbol(&`#'62;)')
define(`svg_leq',`svg_symbol(&`#'8804;)')
define(`svg_geq',`svg_symbol(&`#'8805;)')
define(`svg_prime',`svg_symbol(&`#'8242;)')
define(`svg_ensp',`svg_symbol(&`#'8194;)')
define(`svg_emsp',`svg_symbol(&`#'8195;)')
define(`svg_thinsp',`svg_symbol(&`#'8201;)')
define(`svg_backsl',`svg_symbol(&`#'92;)')
')

define(`svgcolor',`sprintf("rgb(%g,%g,%g)",\
round_(`$1'),round_(`$2'),round_(`$3'))')

# Obsolete but kept for compatibility.  Use `rgbstring(r,g,b)'
define(`svgcolor255',
 `svgcolor(round_((`$1')*255),round_((`$2')*255),round_((`$3')*255))')

define(`svgLink',`command "<a xlink:href=\"`$1'\"dnl
  ifelse(`$3',,`target=\"_blank\"',`$3',B,,`$3')>
  <g stroke=\"rgb(0,0,255)\">"
  `$2'
  command "</g></a>"')
define(`svgLinkString',`"<a xlink:href=\"`$1'\"dnl
  ifelse(`$3',,`target=\"_blank\"',`$3',B,,`$3') dnl
  stroke=\"rgb(0,0,255)\">dnl
 `$2' dnl
  </a>"')

#                           svgrot_init(filename)
#                           filename is the basename of the output
#                           produced by dpic -v filename.pic > filename.svg
define(`svgrot_init',`NeedDpicTools
 define(`_file_',ifelse(`$1',,patsubst(__file__,.m4),`$1'))
 syscmd(touch _file_.svg _file_.cor; cp _file_.svg _file_.tmp)
 sh "grep \"^ x=.*\/text>\" _file_.tmp | sed -e dnl
   \"s/x=\\"\([0-9.]*\)\\" y=\\"\([0-9.]*\)\\".*/\1 \2/\" > _file_.cor" 
 svgrot_k = 0; svg_rotz = 0
 define svg_rotcoords { svgrot_k += 1
  if "$`'1" != "" then { x[svgrot_k] = $`'1; y[svgrot_k] = $`'2; svg_rotz = 1 }
  }
 copythru(svg_rotcoords, _file_.cor)
 sh "rm -f _file_.tmp _file_.cor"
 svg_rotk = 0

 ifdef(`svg_rot_',,`
#                          `svg_rot(deg clockwise rotation,text or object) 
#                           Requires svgrot_init(filename)
#                           Rotation of svg text is a can of worms because
#                           the final coordinates of the text are required;
#                           this forward reference has to be extracted from
#                           the output file and the source processed twice.'
 define svg_rot { if svg_rotz then { svg_rotk += 1; command \
   sprintf("<g transform=\"rotate(%g %g %g)\">",$`'1,x[svg_rotk],y[svg_rotk]) }\
   else { command sprintf("<g transform=\"rotate(%g)\">",$`'1) }
$`'2
 command "</g>" }
 define(`svg_rot_') ')
 ')

# ---------------------------------------------------------------------------#

define(`thinlines_',`linethick = 0.4
  arrowwid = 0.04*scale; arrowht = 0.2/3*scale')
define(`thicklines_',`linethick = 0.8
  arrowwid = 0.05*scale; arrowht = 0.1*scale')
                                `linethick_(x) set line width to x pt'
define(`linethick_',`linethick = ifelse(`$1',,`0.8',`$1'); dnl
  arrowwid = ifelse(`$1',,`0.05',linethick/16)*scale; dnl
  arrowht = ifelse(`$1',,`0.1',linethick/8)*scale;')

divert(0)dnl
