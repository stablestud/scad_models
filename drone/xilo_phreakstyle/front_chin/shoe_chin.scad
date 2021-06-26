include <base_chin.scad>

chin_angle = 15;
camera_bracket_thickness = 3;

module frontbumper() {
	rotate([0, 90]) cylinder(h = 15, d2 = anti_warp_widen(chin_thickness * 2 + plate_thickness), d1 = anti_warp_widen(chin_thickness * 2));
}
	
module frontbumpers() {
	translate([15, 0]) rotate([0, 0, 180 - chin_angle]) frontbumper();
	translate([-15, 0]) rotate([0, 0, 180 + chin_angle]) mirror([1, 0]) frontbumper();
}

module camera_bracket_spacer(width) {
	assert(width > 0);
	rotate([90, 0]) cylinder(d = width, h = 30, center = true);
	translate([0, 0, width / 2]) cube([width, 30, width], center = true);
}

module camera_bracket_spacers(width) {
	assert(width > 0);
	translate([0, 0, 1]) {
		screwholepos(false, width / 2 + standoff_width / 2) camera_bracket_spacer(width);
		screwholepos(true, width / 2 + standoff_width / 2) camera_bracket_spacer(width);
	}
}

module main() {
	difference() {
		hull() {
			scale([1.2, 1.5, 1]) model(anti_warp_widen(chin_thickness * 2 + plate_thickness));
			translate([0, 14, 0]) frontbumpers();
		}
		model(anti_warp_widen(plate_thickness));
		standoffs(anti_warp_widen(chin_thickness * 2 + plate_thickness) * 2);
		translate([0, 0, anti_warp_shrink(chin_thickness + plate_thickness / 2)]) camera_bracket_spacers(camera_bracket_thickness);
	}
}

main();
