use <fpv_camera_mount.scad>

anti_warp = .09;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

height = 9;
offset = 13;

standoff_width = 5;
standoff_wall_thickness = 1.05;

wall_thickness = 1.75;

// END OF CONFIGURATION


$fs = $preview ? 1 : 0.5;
$fa = $preview ? 10 : 5;

module standoff() {
	difference() {
		cylinder(h = height, d = standoff_width + 2 * standoff_wall_thickness);
		cylinder(h = height, d = standoff_width);
	}
}
module main() {
	difference() {
		hull() {
			standoff();
			translate([standoff_width / 2.6, 0]) cylinder(h = height, d = wall_thickness * 2);
		}
		cylinder(h = height, d = standoff_width);
	}
	difference() {
		translate([standoff_width / 2.6, 0]) {
			difference() {
				union() {
					cube([wall_thickness, offset + standoff_width / 2 + standoff_wall_thickness, height]);
					translate([0, offset + standoff_width / 2 + standoff_wall_thickness, height / 2]) rotate([0, 90]) cylinder(h = wall_thickness, d = height);
				}
				translate([0, offset + standoff_width / 2 + standoff_wall_thickness, height / 2]) rotate([0, 90]) fpv_camera_mount_hole(wall_thickness);
			}
		}
		cylinder(h = height, d = standoff_width);
	}
}

main();
