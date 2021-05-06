basename = tse_ekey_front_cover

.PHONY: clean png stl

all: clean $(basename).stl $(basename).png

stl: $(basename).stl

png: $(basename).png

clean: 
	rm --force --verbose $(basename).{png,stl}

$(basename).stl:
	openscad --render -o $(basename).stl $(basename).scad

$(basename).png:
	openscad --render -o $(basename).png $(basename).scad
