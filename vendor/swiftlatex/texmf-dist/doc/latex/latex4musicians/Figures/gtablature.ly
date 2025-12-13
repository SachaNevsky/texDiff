\version "2.18.2"
\header {
tagline = "" % no footer
}

\paper { left-margin = 0\cm }

notes = {
  \time 3/4
  c4 d e f g a b a b c'2 r4
}

\score {
  <<
    \new TabStaff { \notes }
  >>
}
