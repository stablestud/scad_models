include <emi_case.scad>

intersection() {
	box();
	translate([0, 0, box_height/2]) cube([box_length+2*box_wall, box_width+2*box_wall, box_height], center = true);
}
