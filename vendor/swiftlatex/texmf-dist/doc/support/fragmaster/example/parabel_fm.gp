set terminal postscript eps
set output 'parabel_fm.eps'

set title 'y = x^2'
set xlabel 'x'
set ylabel 'y'

plot [-2:2] x**2 notitle
