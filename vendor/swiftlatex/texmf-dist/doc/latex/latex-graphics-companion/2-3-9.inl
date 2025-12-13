\usepackage {graphicx}
\setlength{\fboxsep}{0mm}
\newcommand{\MyRot}[1]{%
    \fbox{\rotatebox{#1}{%
       rotation $#1^\circ$}}}
\MyRot{0}   \MyRot{45}  \MyRot{90}
\MyRot{135} \MyRot{180} \MyRot{225}
