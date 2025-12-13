% easy.bst
ENTRY { author title year} {} {}
FUNCTION {unpublished}{% Anfang function unpublished
  "\begin{unpublished}{" write$ cite$ write$ "}" write$ newline$
  " \textbf{" author * ", }" * write$ newline$
  " \emph{{}" title "}" * *      write$
  ", " year * "." *             write$ newline$
  "\end{unpublished}"              write$ newline$
} % Ende function unpublished
READ % Datenbank einlesen
ITERATE {call.type$}% alle Eintraege durchgehen
