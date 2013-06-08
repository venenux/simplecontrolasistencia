
CC := gcc
CFLAGS += -g -Wall
# tenemos un main.c y diremos que contruya en objeto scanersimple.o
OBJECTS = escanerdedo.o
# usamos libfprint, debemos incluir su directorio de cabeceras, requeire libfprint-dev
INCFLAGS = -I/usr/include/libfprint  -I/usr/include/glib-2.0 
# usamos venenux<= 1.0  por tanto buscamos liberias en usr/lib
LDFLAGS = -Wl,-rpath,/usr/lib -lfprint  -lglib-2.0

all: clean escanerdedo

escanerdedo: $(OBJECTS)
	$(CC) -o escanerdedo $(OBJECTS) $(LDFLAGS)

.SUFFIXES:
.SUFFIXES:	.c .cc .C .cpp .o

.c.o :
	$(CC) -o $@ -c $(CFLAGS) $< $(INCFLAGS)

clean:
	rm -f *.o escanerdedo *.pnm *.pgm

.PHONY: all
.PHONY: clean
