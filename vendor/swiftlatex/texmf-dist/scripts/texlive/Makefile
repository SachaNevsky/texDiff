# $Id: Makefile 44325 2017-05-13 23:31:11Z karl $
# Public domain.

test_tlmgr_html = /tmp/tlmgr.html
live_tlmgr_html = /home/httpd/html/texlive/doc/tlmgr.html 

test-html:
	pod2html --cachedir=/tmp tlmgr.pl >$(test_tlmgr_html)
	diff $(live_tlmgr_html) $(test_tlmgr_html)
	
install-html:
	mv $(test_tlmgr_html) $(live_tlmgr_html)
