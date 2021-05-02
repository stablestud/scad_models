height = 8;
inner_cyl_dia 	= 5;
outer_cyl_dia	= 8;

anti_warp = .2;

$fn = $preview ? 25 : 50;

difference() {
	cylinder(height, r = outer_cyl_dia * (1 + anti_warp) / 2);
	cylinder(height, r = inner_cyl_dia * (1 + anti_warp)/ 2);
}
