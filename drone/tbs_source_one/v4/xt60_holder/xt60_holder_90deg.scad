include <bracket.scad>

module main() {
	difference() {
		bracket();
		translate([cos(arm_front_angle) * arm_offset + arm_width * 5.5,
			sin(arm_front_angle) * arm_offset + anti_warp_shrink(4) + 7,
			 -arm_height / 2]) hull() xt60_bracket();
	}

	translate([cos(arm_front_angle) * arm_offset + arm_width * 5.5,
		sin(arm_front_angle) * arm_offset + anti_warp_shrink(4) + 7,
		 -arm_height / 2 + xt60_bracket_thickness]) xt60_bracket();
}

main();
