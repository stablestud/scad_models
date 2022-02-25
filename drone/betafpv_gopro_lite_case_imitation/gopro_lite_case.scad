minkowski_factor = 2;
depth = 8.5 - minkowski_factor * 2;
camera_depth = 6;

minkowski() {
	sphere(minkowski_factor);
	cube([60 - minkowski_factor, 37.7 - minkowski_factor, depth]);
}
hull() {
	translate([27.5, 8, depth]) cylinder(d = 5, h = camera_depth);
	translate([23.5, 2, depth]) cylinder(d = 5, h = camera_depth);
	translate([20.5, 21, depth]) cylinder(d = 5, h = camera_depth);
	translate([11.5, 8, depth]) cylinder(d = 5, h = camera_depth);
}
