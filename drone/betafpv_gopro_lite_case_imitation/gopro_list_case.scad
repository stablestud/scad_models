minkowski_factor = 2;
depth = 8 - minkowski_factor * 2;
camera_depth = 6;

minkowski() {
	sphere(minkowski_factor);
	cube([58 - minkowski_factor, 39 - minkowski_factor, depth]);
}
hull() {
	translate([28, 8, depth]) cylinder(d = 5, h = camera_depth);
	translate([12, 21, depth]) cylinder(d = 5, h = camera_depth);
	translate([6, 8, depth]) cylinder(d = 5, h = camera_depth);
}
