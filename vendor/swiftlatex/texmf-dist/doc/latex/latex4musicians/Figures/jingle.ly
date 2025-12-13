% Twelfth Street Rag

\version "2.18.2"
\header { tagline = "" } % no footer
\paper { left-margin = 0\cm }

music = \relative c' {
  \time 2/4 \key ees \major
  bes16 a bes c bes8-. r8 | bes16 a bes c bes8-. r8 |
  bes16 bes8 bes16 c8 d | ees4-. r4 |
}

\score {
  <<
    \new Staff { \clef "G_8" \music } % sheet music
    \new TabStaff { \tabFullNotation \music } % tablature
  >>
  \layout { }
  \midi { \tempo 4 = 128 }
}
