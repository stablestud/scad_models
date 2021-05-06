basename = xilo_phreakstyle_antenna_bumper

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
