SCADFILE = ssr_cover_geya.scad
STLFILE = $(SCADFILE:.scad=.stl)
PNGFILE = $(SCADFILE:.scad=.png)

.PHONY: all clean

all: $(STLFILE) $(PNGFILE)

$(STLFILE): $(SCADFILE)
	openscad --render -o $@ $<

$(PNGFILE): $(SCADFILE)
	openscad --render -o $@ $<

clean:
	rm --force --verbose $(STLFILE) $(PNGFILE)
