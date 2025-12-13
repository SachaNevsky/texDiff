% shave.ly

\version "2.18.2"
\header { tagline = "" } % no footer
\paper { left-margin = 0\cm }

music = \relative c' {
  \time 4/4
  c4^"Scherzando" g8 g aes4 g | r4 b4-> c-> r4 |
}

\score {
  <<
    \new Staff { \clef "G_8" \music }
    \new TabStaff { \music }
  >>
}
