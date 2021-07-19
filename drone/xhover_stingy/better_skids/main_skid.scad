screw_hole_width = 5;
motor_mount_min = 6.5;
motor_mount_max = 8;
arm_thickness = 4 + 0.5; // + 0.5 for waste from support

anti_warp = .15;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

$fs = $preview ? 1 : 0.5;
$fa = $preview ? 10 : 5;

module base_model() {
	outerd = 30;
	intersection() {
		translate([0, 1]) square([30, 50], center = true);
		union() {
			circle(d = outerd - 0.5);
			translate([outerd / 2 - 0.5, -2]) mirror([0, 1]) mirror([1, 0]) rotate([0, 0, -14.5]) square([14, 30]);
			translate([-outerd / 2 + 0.4, -2]) mirror([0, 1]) rotate([0, 0, -18.5]) square([14, 30]);
			translate([1, -20]) {
				difference() {
					square([18, 12], center = true);
					translate([-13.5, -5]) scale([1, 1.5]) circle(d = 10);
					translate([13.1, -5]) scale([1, 2]) circle(d = 10);
				}
			}

			intersection() {
				square([15, 24.8]);
				translate([-6.3, 0]) scale([1.05, 1.324]) circle(d = 40);
			}

			translate([-10, 11]) {
				difference() {
					square([10, 12]);
					translate([-7.25, 16.6]) scale([1.53, 1.9]) circle(d = 20);
				}
			}

			translate([0, 22.55]) {
				circle(d = 5);
			}
		}
	}
}

module motor_mount(height) {
	hull() {
		cylinder(d = screw_hole_width, h = height, center = true);
		translate([0, motor_mount_max - motor_mount_min + screw_hole_width / 2]) cylinder(d = screw_hole_width, h = height, center = true);
	}
}

module motor_mounts(height) {
	for (i = [0 + 45, 90 + 45, 180 + 45, 270 + 45]) {
		rotate([0, 0, i]) translate([0, motor_mount_min]) motor_mount(height);
	}
}

module walls(height) {
	assert(height > 0);
	difference() {
		linear_extrude(height) scale([1.15, 1.15]) base_model();
		linear_extrude(height) scale([1.02, 1.02]) base_model();
		translate([0.8, -25, height / 2]) cube([17, 10, height], center = true);
	}
}

module grip(height) {
	assert(height > 0);
	difference() {
		linear_extrude(height) scale([1.15, 1.15]) base_model();
		linear_extrude(height) scale([0.6, 0.6]) base_model();
	}
}

module top(height, modeltype) {
	assert(height > 0);

	linear_extrude(height / 4) scale([1.15, 1.15]) base_model();
	translate([0, 0, height / 4]) intersection() {
		linear_extrude(height * 2) scale([1.15, 1.15]) base_model();
		if (modeltype == "flat") {
			translate([0, -0.85, -height * 2]) scale([2.3, 4, 1.4]) sphere(height * 2);
		} else {
			translate([0, -0.85, -height * 2]) scale([2, 3.4, 1.75]) sphere(height * 2);
		}
	}
}

module model(modeltype) {
	grip(0.75);
	translate([0, 0, 0.75]) walls(arm_thickness);
	translate([0, 0, arm_thickness + 0.75]) top(arm_thickness * 1.2, modeltype);
}

module main(modeltype) {
	difference() {
		model(modeltype);
		translate([0, 0.5]) motor_mounts(40);
		rotate([0, 0, 180]) {
			mirror([1, 0]) {
				translate([0, 0, 0]) cube([6.4, 30, 0.75]);
			}
			translate([0, 0, 0]) cube([5.3, 30, 0.75]);
		}
	}
}
