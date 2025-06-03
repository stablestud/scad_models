gasket_thickness = 3;
gasket_length = 8;
lanyard_length = 45;

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

module lanyard_hole(length) {
	assert(length > 0);
	top_side = length / 10;
	bottom_side = -top_side;
	right_side = length / 4 + 3;
	left_side = -right_side;
	far_right_side = length / 2 + 2;
	far_left_side = -far_right_side;
	linear_extrude(gasket_thickness / 2, center = true) polygon([[far_left_side, 0],
		[left_side, bottom_side],
		[right_side, bottom_side],
		[far_right_side, 0],
		[right_side, top_side],
		[left_side, top_side]]);
}

module lanyard_holder(length) {
	assert(length > 0);
	difference() {
		lanyard_hole(length);
		lanyard_hole(length * 0.5);
	}
}

module lanyard_tail(length) {
	assert(length > 0);
	translate([0, length / 3, gasket_thickness / 4]) cube([gasket_thickness / 2, length, gasket_thickness / 2], center = true);
}

module lanyard(length) {
	assert(length > 0);
	lanyard_tail(length * 0.6);
	translate([0, tube_outer_dia / 2 + filament_thickness + length * 0.6, gasket_thickness / 4]) rotate([0, 0, 90]) lanyard_holder(length * 0.4);
}

module main() {
	rotate([0, 0, -90]) difference() {
		union() {
			gasket_base(gasket_thickness);
			gasket_iso_base(gasket_length + gasket_thickness);
		}
		translate([tube_outer_dia / 2 + filament_thickness, 0]) filament_hole(gasket_thickness + gasket_length);
		translate([tube_outer_dia / 2, 0]) filament_hole(gasket_thickness + gasket_length);
		translate([tube_inner_dia / 2 - filament_thickness / 3, 0]) filament_hole(gasket_thickness + gasket_length);
	}
	//translate([0, tube_outer_dia / 2 + filament_thickness]) lanyard(lanyard_length);
}

main();
