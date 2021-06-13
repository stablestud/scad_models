include <bracket.scad>

xt60_angle = 45;

xt60_deg = 90 - xt60_angle;

module main() {
	difference() {
		bracket();
		translate([cos(arm_angle) * arm_length + arm_width,
			sin(arm_angle) * arm_length * 2,
			 -arm_height / 2]) {
			rotate([1, xt60_deg]) hull() {
				scale([1, 1, 2]) translate([0, 0, arm_width]) hull() xt60_bracket();
				scale([1, 1, -2]) translate([0, 0, -arm_width * 2]) hull() xt60_bracket();
			}
		}
	}

	translate([cos(arm_angle) * arm_length + arm_width,
		sin(arm_angle) * arm_length * 2,
		-arm_height / 2]) { 

		rotate([1, xt60_deg]) {
			xt60_bracket();
			translate([0, 0, -arm_width * 2]) xt60_bracket(false);
		}
	}

	difference() {
		translate([cos(arm_angle) * arm_length + arm_width,
			sin(arm_angle) * arm_length * 2,
			-arm_height / 2]) rotate([1, xt60_deg]) scale([1, 1, 2]) translate([0, 0, arm_width]) xt60_bracket(false);
		translate([0, 0, arm_height / 2]) cube([100, 100, 100]);
	}
		
}

difference() {
	main();
	translate([0, 0, -arm_height / 2]) rotate([270, 0]) cube([100, 100, 100]);
}
