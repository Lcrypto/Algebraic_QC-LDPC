## Lista de programas que se crearan
bin_PROGRAMS = generator-matrix-egldpc check-matrix-egldpc

## Dependencia del programa nombre-programa1
## subdirectorios automaticamente se agregan a paquete.tar.gz osea a la DIST
generator_matrix_egldpc_SOURCES = generatormatrixegldpc.c \
	extras/extras.h \
	extras/GeneraGF2n.h \
	extras/Imprimindo.h \
	extras/ProcuraGF2n.h

generator_matrix_egldpc_LDADD  = -lm


## Dependencia del programa nombre-programa2
## subdirectorios automaticamente se agregan a paquete.tar.gz osea a la DIST
check_matrix_egldpc_SOURCES = checkmatrixegldpc.c \
	extras/checkmatrixegldpc.h \
	extras/GeneraGF2n.h \
	extras/Imprimindo.h \
	extras/ProcuraGF2n.h

check_matrix_egldpc_LDADD  = -lm
