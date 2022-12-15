## Archivos a instalar en docdir
htmldir=$(docdir)/html
html_DATA = tutorial.html

tutorial.html: $(top_srcdir)/doc/sgml/tutorial.sgml 
	sgmltools -b onehtml $(top_srcdir)/doc/sgml/tutorial.sgml
	cp -f $(top_srcdir)/doc/sgml/tutorial.html tutorial.html
	rm -f $(top_srcdir)/doc/sgml/tutorial.html

CLEANFILES= tutorial.html
