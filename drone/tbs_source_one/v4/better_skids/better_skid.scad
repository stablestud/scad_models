arm_thickness = 4;

wall_thickness = 1.15;
plate_thickness = 1;

skid_height = 8;

// END OF CONFIGURATION

_arm_thickness = arm_thickness + 1; // Buffer for support waste

anti_warp = .15;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

$fs = $preview ? 1 : 0.5;
$fa = $preview ? 10 : 5;

module base_model() {
	translate([0, -43.8]) rotate([0, 0, 54.75]) import("./SO_v4_5inch_arm_4mm_4x_model.svg");
}

module model() {
	intersection() {
		base_model();
		translate([-20, -20]) square([40, 35]);
	}
}

module holes() {
	minkowski() {
		translate([0, -43.8]) rotate([0, 0, 54.75]) import("./SO_v4_5inch_arm_4mm_4x_holes.svg");
		circle(anti_warp_widen(1.5));
	}
}

module base_plate() {
	translate([0, -4]) scale([wall_thickness + 0.1, wall_thickness]) translate([0, +4]) model();
}

module walls() {
	difference() {
		base_plate();
		base_model();
	}
}

module top_plate() {
	difference() {
		base_plate();
		scale([0.7, 0.7]) base_model();
	}
}

module skid() {
	intersection() {
		linear_extrude(height = skid_height) base_plate();
		#scale([2.7, 3]) sphere(skid_height);
	}
}

module main() {
	difference() {
		union() {
			linear_extrude(height = plate_thickness) top_plate();
			translate([0, 0, plate_thickness]) linear_extrude(height = _arm_thickness) walls();
			translate([0, 0, plate_thickness + _arm_thickness]) skid();
		}

		linear_extrude(height = arm_thickness * 2 + skid_height) holes();
	}
}

main();
