// Simple M3 spacers printed with TPU

mount_height = 2;
screw_width = 3;
motor_min_mount = 6;
motor_max_mount = 9;

anti_warp = .15;
filament_width = 1.75;

single_mount_width = screw_width * 2.5;

$fs = $preview ? 1 : 0.5;
$fa = $preview ? 20 : 5;

motor_diff = motor_max_mount - motor_min_mount;

function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;
function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;

module outer_cyl() {
	cylinder(h = mount_height, d = anti_warp_widen(single_mount_width));
}

module inner_cyl() {
	cylinder(h = mount_height, d = anti_warp_widen(screw_width));
}

module single_mount() {
	translate([motor_min_mount, 0]) difference() {
		hull() {
			translate([motor_diff, 0]) outer_cyl();
			translate([-motor_min_mount, 0]) outer_cyl();
		}
		hull() {
			inner_cyl();
			translate([motor_diff, 0]) inner_cyl();
		}
	}
}

module mount() {
	difference() {
		union() {
			for (i = [0, 90, 180, 270]) {
				rotate([0, 0, i]) single_mount();
			}
		}
		cylinder(h = mount_height, d = anti_warp_widen(5));
	}
}

mount();
