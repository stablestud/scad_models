use <fpv_camera_mount.scad>

anti_warp = .09;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

height = 13;
offset = 13;

standoff_width = 5;
standoff_wall_thickness = 1.05;

wall_thickness = 2.2;

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
		standoff();
		cylinder(h = height, d = standoff_width);
	}
	difference() {
		translate([-wall_thickness / 1.5, 0]) {
			difference() {
				union() {
					translate([0, offset + wall_thickness + standoff_width / 2, height / 2]) rotate([0, 90]) {
						scale([1,0.5]) cylinder(h = wall_thickness, d = height);
					}
					cube([wall_thickness, offset + wall_thickness + standoff_width / 2, height]);
				}
				translate([0, offset + wall_thickness + standoff_width / 2, height / 1.4]) rotate([0, 90]) {
					rotate([0, 0, 270]) fpv_camera_mount_half_6mm(wall_thickness);
				}
			}
		}
		cylinder(h = height, d = standoff_width);
	}
}

main();
