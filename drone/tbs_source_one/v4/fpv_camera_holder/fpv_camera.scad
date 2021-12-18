use <fpv_camera_mount.scad>

standoff_width = 5;

height = 18;
offset = 16;

anti_warp = .15;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

wall_thickness = anti_warp_widen(1.15);

// END OF CONFIGURATION


$fs = $preview ? 1 : 0.5;
$fa = $preview ? 10 : 5;

module standoff() {
	difference() {
		cylinder(h = height, d = standoff_width + 2 * wall_thickness);
		cylinder(h = height, d = standoff_width);
	}
}

module main() {
	standoff();
	translate([standoff_width / 2, 0]) {
		difference() {
			union() {
				translate([0, offset + wall_thickness + standoff_width / 2, height / 2]) rotate([0, 90]) {
					difference() {
						cylinder(h = wall_thickness, d = height);
					}
				}
				cube([wall_thickness, offset + wall_thickness * standoff_width / 2, height]);
			}
			translate([0, offset + wall_thickness + standoff_width / 2, height / 2]) rotate([0, 90]) {
				fpv_camera_mount_full_6mm(wall_thickness);
			}
		}
	}
}

main();
