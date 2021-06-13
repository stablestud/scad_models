include <bracket.scad>

module main() {
	difference() {
		bracket();
		translate([cos(arm_angle) * arm_length + 8,
			sin(arm_angle) * arm_length + arm_width * 2,
			 -arm_height / 2]) hull() xt60_bracket();
	}

	translate([cos(arm_angle) * arm_length + 8,
		sin(arm_angle) * arm_length + arm_width * 2,
		 -arm_height / 2 + xt60_bracket_thickness]) xt60_bracket();
}

main();
