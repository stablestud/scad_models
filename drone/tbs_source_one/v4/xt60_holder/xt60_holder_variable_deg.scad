include <bracket.scad>

xt60_angle = 45;
xt60_offset_x = 2;
xt60_offset_y = 1;
xt60_offset_z = arm_height / 4;
xt60_mirrored = false;

xt60_deg = 90 - xt60_angle;

module main() {
	difference() {
		bracket();
		translate([cos(arm_front_angle) * arm_offset + arm_width + xt60_offset_x,
			arm_offset + xt60_offset_y + 6,
			 -arm_height / 2 + xt60_offset_z]) {
			rotate([0, xt60_deg]) hull() {
				scale([1, 1, 3]) translate([0, 0, arm_width]) hull() xt60_bracket(false);
				scale([1, 1, -3]) translate([0, 0, -arm_width * 2]) hull() xt60_bracket(false);
			}
		}
	}

	translate([cos(arm_front_angle) * arm_offset + arm_width + xt60_offset_x,
		arm_offset + xt60_offset_y + 6,
		-arm_height / 2 + xt60_offset_z]) { 

		rotate([0, xt60_deg + (xt60_mirrored ? 180 : 0)]) {
			xt60_bracket();
			translate([0, 0, -arm_width * 2]) xt60_bracket(false);
		}
	}

	difference() {
		translate([cos(arm_front_angle) * arm_offset + arm_width + xt60_offset_x,
			arm_offset + xt60_offset_y + 6,
			-arm_height / 2 + xt60_offset_z]) rotate([0, xt60_deg]) scale([1, 1, 2]) translate([0, 0, arm_width]) xt60_bracket(false);
		translate([0, 0, arm_height / 2]) cube([100, 100, 100]);
	}
		
}

difference() {
	main();
	translate([0, 0, -arm_height / 2]) rotate([270, 0]) cube([100, 100, 100]);
}
