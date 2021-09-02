include <bracket.scad>

module usb_cutout() {
	rotate([90, 0]) linear_extrude(height = arm_width * 2, center = true)
		polygon([[-bridge_length / 2, 0],
			[bridge_length / 2, 0],
			[bridge_length / 2 - arm_offset / 4, arm_height / 2],
			[-bridge_length / 2 + arm_offset / 4, arm_height / 2]]);
}

difference() {
	bracket();
	translate([cos(arm_front_angle) * arm_offset + bridge_length / 2,
		arm_offset,
		-arm_height / 2]) usb_cutout();
}
