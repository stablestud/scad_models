use <fpv_camera_mount.scad>
d = 3; h = 20; w = 40;

translate([0, 0, 0.25 / 2 * 3]) {
	sh = d / 7 * 6;
	sd = d / 15 * 14;
	// Bottom stub
	translate([9, -(d / 6 * 5), 0]) cube([7.75, sh, sd]);
	// Top stubs
	translate([3, h, 0])            cube([4.75, sh, sd]);
	translate([18, h, 0])           cube([4.75, sh, sd]);
}

intersection() {
	d1 = d + 0.5;
	difference() {
		cube([w, h, d1]);
		translate([17, 5, 0]) {
			intersection() {
				w = 16; h = 11;
				translate([w / 3.15, h / 2, 0]) cylinder(d1, r = h * 0.95);
				translate([w / 3 * 2.05, h / 2, 0]) cylinder(d1, r = h);
				cube([w, h, d1]);
			}
		}
		translate([w / 4, h / 4, 0]) {
			rotate([0, 0, 90]) fpv_camera_mount_half_6mm(d1, 2.2);
			rotate([0, 0, 90]) fpv_camera_mount_half_6mm(0.25 / 2 * 3, 4.5);
			translate([0, 0, d1 - 0.25 / 2 * 3]) rotate([0, 0, 90]) fpv_camera_mount_half_6mm(0.25 / 2 * 3, 4.5);
		}
	}
	union() {
		cube([w / 4 * 3, h, d1]);
		translate([w / 4 * 3, h / 2, 0]) {
			intersection() {
				cylinder(d1, r = h / 2);
				translate([-(h / 1.5), 0, 0]) cylinder(d1, r = h);
			}
		}
	}
}
