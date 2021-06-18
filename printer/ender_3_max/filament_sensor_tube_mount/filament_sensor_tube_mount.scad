// Bad implementation but I dont care, it should just work, thats it

mount_holes_space = 45;
hole_offset_x = 15.75;
hole_offset_y = 7.25;
hole_offset_z = 14;
tube_diameter = 6;
tube_mount_length = 21;
screw_width = 3;
screw_depth = 3;

$fa = $preview ? 15 : 5;
$fs = $preview ? 2 : 0.5;

filament_thickness = 1.75;
anti_warp = .15;

function anti_warp_widen(v) = v + ((filament_thickness * anti_warp) * 2);
function anti_warp_shrink(v) = v - ((filament_thickness * anti_warp) * 2);

module screw_hole(width) {
	cylinder(h = screw_depth, d = anti_warp_widen(width));
}

module base_mount() {
	screw_offset = screw_width * 2;
	difference() {
		cube([mount_holes_space + screw_width * 2, 7 + hole_offset_y, screw_depth]);
		translate([screw_width, screw_width]) screw_hole(screw_width);
		translate([screw_width + mount_holes_space, screw_width]) screw_hole(screw_width);
	}
}

module tube_mount() {
	difference() {
		cylinder(h = tube_mount_length, d = tube_diameter + 4);
		cylinder(h = tube_mount_length, d = tube_diameter);
	}
	translate([0, 0, tube_mount_length / 2]) {
		difference() {
			cylinder(h = tube_mount_length / 2, d = tube_diameter + 4);
			cylinder(h = tube_mount_length / 2, d2 = anti_warp_widen(2), d1 = tube_diameter);
		}
	}
}

module side_plate() {
	difference() {
		cube([mount_holes_space + screw_width * 2, 4, hole_offset_z + 5]);
		translate([screw_depth / 2, 0, -screw_depth / 2 + hole_offset_z + 5]) rotate([0, 90, 90]) {
			difference() {
				translate([-4, 0, 0]) cube([4, 4, 4]);
				cylinder(h = 4, d = screw_depth);
			}
		}
	}
}

module top_mount() {
	translate([0, hole_offset_y + 3, screw_depth]) {
		difference() {
			side_plate();
			translate([hole_offset_x, hole_offset_y, hole_offset_z]) rotate([90, 0, 0]) {
				cylinder(h = tube_mount_length, d = anti_warp_widen(tube_diameter));
			}
		}
		translate([hole_offset_x, hole_offset_y + 6, hole_offset_z]) rotate([90, 0, 0]) {
			tube_mount();
		}
	}
}

module mount() {
	base_mount();
	top_mount();
}

mount();
