standoff_width = 6;
screw_hole_width = 3;
plate_thickness = 2.5;
chin_thickness = 2.5;
 
$fs = $preview ? 1 : 0.5;
$fa = $preview ? 10 : 5;

anti_warp = .15;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

module base_model() {
	difference() {
		square([19.5, 12]);
		translate([0, 2]) {
			translate([0, 10.3]) circle(d = 10);
			translate([1.3, 5.5]) rotate([0, 0, 15.5]) square([15, 10]);
			translate([0, 8]) square([20, 5]);
			translate([19.5, 2.1]) rotate([0, 0, 90 - 65.5]) square([5, 10]);
			translate([15.2, 5.5]) {
				difference() {
					translate([0, 1]) square([2.5, 2]);
					circle(d = 5);
				}
			}
			translate([11.7, 3]) {
				difference() {
					rotate([0, 0, 53]) square([4, 5]);
					scale([1.5, 1]) circle(d = 10);
				}
			}
			translate([16.5, 0.3]) {
				scale([1, 1.75]) difference() {
					translate([2.2, 0]) square([3, 3]);
					circle(d = 6);
				}
			}
		}
	}
}

module standoff_hole(height) {
	assert(height > 0);
	cylinder(h = height, d = anti_warp_widen(standoff_width), center = true);
}

module screwholepos(mirror = false, offset = 0) {
	translate([mirror ? -11.75 - offset : 11.75 + offset, 5.5])
		children();
}

module standoffs(height) {
	assert(height > 0);
	screwholepos() standoff_hole(height);
	screwholepos(true) standoff_hole(height);
}

module model(height) {
	assert(height > 0);
	linear_extrude(height, center = true) {
		base_model();
		mirror([1, 0]) base_model();
	}
}
