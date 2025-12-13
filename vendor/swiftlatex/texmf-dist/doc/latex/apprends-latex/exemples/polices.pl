#! /usr/pkg/bin/perl

use strict ;
use warnings ;

use IO::File ;

my @polices_avec_math =
(
   [ 'anttor'		, 'math'	, 'Antykwa Toruńska'				] ,
   [ 'arev'		, ''		, 'Arev Sans (Bitstream Vera Sans)'		] ,
   [ 'ccfonts'		, ''		, 'Concrete'					] ,
   [ 'cmbright'		, ''		, 'Computer Modern Bright'			] ,
   [ 'fourier'		, ''		, 'Fourier-GUT\textit{enberg} (Adobe Utopia)'	] ,
   [ 'fouriernc'	, ''		, 'New Century Schoolbook'			] ,
   [ 'gfsartemisia'	, ''		, 'Greek Font Society Artemisia'		] ,
   [ 'iwona'		, 'math'	, 'Iwona'					] ,
   [ 'kpfonts'		, ''		, 'Kp-Fonts'					] ,
   [ 'kurier'		, 'math'	, 'Kurier'					] ,
   [ 'lmodern'		, ''		, 'Latin Modern'				] ,
   [ 'mathdesign'	, 'charter'	, 'Bitstream Charter'				] ,
   [ 'mathdesign'	, 'utopia'	, 'Adobe Utopia'				] ,
   [ 'mathpazo'		, ''		, 'Adobe Palatino'				] ,
   [ 'mathptmx'		, ''		, 'Times'					] ,
) ;

my @polices_complementaires =
(
   [ 'avant'		, 'Avant Garde'		, 'textsf'	] ,
   [ 'helvet'		, 'Helvetica'		, 'textsf'	] ,
   [ 'tgadventor'	, '\TeX\ Gyre Adventor'	, 'textsf'	] ,
   [ 'tgheros'		, '\TeX\ Gyre Heros'	, 'textsf'	] ,
   [ 'courier'		, 'Courier'		, 'texttt'	] ,
   [ 'inconsolata'	, 'Inconsolata'		, 'texttt'	] ,
   [ 'tgcursor'		, '\TeX\ Gyre Cursor'	, 'texttt'	] ,
) ;

my @polices_sans_math =
(
   [ 'bera'		, 'Bera'			] ,
   [ 'bookman'		, 'Bookman'			] ,
   [ 'chancery'		, 'Zapf Chancery'		] ,
   [ 'charter'		, 'Charter'			] ,
   [ 'cyklop'		, 'Cyklop'			] ,
   [ 'libertine'	, 'Linux Libertine'		] ,
   [ 'newcent'		, 'New Century Schoolbook'	] ,
   [ 'tgbonum'		, '\TeX\ Gyre Bonum'		] ,
   [ 'tgchorus'		, '\TeX\ Gyre Chorus'		] ,
   [ 'tgpagella'	, '\TeX\ Gyre Pagella'		] ,
   [ 'tgschola'		, '\TeX\ Gyre Schola'		] ,
   [ 'tgtermes'		, '\TeX\ Gyre Termes'		] ,
) ;

# génération des fichiers de démonstration de chaque police

foreach my $police ( @polices_avec_math )
{
   my $nom = ( $police->[1] eq '' ) ? "police-$police->[0].tex" :
                                      "police-$police->[0]-$police->[1].tex" ;
   my $fichier ;

   $fichier = IO::File->new ( ) ;
   if ( $fichier->open ( ">$nom" ) )
   {
      print $fichier ( << "FIN" ) ;
\\documentclass{article}

\\usepackage[french]{babel}
\\usepackage[T1]{fontenc}
\\usepackage[utf8]{inputenc}
FIN

      if ( $police->[1] ne '' )
      {
         print $fichier "\\usepackage[$police->[1]]{$police->[0]}\n" ;
      }
      else
      {
         print $fichier "\\usepackage{$police->[0]}\n" ;
      }

      print $fichier ( << "FIN" ) ;
\\usepackage{microtype}

\\usepackage[margin=3mm,paperwidth=12cm,paperheight=4cm]{geometry}

\\pagestyle{empty}

\\begin{document}

Patricia, mon petit, je ne voudrais pas te paraître vieux jeu et
encore moins grossier... L'homme de la pampa parfois rude, reste
toujours courtois... Mais la vérité m'oblige à te le dire : ton
Antoine commence à me les briser menu !

\\bigskip

\\[
\\sum_{n=1}^{+\\infty} \\frac{1}{n^2} = \\frac{\\pi^2}{6}
\\qquad
\\int_a^b \\frac{x}{\\sqrt{x^2-1}} \\,\\mathrm{d}x
	= \\sqrt{b^2-1} - \\sqrt{a^2-1}
\\]

\\end{document}
FIN

      $fichier->close ( ) ;
   }
   else
   {
      warn ( "Impossible d'ouvrir $nom en écriture : $!\n" ) ;
   }
}

