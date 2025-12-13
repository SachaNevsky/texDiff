
\version "2.18.2"
% automatically converted by musicxml2ly from abctab.xml

\header {
    encoder = "abc2xml version 218"
    encodingdate = "2018-12-22"
    }

\layout {
    \context { \Score
        autoBeaming = ##f
        }
    }
PartPOneVoiceOne =  \relative c' {
    \key c \major \time 3/4 c4 d4 e4 | % 2
    f4 g4 a4 | % 3
    b4 a4 b4 | % 4
    c2 r4 \bar "|."
    }

PartPTwoVoiceOne =  \relative c {
    \clef "tab" \stopStaff \override Staff.StaffSymbol #'line-count = #6
    \startStaff \key c \major \time 3/4 c4 \5 d4 \4 e4 \4 | % 2
    f4 \4 g4 \3 a4 \3 | % 3
    b4 \2 a4 \3 b4 \2 | % 4
    c2 \2 r4 \bar "|."
    }


% The score definition
\score {
    <<
        \new Staff <<
            \context Staff << 
                \context Voice = "PartPOneVoiceOne" { \PartPOneVoiceOne }
                >>
            >>
        \new TabStaff \with { stringTunings = #`( ,(ly:make-pitch 0 2 0)
            ,(ly:make-pitch -1 6 0) ,(ly:make-pitch -1 4 0)
            ,(ly:make-pitch -1 1 0) ,(ly:make-pitch -2 5 0)
            ,(ly:make-pitch -2 2 0) ) } <<
            \context TabStaff << 
                \context TabVoice = "PartPTwoVoiceOne" { \PartPTwoVoiceOne }
                >>
            >>
        
        >>
    \layout {}
    % To create MIDI output, uncomment the following line:
    %  \midi {}
    }

