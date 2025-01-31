SCADFILES = $(filter-out emi_case.scad, $(wildcard *.scad))
PNGFILES = $(SCADFILES:.scad=.png)
STLFILES = $(SCADFILES:.scad=.stl)

.PHONY: all clean stl png
.SUFFIXES: .scad .stl .png

.scad.stl:
	openscad --render -o $@ $<

.scad.png:
	openscad --render -o $@ $<

all: $(PNGFILES) $(STLFILES)

clean:
	rm --force --verbose *.png *.stl
