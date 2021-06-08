// Simple M3 spacers printed with TPU

anti_warp = .15;
height = 2;
screw_width = 3;
width = 6;

filament_width = 1.75;

$fn = 25;

difference() {
	cylinder(h = height, d = width + (filament_width * anti_warp) * 2);
	cylinder(h = height, d = screw_width + (filament_width * anti_warp) * 2);
}
