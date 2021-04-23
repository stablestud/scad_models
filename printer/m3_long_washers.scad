height = 4;
screw_width = 3; // M3 screws

anti_warp = 1.35;

sw = anti_warp * screw_width;

$fn = $preview ? 10 : 25;

difference() {
	cylinder(h = height, d = sw * 1.5);
	cylinder(h = height, d = sw);
}
