vifly_height = 9;
vifly_width  = 12;
vifly_length = 20; 

thickness = 1;
standoff_width = 5;

case_rotation = 66;
case_offset_y = 6;
case_offset_x = -2.5;

anti_warp = .15;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

$fs = $preview ? 1 : 0.5;
$fa = $preview ? 10 : 5;

module joint(diameter) {
	circle(d = diameter);
}

module standoff_hole(diameter) {
	joint(anti_warp_shrink(diameter));
}

module standoff() {
	difference() {
		standoff_hole(standoff_width * 1.3);
		standoff_hole(standoff_width);
	}
}

module standoff_bracket() {
	translate([22, 0]) standoff();
	translate([-2, 0]) standoff();
	translate([0, -thickness * 2]) square([20, thickness * 4]);
}

module vifly_model() {
	square([vifly_width, vifly_length]);
}

module case_vifly() {
	difference() {
		minkowski() {
			vifly_model();
			circle(thickness);
		}
		vifly_model();
	}
}

module holeout() {
	union() {
		translate([thickness + case_offset_x, case_offset_y]) rotate([0, 0, -case_rotation]) vifly_model();
		translate([22, 0]) standoff_hole(standoff_width);
		translate([-2, 0]) standoff_hole(standoff_width);
	}
}

module model() {
	union() {
		translate([thickness + case_offset_x, case_offset_y]) rotate([0, 0, -case_rotation]) case_vifly();
		standoff_bracket();
	}
}

module main() {
	linear_extrude(height = vifly_height, center = true) difference() {
		model();
		holeout();
	}
}

main();
