gasket_thickness = 2;
gasket_length = 18;

tube_inner_dia = 4;
tube_outer_dia = 6;
tube2_inner_dia = 2;
tube2_outer_dia = 4;

$fs = $preview ? 2 : 0.5;
$fa = $preview ? 15 : 5;

module main() {
	difference() {
		cylinder(h = gasket_length, d = max(tube_outer_dia, tube2_outer_dia) + gasket_thickness * 2);
		
		cylinder(h = gasket_length/2, d = min(tube_outer_dia, tube2_outer_dia));
		translate([0, 0, gasket_length / 2]) cylinder(h = gasket_length / 2, d = max(tube_outer_dia, tube2_outer_dia));
	}
	translate([0, 0, gasket_length / 2]) difference() {
		cylinder(h = gasket_thickness, d = max(tube_outer_dia, tube2_outer_dia), center = true);
		cylinder(h = gasket_thickness, d1 = min(tube_inner_dia, tube2_inner_dia), d2 = max(tube_inner_dia, tube2_inner_dia), center = true);
	}
}

main();
