standoff_distance = 25;
chin_length = 10;
chin_thickness = 3;

screw_width = 3;
standoff_offset_front = 3;
standoff_offset_side = 3;

anti_warp = .15;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

$fs = $preview ? 1 : 0.5;
$fa = $preview ? 15 : 5;

module screw_hole() {
	cylinder(h = chin_thickness, d = anti_warp_widen(screw_width));
}

module chin_bumper() {
	rotate([0, 270]) cylinder(h = standoff_distance + screw_width + standoff_offset_side,
		d = chin_length);
}
 chin_bumper();
