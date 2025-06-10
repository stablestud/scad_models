SCADFILES = $(filter-out base.scad, $(wildcard *.scad))
PNGFILES = $(SCADFILES:.scad=.png)
STLFILES = $(SCADFILES:.scad=.stl)

.PHONY: all clean stl png
.SUFFIXES: .scad .stl .png

.scad.stl:
	openscad --render -o $@ $<

.scad.png:
	openscad --render -o $@ $<

all: $(STLFILES) $(PNGFILES)

clean:
	rm --force --verbose *.png *_mount.stl
