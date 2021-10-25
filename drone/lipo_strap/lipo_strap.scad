button_width = strap_width * 0.6;
button_thickness = button_width / 3;
button_leg_height = strap_thickness * 2;
button_head_height = strap_thickness;
button_head_length = strap_width;
button_head_offset = 1.2;
button_space = 9;
buttons = 3;
button_holes = 8;
head_height = strap_thickness * 1.5;

// End of configuration

$fs = $preview ? 1 : 0.2;
$fa = $preview ? 10 : 2;

anti_warp = .15;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

module button_head() {
	hull() {
		cube([button_width, button_thickness / 2, button_head_height], center = true);
		translate([0, 0, -button_head_height]) cube([button_width - button_head_offset * 2, button_thickness / 2, 0.1], center = true);
		translate([button_width / 2 - button_head_offset / 2, 0, -button_head_height / 3]) cylinder(h = button_head_height / 2, d1 = button_thickness + 2 * button_head_offset, d2 = button_thickness);
		translate([-button_width / 2 + button_head_offset / 2, 0, -button_head_height / 3]) cylinder(h = button_head_height / 2, d1 = button_thickness + 2 * button_head_offset, d2 = button_thickness);
	}
}

module button_leg() {
	cube([button_width, button_thickness, button_leg_height], center = true);
}

module button() {
	translate([0, 0, button_leg_height / 2]) {
		button_leg();
		translate([0, 0, button_leg_height / 2 + button_head_height / 1.75]) button_head();
	}
}

module button_hole() {
	cube([anti_warp_widen(button_width + button_head_offset * 0.25), anti_warp_widen(button_thickness), strap_thickness], center = true);
}

module generate_buttons(count) {
	assert(count != undef);
	for (i = [0:count-1]) {
		translate([0, anti_warp_widen(button_space * i), 0]) button();
	}
}

module generate_button_holes(count) {
	assert(count != undef);
	for (i = [0:count-1]) {
		translate([0, -button_space * i]) button_hole();
	}
}

module tailtip(length) {
	hull() {
		cube([strap_width, length * 0.1, strap_thickness], center = true);
		translate([0, length - (strap_width / 5)]) cylinder(h = strap_thickness, d = strap_width / 5, center = true);
	}
}

module tail() {
	difference() {
		union() {
			translate([0, strap_length * 0.95 / 2]) cube([strap_width, strap_length * 0.95, strap_thickness], center = true);
			translate([0, strap_length * 0.95]) tailtip(strap_length * 0.05);
		}
		translate([0, strap_length * 0.92]) generate_button_holes(button_holes);
	}
	translate([0, strap_length * 0.03, strap_thickness / 2]) generate_buttons(buttons);
}

module strap_hole() {
	cube([anti_warp_widen(strap_width) - strap_thickness * 1.3, strap_thickness * 1.5, strap_width], center = true);
	translate([anti_warp_widen(strap_width) / 2 - strap_thickness / 1.5, 0, -strap_width / 2]) cylinder(d = strap_thickness * 1.5, h = strap_width);
	translate([-anti_warp_widen(strap_width) / 2 + strap_thickness / 1.5, 0, -strap_width / 2]) cylinder(d = strap_thickness * 1.5, h = strap_width);
}

module head() {
	translate([0, 0, head_height / 2 - strap_thickness / 2]) difference() {
		hull() {
			cube([strap_width, 1, head_height], center = true);
			translate([0, strap_width * 1/3]) cube([strap_width * 1.6, 1, head_height], center = true);
			translate([0, strap_width * 2/3]) cube([strap_width * 1.6, 1, head_height], center = true);
			translate([0, button_head_length - 1]) cube([strap_width, 1, head_height], center = true);
		}
		translate([0, button_head_length / 2 + 0.5]) rotate([45, 0]) strap_hole();
	}
}

module main() {
	rotate([0, 0, 180]) head();
	tail();
}

main();
