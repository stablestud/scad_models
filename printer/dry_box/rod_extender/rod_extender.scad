rod_width = 24;
rod_extender_width = 2;
rod_extender_extend_len = 5;
rod_extender_cross_len  = 7;

filament_thickness = 1.75;
anti_warp = .15;

$fs = $preview ? 2 : 0.5;
$fa = $preview ? 15 : 5;

function anti_warp_widen(v) = v + ((filament_thickness * anti_warp));
function anti_warp_shrink(v) = v - ((filament_thickness * anti_warp));

module inner_cyl(height) {
	assert(height > 0);
	cylinder(h = height, d = rod_width);
}

module outer_cyl(height) {
	assert(height > 0);
	cylinder(h = height, d = anti_warp_shrink(rod_width + rod_extender_width));
}

module tube_wall(height) {
	assert(height > 0);
	difference() {
		outer_cyl(height);
		inner_cyl(height);
	}
}

module outer_wall(height) {
	assert(height > 0);
	difference() {
		cylinder(h = height, d = tube_outer_dia + rod_width * 2);
		outer_cyl(height);
	}
}

module main() {
	difference() {
		outer_cyl(rod_extender_cross_len + rod_extender_extend_len);
		inner_cyl(rod_extender_cross_len);
	}
}

main();
