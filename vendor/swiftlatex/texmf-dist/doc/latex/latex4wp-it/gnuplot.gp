gnuplot> set hidden
gnuplot> set isosam 50
gnuplot> splot sin(x*x + y*y)/(x*x + y*y)
gnuplot> splot [-3:3] [-3:3] sin(x*x + y*y)/(x*x + y*y) 
gnuplot> splot [-4:4] [-4:4] sin(x*x + y*y)/(x*x + y*y) 
gnuplot> set title "Gnuplot 3D graph"
gnuplot> replot
gnuplot> set grid
gnuplot> replot  
gnuplot> set xlabel
gnuplot> set xlabel "X"
gnuplot> set ylabel "Y" 
gnuplot> set zlabel "Z" 
gnuplot> replot
