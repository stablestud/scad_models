screw_hole_width = 5;
motor_mount_min = 6.5;
motor_mount_max = 11;
arm_thickness = 4;

anti_warp = .15;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

$fs = $preview ? 1 : 0.5;
$fa = $preview ? 10 : 5;

module base_model(height) {
	difference() {
		translate([0, -17]) square([14.5, 36]);
		translate([15.5, 0]) {
			circle(d = 10);
		}

		translate([0, -15.8]) circle(d = 10);
		translate([0, -15.8]) rotate([0, 0, -45]) square([10, 5]);
		translate([8.5, -18]) rotate([0, 0, 103.5]) mirror([1, 0]) rotate([0, 0, -45]) mirror([0, 1]) square([10, 20]);
		translate([8.5, -15]) {
			difference() {
				translate([-3, -3]) square([5, 3]);
				rotate([0, 0, 40]) translate([1.7, 0]) square([3.4, 3.4], center = true);
				rotate([0, 0, -45]) translate([-1.7, 0]) square([3.4, 3.4], center = true);
				circle(d = 3.4);
			}
		}

		translate([11, 18]) {
			circle(d = 10);
			rotate([0, 0, 43]) translate([-5, -15]) square([10, 15]);
			rotate([0, 0, 90]) translate([0, -5]) square([15, 10]);
		}

		translate([11.5, 6.5]) {
			difference() {
				translate([1, -3]) square([3, 15]);
				circle(d = 5);
				rotate([0, 0, 40]) translate([0, 2.5]) square([5, 5], center = true);
				rotate([0, 0, -45]) translate([0, -2.5]) square([5, 5], center = true);
			}
		}

		translate([11.5, -7.5]) {
			difference() {
				translate([0, -3]) square([6, 10]);
				circle(d = 6);
				rotate([0, 0, 42]) translate([0, 3]) square([6, 6], center = true);
				rotate([0, 0, 65]) translate([-3, 0]) square([6, 6], center = true);
			}
		}
	}
}

module arm_model() {
	base_model();
	mirror([1, 0]) base_model();
}

module screw_hole(height) {
	assert(height > 0);
	hull() {
		cylinder(d = anti_warp_widen(screw_hole_width), h = height);
		translate([0, motor_mount_max - motor_mount_min]) cylinder(d = anti_warp_widen(screw_hole_width), h = height);
	}
}

module motor_mounts(height) {
	assert(height > 0);
	for (i = [45, 90 + 45, 180 + 45, 270 + 45]) {
		rotate([0, 0, i]) translate([0, motor_mount_min]) screw_hole(height);
	}
}

module walls(height) {
	assert(height > 0);
	difference() {
		linear_extrude(height) scale([1.25, 1.25]) arm_model();
		linear_extrude(height) scale([1.02, 1.02]) arm_model();
	}
}

module grip(height) {
	assert(height > 0);
	difference() {
		linear_extrude(height) scale([1.25, 1.25]) arm_model();
		linear_extrude(height) scale([0.6, 0.6]) arm_model();
	}
}

module top(height, modeltype) {
	assert(height > 0);

	linear_extrude(height / 4) scale([1.25, 1.25]) arm_model();
	translate([0, 0, height / 4]) intersection() {
		linear_extrude(height * 2) scale([1.25, 1.25]) arm_model();
		if (modeltype == "flat") {
			translate([0, -0.85, -height * 2]) scale([3.3, 3.4, 1.4]) sphere(height * 2);
		} else {
			translate([0, -0.85, -height * 2]) scale([2.6, 3.1, 1.75]) sphere(height * 2);
		}
	}
}

module model(modeltype) {
	grip(0.75);
	translate([0, 0, 0.75]) walls(anti_warp_widen(arm_thickness));
	translate([0, 0, anti_warp_widen(arm_thickness) + 0.75]) top(arm_thickness * 1.2, modeltype);
}

module main(modeltype) {
	difference() {
		model(modeltype);
		motor_mounts(30);
		mirror([1, 0]) {
			translate([0, 0, 0]) cube([4, 25, 0.75]);
			translate([0, 0, 0.75]) cube([6, 25, arm_thickness]);
		}
		translate([0, 0, 0]) cube([4, 25, 0.75]);
		translate([0, 0, 0.75]) cube([6, 25, arm_thickness]);
	}
}
