standoff_width = 6;
standoff_spacing = 25;

anti_warp = .15;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

$fs = $preview ? 1 : 0.5;
$fa = $preview ? 10 : 5;

module standoff_holder(height) {
	assert(height > 0);
	difference() {
		cylinder(h = height, d = anti_warp_widen(standoff_width * 1.5));
		cylinder(h = height, d = anti_warp_shrink(standoff_width));
	}
}

module standoffs(height) {
	standoff_holder(height);
	standoff_holder(height);
}

standoff_holder(5);
