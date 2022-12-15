#/bin/sh
#Archivos de entrada: configure.in NEWS README AUTHORS ChangeLog Makefile.am

################################################################################
#Requiere configure.in
aclocal 

#Requiere configure.in
autoheader 
autoconf 

#Requiere NEWS README AUTHORS ChangeLog
#Requiere Makefile.am
automake --add-missing --copy --force-missing 
################################################################################


