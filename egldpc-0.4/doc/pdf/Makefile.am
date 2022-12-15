## Archivos a instalar en docdir
pdfdir=$(docdir)/pdf
pdf_DATA = tutorial.pdf

tutorial.pdf: $(top_srcdir)/doc/sgml/tutorial.sgml 
	sgmltools -b pdf $(top_srcdir)/doc/sgml/tutorial.sgml
	cp -f $(top_srcdir)/doc/sgml/tutorial.pdf tutorial.pdf
	rm -f $(top_srcdir)/doc/sgml/tutorial.pdf

CLEANFILES= tutorial.pdf

