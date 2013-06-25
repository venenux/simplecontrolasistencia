CC := gcc
CFLAGS += -g -Wall
GBCC := gbc3
GBAC := gba3

all: clean escaner

escaner:
	cd escanerdedo && make all
	cp -f escanerdedo/escanerdedo escanerdedocmd
	$(GBCC) -e -a -g -t -p -m -x  interfaztomarasistencia
	$(GBAC) -o asistencia interfaztomarasistencia

clean:
	cd escanerdedo && make clean
	rm -f ./asistencia ./escanerdedocmd *.pnm *.pgm
#	rm -f `find . -name "*escanerdedo"`
	rm -Rf `find . -name ".gambas"`
	rm -Rf `find . -name "*.gambas"`

.PHONY: all
.PHONY: escaner
.PHONY: clean
