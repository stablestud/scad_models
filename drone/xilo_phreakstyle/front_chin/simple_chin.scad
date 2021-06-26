include <base_chin.scad>

module chin() {
	difference() {
		hull() scale([1.05, 1.2]) model(plate_thickness + chin_thickness / 2 + 0.5);
		translate([0, 0, chin_thickness / 4]) model(plate_thickness + 0.5);
	}
}

module screw_hole(height) {
	cylinder(h = height, d = anti_warp_widen(screw_hole_width));
}

module screw_holes(height) {
	screwholepos() screw_hole(height);
	screwholepos(true) screw_hole(height);
}

module main() {
	difference() {
		chin();
		translate([0, 0, -chin_thickness - 0.2]) {
			standoffs(chin_thickness);
			screw_holes(chin_thickness);
		}
	}
}

main();
