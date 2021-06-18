gasket_thickness = 3;
gasket_length = 10;

tube_inner_dia = 4;
tube_outer_dia = 6;

filament_thickness = 1.75;
anti_warp = .15;

$fs = $preview ? 2 : 0.5;
$fa = $preview ? 15 : 5;

function anti_warp_widen(v) = v + ((filament_thickness * anti_warp) * 2);
function anti_warp_shrink(v) = v - ((filament_thickness * anti_warp) * 2);

module inner_cyl(height) {
	assert(height > 0);
	cylinder(h = height, d = anti_warp_shrink(tube_inner_dia));
}

module outer_cyl(height) {
	assert(height > 0);
	cylinder(h = height, d = anti_warp_shrink(tube_outer_dia));
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
		cylinder(h = height, d = tube_outer_dia + gasket_thickness * 2);
		outer_cyl(height);
	}
}

module main() {
	outer_wall(gasket_length * 2 + gasket_thickness);
	translate([0, 0, gasket_length]) tube_wall(gasket_thickness);
}

main();
