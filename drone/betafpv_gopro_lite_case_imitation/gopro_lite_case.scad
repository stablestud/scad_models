minkowski_factor = 2;
depth = 9 - minkowski_factor * 2;
camera_depth = 4;

minkowski() {
	sphere(minkowski_factor);
	cube([58 - minkowski_factor, 39 - minkowski_factor, depth]);
}
hull() {
	translate([26.5, 8, depth]) cylinder(d = 5, h = camera_depth);
	translate([22.5, 2, depth]) cylinder(d = 5, h = camera_depth);
	translate([19.5, 21, depth]) cylinder(d = 5, h = camera_depth);
	translate([10.5, 8, depth]) cylinder(d = 5, h = camera_depth);
}
