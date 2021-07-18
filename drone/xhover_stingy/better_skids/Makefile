SCADFILES = $(filter-out main_skid.scad, $(wildcard *.scad))
PNGFILES = $(SCADFILES:.scad=.png)
STLFILES = $(SCADFILES:.scad=.stl)

.PHONY: all stl png clean
.SUFFIXES: .scad .stl .png

.scad.stl:
	openscad --render -o $@ $<

.scad.png:
	openscad --render -o $@ $<

all: $(PNGFILES) $(STLFILES)

clean:
	rm --force --verbose *.png *.stl
