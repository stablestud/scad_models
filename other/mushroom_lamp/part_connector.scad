use <threadlib/threadlib.scad>

function thread_profile() = [
    [0,0],
    [2.5, 1.5],
    [0, 3],
    [-1.5, 3],
    [-1.5, 0]
];

threads = [["custom", [2.6, 72/2, 1.15, thread_profile()]]];

$fs = $preview ? 1 : 0.5;
$fa = $preview ? 10 : 3;

module ring() {
	height = 6.5;
	translate([0, 0, -height/2]) {
		difference() {
			cylinder(h = height, d = 79.25, center = true);
			cylinder(h = height, d = 76, center = true);
		}

		translate([0, 0, 2])
		difference() {
			cylinder(h = 2.5, d = 77, center = true);
			cylinder(h = 2.5, d1 = 76, d2 = 69, center = true);
		}
	}
}

ring();
translate([0, 0, -2.5]) difference() {
	thread("custom", turns=3.5, table=threads);
	cylinder(h = 2.5, d1 = 80, d2 = 80);
}
