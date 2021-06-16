gasket_thickness = 1.5;
gasket_length = 5;

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
	cylinder(h = height, d = anti_warp_widen(tube_inner_dia));
}

module outer_cyl(height) {
	assert(height > 0);
	cylinder(h = height, d = anti_warp_widen(tube_outer_dia));
}

module filament_hole(height) {
	assert(height > 0);
	cylinder(h = height, d = filament_thickness);
}

module tube_wall(height) {
	difference() {
		outer_cyl(height);
		inner_cyl(height);
	}
}

module gasket_base(height) {
	cylinder(h = height, d = tube_outer_dia + gasket_thickness);
} 

module gasket_outer_wall(height) {
	difference() {
		gasket_base(height);
		outer_cyl(height);
	}
}

module gasket_iso_base(height) {
	difference() {
		gasket_base(height);
		tube_wall(height);
	}
}

module main() {
	difference() {
		union() {
			gasket_base(gasket_thickness);
			gasket_iso_base(gasket_length + gasket_thickness);
		}
		translate([tube_outer_dia / 2, 0]) filament_hole(gasket_thickness + gasket_length);
		translate([tube_inner_dia / 2 - filament_thickness / 3, 0]) filament_hole(gasket_thickness + gasket_length);
	}
}

main();
