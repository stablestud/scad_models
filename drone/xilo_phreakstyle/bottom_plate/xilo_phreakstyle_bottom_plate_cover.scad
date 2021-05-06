h = 36; w = 25; d = 3;

$fn = $preview ? 45 : 50;
screwwidth = 2;

difference() {
	cube([w, h, d]);
	translate([15, 15, 0]) cylinder(d, r = screwwidth);
	#translate([w - 7, 0, 0]) cube([7, 7, d]);
	#translate([w, 7, 0]) scale([1, 2.14, 1]) cylinder(d, r = 7);
	% translate([w - 1, h - 14, 0]) cube([1, 14, d]);
}
