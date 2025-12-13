% music sample in LilyPond notation

\version "2.18.2"

\header {
  title = "Music sample in LilyPond" 
  tagline = "" % no footer
}

\paper { left-margin = 0\cm }

\relative c' {
  \time 4/4
  \clef treble
  c4 d8 e f8 g a b | c4 b8 a g8 f e d |
  c8 g' e g c,8 g' e g | c,4 e c r \bar "|."
}
