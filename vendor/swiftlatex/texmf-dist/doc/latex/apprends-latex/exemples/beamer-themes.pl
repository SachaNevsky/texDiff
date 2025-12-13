#! /usr/pkg/bin/perl

use strict ;
use warnings ;

use IO::File ;

my @themes = qw( default AnnArbor Antibes Bergen Berkeley Berlin
	Boadilla CambridgeUS Copenhagen Darmstadt Dresden Frankfurt
	Goettingen Hannover Ilmenau JuanLesPins Luebeck Madrid
	Malmoe Marburg Montpellier PaloAlto Pittsburgh Rochester
	Singapore Szeged Warsaw ) ;
#boxes

# génération des fichiers de démonstration de chaque thème

foreach my $theme ( @themes )
{
   my $fichier ;

   $fichier = IO::File->new ( ) ;
   if ( $fichier->open ( ">beamer-theme-$theme-1.tex" ) )
   {
      print $fichier ( << "FIN" ) ;
\\documentclass{beamer}

\\usepackage[french]{babel}
\\usepackage[T1]{fontenc}
\\usepackage[utf8]{inputenc}
\\usepackage{lmodern}
\\usepackage{microtype}

\\usetheme{$theme}
\\setbeamercolor{background canvas}{bg=black!5}

\\title{Mon oncle Anatole}
\\subtitle{Sa vie, son œuvre}
\\author{Séraphin Lampion}
\\institute{Assurances Mondass}
\\date{23 octobre 2009}

\\begin{document}

\\begin{frame}

\\titlepage

\\end{frame}

\\end{document}
FIN

      $fichier->close ( ) ;
   }
   else
   {
      warn ( "Impossible d'ouvrir beamer-theme-$theme-1.tex en écriture : $!\n" ) ;
   }

   $fichier = IO::File->new ( ) ;
   if ( $fichier->open ( ">beamer-theme-$theme-2.tex" ) )
   {
      print $fichier ( << "FIN" ) ;
\\documentclass{beamer}

\\usepackage[french]{babel}
\\usepackage[T1]{fontenc}
\\usepackage[utf8]{inputenc}
\\usepackage{lmodern}
\\usepackage{microtype}

\\usetheme{$theme}
\\setbeamercolor{background canvas}{bg=black!5}

\\title{Mon oncle Anatole}
\\subtitle{Sa vie, son œuvre}
\\author{Séraphin Lampion}
\\institute{Assurances Mondass}
\\date{23 octobre 2009}

\\begin{document}

\\begin{frame}{Les meilleures histoires de mon oncle Anatole}

Mon oncle Anatole était coiffeur. Ah ! vous auriez dû le
connaître, celui-là... Un blagueur comme on n'en fait plus !
Toujours à raconter des histoires à se taper sur les cuisses...

Voici quelques-unes de ses histoires :

\\begin{itemize}

\\item celle qui se passe dans un train

\\item celle du monsieur qui entre dans un café et qui commande
       un verre de bière

\\end{itemize}

\\end{frame}

\\end{document}
FIN

      $fichier->close ( ) ;
   }
   else
   {
      warn ( "Impossible d'ouvrir beamer-theme-$theme-2.tex en écriture : $!\n" ) ;
   }
}

# génération du fichier permettant l'inclusion des exemples

my $fichier = IO::File->new ( ) ;
if ( $fichier->open ( '>beamer-themes.tex' ) )
{
   foreach my $theme ( @themes )
   {
      print $fichier ( << "FIN" ) ;
\\begin{figure}[!htbp]
\\centering
\\beamerdouble{beamer-theme-$theme-1.pdf}{beamer-theme-$theme-2.pdf}
\\caption{Exemple de présentation réalisée avec la classe
\\classe{beamer} et le thème \\theme{$theme}}
\\label{figure:beamer-$theme}
\\beamerthemeindex{$theme}
\\end{figure}

FIN
   }

   $fichier->close ( ) ;
}
else
{
   warn ( "Impossible d'ouvrir beamer-themes.tex en écriture : $!\n" ) ;
}
