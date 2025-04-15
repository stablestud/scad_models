wall_thickness = 1.5;
hole_diameter  = 10;
wall_offset    = [ 0, 0, 30.25 ];
hole_offset    = [ 0, 7, wall_offset.z ];
fotek_height   = 24;
new_ssr_height = 27;
sel_height     = 46;

module base_model() {
	import("SSR-H-Cover_2020.stl", convexity=5);
}

module covered_model() {
	base_model();
	cover();
}

module cover() {
	translate(wall_offset) cube(center = true, [35, 30, wall_thickness]);
}

module led_hole() {
	translate(hole_offset) cylinder(center = true, d = hole_diameter, h = wall_thickness);
}

module fixed_hole_model() {
	difference() {
		covered_model();
		led_hole();
	}
}

module extruder_selection_base() {
	rotate([0, 180]) linear_extrude(height = new_ssr_height - fotek_height, convexity = 10, scale = 1.0) {
		projection(cut = true) base_model();
	}
}

module scale_mount() {
	add_height = 13;
	scale([1.2, 1]) intersection() {
		extruded_model();
		cube([20, 63, sel_height + add_height], center = true);
	}
}

module extruder_mount() {
	translate([0, 0, fotek_height - new_ssr_height - 1]) intersection() {
		base_model();
		cube([20, 63, sel_height], center = true);
	}
}

module extruded_model() {
	union() {
		extruder_selection_base();
		fixed_hole_model();
		extruder_mount();
	}
}

module main() {
	union() {
		extruded_model();
		scale_mount();
	}
}

main();
