
AC_INIT(generator-matrix-egldpc,[0.4],[fernando.pujaico.rivera@gmail.com],[generator-matrix-egldpc],[http://www.decom.fee.unicamp.br/~fpujaico/])

#AC_PREFIX_DEFAULT(/usr)

# if program is gcc and the PATH contains `/usr/local/gnu/bin/gcc', 
# set the prefix to `/usr/local/gnu'.
#AC_PREFIX_PROGRAM (program)

AC_DEFINE_UNQUOTED(BASEINSTALLDIR,"$prefix",Directorio base de instalacion del paquete - NONE si es el valor por defecto.)

AC_CONFIG_HEADERS(config.h)

#AM_AUTOMAKE_VERSION(1.11.1)
AM_INIT_AUTOMAKE


if test -z $CFLAGS; then
    CFLAGS='-Os'
fi

#C
AC_PROG_CC
#C++
AC_PROG_CXX

AC_OUTPUT([
Makefile
src/Makefile
doc/Makefile
doc/pdf/Makefile
doc/html/Makefile
doc/sgml/Makefile
])
    

echo "--------------------------------------------"
echo "La aplicación se instalará en   : ${prefix}"
echo "Para cambiar esta opción        : ./configure --prefix=/usr"
echo "Para ver otras opciones         : ./configure --help"
echo ""
echo "Configuración está terminada OK."
echo ""
