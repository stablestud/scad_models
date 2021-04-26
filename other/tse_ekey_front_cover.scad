length = 71;
height = 10;
width  = 38;

keyring_arc_length      = 7;
keyring_arc_width       = 10;
keyring_arc_arch_radius = 5;

thickness = 1;
claw_length = thickness;

difference() {
	cube([length, width, thickness]);
	translate([length - keyring_arc_length, width - keyring_arc_width, 0]) {
		difference() {
			cube([keyring_arc_length, keyring_arc_width, thickness]);
			difference() {
				cube([keyring_arc_arch_radius, keyring_arc_arch_radius, thickness]);
				translate([keyring_arc_arch_radius, keyring_arc_arch_radius, 0]) cylinder(r = keyring_arc_arch_radius, h = thickness);
			}
		}
	}
}

rotate([90, 0, 0]) {
	translate([-thickness, 0, thickness]) {
		backclaw(-(width + thickness));
		rotate([0, 90, 0]) backclaw(length + thickness);
	}
}
translate([-thickness, width + thickness, 0]) {
	rotate([90, 0, 270]) backclaw(-(length - keyring_arc_length + thickness));
}

module backclaw(length = 0) {
	assert(length != 0, "length cannot be 0");
	translate([0, 0, length < 0 ? length : 0]) {
		l = length < 0 ? -length : length;
		linear_extrude(height = l) {
			polygon([[0,0], [0, height + thickness * 2], [thickness + claw_length, height + thickness + thickness * 0.5], [thickness + claw_length, height + thickness], [thickness, height + thickness], [thickness, 0]]);
		}
	}
}