foreach my $police ( @polices_complementaires )
{
   my $fichier ;

   $fichier = IO::File->new ( ) ;
   if ( $fichier->open ( ">police-$police->[0].tex" ) )
   {
      print $fichier ( << "FIN" ) ;
\\documentclass{article}

\\usepackage[french]{babel}
\\usepackage[T1]{fontenc}
\\usepackage[utf8]{inputenc}
\\usepackage{$police->[0]}
\\usepackage{microtype}

FIN

      if ( $police->[2] eq 'texttt' )
      {
      print $fichier ( << "FIN" ) ;
\\usepackage[margin=3mm,right=1cm,paperwidth=12cm,paperheight=2.7cm]{geometry}
FIN
      }
      else
      {
      print $fichier ( << "FIN" ) ;
\\usepackage[margin=3mm,paperwidth=12cm,paperheight=2.7cm]{geometry}
FIN
      }

      print $fichier ( << "FIN" ) ;

\\pagestyle{empty}

\\begin{document}

\\$police->[2]
{
Patricia, mon petit, je ne voudrais pas te paraître vieux jeu et
encore moins grossier... L'homme de la pampa parfois rude, reste
toujours courtois... Mais la vérité m'oblige à te le dire : ton
Antoine commence à me les briser menu !
}

\\end{document}
FIN

      $fichier->close ( ) ;
   }
   else
   {
      warn ( "Impossible d'ouvrir police-$police->[0].tex en écriture : $!\n" ) ;
   }
}

foreach my $police ( @polices_sans_math )
{
   my $fichier ;

   $fichier = IO::File->new ( ) ;
   if ( $fichier->open ( ">police-$police->[0].tex" ) )
   {
      print $fichier ( << "FIN" ) ;
\\documentclass{article}

\\usepackage[french]{babel}
\\usepackage[T1]{fontenc}
\\usepackage[utf8]{inputenc}
\\usepackage{$police->[0]}
\\usepackage{microtype}

\\usepackage[margin=3mm,paperwidth=12cm,paperheight=3.1cm]{geometry}

\\pagestyle{empty}

\\begin{document}

Patricia, mon petit, je ne voudrais pas te paraître vieux jeu et
encore moins grossier... L'homme de la pampa parfois rude, reste
toujours courtois... Mais la vérité m'oblige à te le dire : ton
Antoine commence à me les briser menu !

\\end{document}
FIN

      $fichier->close ( ) ;
   }
   else
   {
      warn ( "Impossible d'ouvrir police-$police->[0].tex en écriture : $!\n" ) ;
   }
}

# cas particulier : eulervm

my $fichier ;

$fichier = IO::File->new ( ) ;
if ( $fichier->open ( '>police-eulervm.tex' ) )
{
   print $fichier ( << "FIN" ) ;
\\documentclass{article}

\\usepackage[french]{babel}
\\usepackage[T1]{fontenc}
\\usepackage[utf8]{inputenc}
\\usepackage{eulervm}
\\usepackage{microtype}

\\usepackage[margin=3mm,paperwidth=12cm,paperheight=3cm]{geometry}

\\pagestyle{empty}

\\begin{document}

\\[
\\sum_{n=1}^{+\\infty} \\frac{1}{n^2} = \\frac{\\pi^2}{6}
\\qquad
\\int_a^b \\frac{x}{\\sqrt{x^2-1}} \\,\\mathrm{d}x
	= \\sqrt{b^2-1} - \\sqrt{a^2-1}
\\]

\\end{document}
FIN

   $fichier->close ( ) ;
}
else
{
   warn ( "Impossible d'ouvrir police-eulervm.tex en écriture : $!\n" ) ;
}

# génération des fichiers permettant l'inclusion des exemples

