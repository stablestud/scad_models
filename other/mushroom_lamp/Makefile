SCADFILES = $(wildcard *.scad)
ESCADFILES = $(wildcard *.escad)
PNGFILES = $(SCADFILES:.scad=.png)
STLFILES = $(SCADFILES:.scad=.stl)

.PHONY: all clean stl png
.SUFFIXES: .scad .stl .png

mushroom_top_screwable.stl: part_connector.stl

.scad.stl:
	openscad --render -o $@ $<

.scad.png:
	openscad --render -o $@ $<

all: $(STLFILES) $(PNGFILES)

clean:
	rm --force --verbose $(PNGFILES) $(STLFILES)
