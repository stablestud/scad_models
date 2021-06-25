strap_length = 200; // 20cm 
strap_width = 15; // 1.5cm
strap_thickness = 1.5;

button_width = strap_width * 0.6;
button_thickness = button_width / 5;
button_leg_height = 2;
button_head_height = 2;
button_head_offset = 1.5;
button_space = 10;
buttons = 3;
button_holes = 6;

head_length = strap_width;

$fs = $preview ? 1 : 0.5;
$fa = $preview ? 10 : 5;

anti_warp = .15;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

module tail() {
}

module button_head() {
	hull() {
		cube([button_width, button_thickness, button_head_height], center = true);
		cube([button_width - button_head_offset * 2, button_thickness + 2 * button_head_offset, 0.1], center = true);
		translate([button_width / 2 - button_head_offset / 2, 0]) cylinder(h = button_head_height / 2, d1 = button_thickness + 2 * button_head_offset, d2 = button_thickness);
		translate([-button_width / 2 + button_head_offset / 2, 0]) cylinder(h = button_head_height / 2, d1 = button_thickness + 2 * button_head_offset, d2 = button_thickness);
	}
}

module button_leg() {
	cube([button_width, button_thickness, button_leg_height], center = true);
}

module button() {
	translate([0, 0, button_leg_height / 2]) {
		button_leg();
		translate([0, 0, button_leg_height]) button_head();
	}
}

module button_hole() {
	cube([anti_warp_widen(button_width + button_head_offset * 0.25), anti_warp_widen(button_thickness), button_leg_height + button_head_height + strap_thickness], center = true);
}

module generate_buttons(count) {
	assert(count != undef);
	for (i = [0:count-1]) {
		translate([0, 10 * i, 0]) button();
	}
}

module generate_button_holes(count) {
	assert(count != undef);
	for (i = [0:count-1]) {
		translate([0, -10 * i, 0]) button_hole();
	}
}

module tailtip() {
	hull() {
		cube([strap_width, 1, strap_thickness], center = true);
		translate([0, strap_length * 0.05 - strap_width / 5]) cylinder(h = strap_thickness, d = strap_width / 5, center = true);
	}
}

module tail() {
	difference() {
		union() {
			translate([0, strap_length * 0.95 / 2]) cube([strap_width, strap_length * 0.95, strap_thickness], center = true);
			translate([0, strap_length * 0.95]) tailtip();
		}
		translate([0, strap_length * 0.92]) generate_button_holes(button_holes);
	}
	translate([0, strap_length * 0.03]) generate_buttons(buttons);
}

module strap_hole() {
	cube([anti_warp_widen(strap_width), strap_thickness * 2, head_length], center = true);
}

module head() {
	difference() {
		hull() {
			cube([strap_width, 1, strap_thickness], center = true);
			translate([0, strap_width * 1/3]) cube([strap_width * 1.5, 1, strap_thickness], center = true);
			translate([0, strap_width * 2/3]) cube([strap_width * 1.5, 1, strap_thickness], center = true);
			translate([0, head_length - 1]) cube([strap_width, 1, strap_thickness], center = true);
		}
		translate([0, head_length / 2 + 0.5]) rotate([45, 0]) strap_hole();
	}
}

module main() {
	rotate([0, 0, 180]) head();
	tail();
}

main();
