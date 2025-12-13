#
# Wlodek Bzyl, <matwb@univ.gda.pl>
#
# 13.VI.2004

# generate format

utf8mex.fmt : utf8mex.ini utf8-pl.tex utf8plsq.tex 
	tex -enc -ini utf8mex.ini

# do some tests

test : test.utf8.dvi test-math.utf8.dvi

test.utf8.dvi : test.utf8.tex 
	tex -fmt utf8mex test.utf8.tex

test-math.utf8.dvi : test-math.utf8.tex 
	tex -fmt utf8mex test-math.utf8.tex


%.ps : %.dvi
	dvips $* -o

clean :
	rm -f *~ \#* *.{log,dvi,ps}

xclean : clean
	rm -f utf8mex.fmt
