SHELL = /usr/bin/bash

model_name = rod_extender

.PHONY: all clean stl png

all: clean $(model_name).stl $(model_name).png

stl: $(model_name).stl

png: $(model_name).png

clean: 
	rm --force --verbose $(model_name).{png,stl}

$(model_name).stl:
	openscad --render -o $(model_name).stl $(model_name).scad

$(model_name).png:
	openscad --render -o $(model_name).png $(model_name).scad