$fichier = IO::File->new ( ) ;
if ( $fichier->open ( '>polices-avec-math.tex' ) )
{
   print $fichier ( << 'FIN' ) ;
\begin{table}[!p]
\centering
\begin{tabular}{cclc}
\toprule
\textbf{Extension}				&
\textbf{Option}					&
\multicolumn{1}{c}{\textbf{Nom de la police}}	&
\textbf{Figure}					\\
\midrule
FIN

   foreach my $police ( @polices_avec_math )
   {
      my $label = "figure:police-$police->[0]" ;
      if ( $police->[1] ne '' )
      {
         $label = $label . "-$police->[1]" ;
      }

      print $fichier ( << "FIN" ) ;
\\extensionindex{$police->[0]}	& \\extensionoption{$police->[1]}	& $police->[2]	& \\ref{$label}	\\\\
FIN
   }

   print $fichier ( << 'FIN' ) ;
\bottomrule
\end{tabular}
\caption{Extensions permettant de déterminer la police de
caractères (avec mode mathématique)}
\label{tableau:polices-avec-math}
\end{table}

FIN

   foreach my $police ( @polices_avec_math )
   {
      my $pdf = "police-$police->[0]" ;
      my $caption = "Exemple de document réalisé avec l'extension \\extension{$police->[0]}" ;
      my $label = "figure:police-$police->[0]" ;
      if ( $police->[1] ne '' )
      {
         $pdf = $pdf   . "-$police->[1]" ;
         $caption = $caption . " (option \\extensionoption{$police->[1]})" ;
         $label = $label . "-$police->[1]" ;
      }

      print $fichier ( << "FIN" ) ;
\\begin{figure}[!p]
\\centering
\\setlength{\\fboxsep}{1pt}
\\fbox{\\includegraphics{$pdf.pdf}}
%\\index{$police->[0]@\\extension{$police->[0]} (extension)}
\\caption{$caption}
\\label{$label}
\\end{figure}

FIN
   }

   $fichier->close ( ) ;
}
else
{
   warn ( "Impossible d'ouvrir polices-avec-math.tex en écriture : $!\n" ) ;
}

my $precedent = '' ;

$fichier = IO::File->new ( ) ;
if ( $fichier->open ( '>polices-complementaires.tex' ) )
{
   print $fichier ( << 'FIN' ) ;
\begin{table}[!p]
\centering
\begin{tabular}{clcc}
\toprule
\textbf{Extension}				&
\multicolumn{1}{c}{\textbf{Nom de la police}}	&
\textbf{Commande}				&
\textbf{Figure}					\\
\midrule
FIN

   foreach my $police ( @polices_complementaires )
   {
      if ( $precedent eq 'textsf' and $police->[2] eq 'texttt' )
      {
         print $fichier "\\midrule\n" ;
      }

      print $fichier ( << "FIN" ) ;
\\extensionindex{$police->[0]}	& $police->[1]	&	\\commande{$police->[2]}	& \\ref{figure:police-$police->[0]}	\\\\
FIN

      $precedent = $police->[2] ;
   }

   print $fichier ( << 'FIN' ) ;
\bottomrule
\end{tabular}
\caption{Extensions permettant de déterminer une police de
caractères complémentaire}
\label{tableau:polices-complementaires}
\end{table}

FIN

   foreach my $police ( @polices_complementaires )
   {
      print $fichier ( << "FIN" ) ;
\\begin{figure}[!p]
\\centering
\\setlength{\\fboxsep}{1pt}
\\fbox{\\includegraphics{police-$police->[0].pdf}}
%\\index{$police->[0]@\\extension{$police->[0]} (extension)}
\\caption{Exemple de document réalisé avec l'extension \\extension{$police->[0]}}
\\label{figure:police-$police->[0]}
\\end{figure}

FIN
   }

   $fichier->close ( ) ;
}
else
{
   warn ( "Impossible d'ouvrir polices-complementaires.tex en écriture : $!\n" ) ;
}

$fichier = IO::File->new ( ) ;
if ( $fichier->open ( '>polices-sans-math.tex' ) )
{
   print $fichier ( << 'FIN' ) ;
\begin{table}[!p]
\centering
\begin{tabular}{clc}
\toprule
\textbf{Extension}				&
\multicolumn{1}{c}{\textbf{Nom de la police}}	&
\textbf{Figure}					\\
\midrule
FIN

   foreach my $police ( @polices_sans_math )
   {
      print $fichier ( << "FIN" ) ;
\\extensionindex{$police->[0]}	& $police->[1]	& \\ref{figure:police-$police->[0]}	\\\\
FIN
   }

   print $fichier ( << 'FIN' ) ;
\bottomrule
\end{tabular}
\caption{Extensions permettant de déterminer la police de
caractères (sans mode mathématique)}
\label{tableau:polices-sans-math}
\end{table}

FIN

   foreach my $police ( @polices_sans_math )
   {
      print $fichier ( << "FIN" ) ;
\\begin{figure}[!pt]
\\centering
\\setlength{\\fboxsep}{1pt}
\\fbox{\\includegraphics{police-$police->[0].pdf}}
%\\index{$police->[0]@\\extension{$police->[0]} (extension)}
\\caption{Exemple de document réalisé avec l'extension \\extension{$police->[0]}}
\\label{figure:police-$police->[0]}
\\end{figure}

FIN
   }

   $fichier->close ( ) ;
}
else
{
   warn ( "Impossible d'ouvrir polices-avec-math.tex en écriture : $!\n" ) ;
}
