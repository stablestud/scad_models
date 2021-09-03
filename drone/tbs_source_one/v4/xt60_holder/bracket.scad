standoff_spacing = 61.2;
standoff_width = 5;
standoff_height = standoff_width * 2;

arm_front_angle = 35;
arm_rear_angle = 55;
arm_offset = 8.55;
arm_height = standoff_height;
arm_width = standoff_width / 5 * 4;

xt60_bracket_thickness = 1;

$fs = $preview ? 1 : 0.5;
$fa = $preview ? 10 : 5;

anti_warp = .15;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

bridge_length = standoff_spacing - ((tan(arm_front_angle) * arm_offset) + (tan(arm_rear_angle) * (arm_offset + 3)));

module joint(height, diameter) {
	assert(height > 0 && diameter > 0, "invalid args");
	cylinder(h = height, d = diameter, center = true);
}

module standoff_hole(height, diameter) {
	joint(height, anti_warp_shrink(diameter));
}


module standoff() {
	difference() {
		standoff_hole(standoff_height, standoff_width * 1.4);
		standoff_hole(standoff_height, standoff_width);
	}
}

module standoff_arm(deg, arm_len) {
	standoff();
	difference() {
		translate([0, arm_len / 2]) cube([arm_width, arm_len, arm_height], center = true);
		standoff_hole(standoff_height, standoff_width);
	}
	translate([0, arm_len]) joint(arm_height, arm_width);
}

module xt60_bracket(gen_claws = true) {
	xt60_height = anti_warp_widen(15);
	xt60_length = anti_warp_shrink(16);
	xt60_width = anti_warp_shrink(8);
	xt60_stub_width = 0.5;

	translate([-(xt60_bracket_thickness + xt60_length / 2), 0]) {
		cube([xt60_length + xt60_bracket_thickness * 2, xt60_bracket_thickness, xt60_height]);
		if (gen_claws) {
			 translate([0, -xt60_stub_width, -xt60_bracket_thickness]) cube([xt60_length + xt60_bracket_thickness * 2, xt60_stub_width + xt60_bracket_thickness, xt60_bracket_thickness]);
			 translate([0, -xt60_stub_width, -xt60_bracket_thickness + xt60_height]) cube([xt60_length + xt60_bracket_thickness * 2, xt60_stub_width + xt60_bracket_thickness, xt60_bracket_thickness]);
		}
	}

	translate([xt60_length / 2, -(xt60_width + xt60_bracket_thickness)]) {
		cube([xt60_bracket_thickness, xt60_width + xt60_bracket_thickness * 2, xt60_height]);
		if (gen_claws) {
			translate([-xt60_stub_width, 0, -xt60_bracket_thickness]) cube([xt60_stub_width + xt60_bracket_thickness, xt60_width + xt60_bracket_thickness * 2, xt60_bracket_thickness]);
			translate([-xt60_stub_width, 0, -xt60_bracket_thickness + xt60_height]) cube([xt60_stub_width + xt60_bracket_thickness, xt60_width + xt60_bracket_thickness * 2, xt60_bracket_thickness]);
		}
	}

	translate([-(xt60_length / 2 + xt60_bracket_thickness), -(xt60_width + xt60_bracket_thickness)]) {
		cube([xt60_bracket_thickness, xt60_width + xt60_bracket_thickness * 2, xt60_height]);
		if (gen_claws) {
			translate([0, 0, -xt60_bracket_thickness]) cube([xt60_stub_width + xt60_bracket_thickness, xt60_width + xt60_bracket_thickness * 2, xt60_bracket_thickness]);
			translate([0, 0, -xt60_bracket_thickness + xt60_height]) cube([xt60_stub_width + xt60_bracket_thickness, xt60_width + xt60_bracket_thickness * 2, xt60_bracket_thickness]);
		}
	}

	translate([-(xt60_length / 2 + xt60_bracket_thickness), -(xt60_width + xt60_bracket_thickness)]) {
		cube([xt60_length + xt60_bracket_thickness * 2, xt60_bracket_thickness, xt60_height]);
		if (gen_claws) {
			translate([0, 0, -xt60_bracket_thickness]) cube([xt60_length + xt60_bracket_thickness * 2, xt60_stub_width + xt60_bracket_thickness, xt60_bracket_thickness]);
			translate([0, 0, -xt60_bracket_thickness + xt60_height]) cube([xt60_length + xt60_bracket_thickness * 2, xt60_stub_width + xt60_bracket_thickness, xt60_bracket_thickness]);
		}
	}
}

module bridge() {
	translate([bridge_length / 2, 0]) cube([bridge_length, arm_width, arm_height], center = true);
}

module bracket() {
	rotate([0, 0, -arm_front_angle]) standoff_arm(0.6, arm_offset / cos(arm_front_angle));
	translate([standoff_spacing, -3]) rotate([0, 0, arm_rear_angle]) standoff_arm(1, (arm_offset + 3) / cos(arm_rear_angle));
	translate([sin(arm_front_angle) * (arm_offset / cos(arm_front_angle)), arm_offset]) bridge();
}
