standoff_width = 6;
standoff_spacing = 25;
height = 8.5;
wall_thickness = 2;
buzzer_width = 12;

anti_warp = .15;
filament_width = 1.75;

function anti_warp_widen(v) = v + (filament_width * anti_warp) * 2;
function anti_warp_shrink(v) = v - (filament_width * anti_warp) * 2;

$fs = $preview ? 1 : 0.5;
$fa = $preview ? 10 : 5;

module standoff_holder(height) {
	assert(height > 0);
	difference() {
		cylinder(h = height, d = anti_warp_widen(standoff_width * 1.2));
		cylinder(h = height, d = anti_warp_shrink(standoff_width));
	}
}

module standoffs(height) {
	standoff_holder(height);
	translate([standoff_spacing, 0]) standoff_holder(height);
}

module main() {
	standoffs(height);
	translate([standoff_width / 2, -wall_thickness / 2]) cube([standoff_spacing - standoff_width, wall_thickness, height]);
	translate([0, standoff_width / 2]) cube ([wall_thickness, buzzer_width - standoff_width / 2, height]);
	translate([standoff_spacing - wall_thickness, standoff_width / 2]) cube ([wall_thickness, buzzer_width - standoff_width / 2, height]);
	translate([0, buzzer_width]) cube([standoff_spacing, wall_thickness, height]);
}

main();
