anti_warp = 0.85;
length = 21;
width = 7;

notch_offset =  2.5;
notch_depth = 0.5;
notch_width = 1;

$fn = $preview ? 15 : 75;

len = length;
wid = anti_warp * width;

module notch(d, wid = 1, depth = 1, center = false) {
	difference() {
		cylinder(h = wid, d = d, center = center);
		cylinder(h = wid, d = d - depth, center = center);
	}
}

difference() {
	difference() {
		intersection() {
			cylinder(h = len, center = true, d = wid);
			sphere(d = len);
		}
		cylinder(h = len / 2, center = true, d = wid / 2);
	}
	translate([0, 0, notch_offset - notch_width / 2]) notch(wid = notch_width, depth = notch_depth, d = wid, center = true);
	translate([0, 0, -notch_offset + notch_width / 2]) notch(wid = notch_width, depth = notch_depth, d = wid, center = true);
}