height = 8;
inner_cyl_dia 	= 5;
outer_cyl_dia	= 8;

anti_warp = .15;

$fn = $preview ? 25 : 50;

difference() {
	cylinder(height, d = outer_cyl_dia);
	cylinder(height, d = inner_cyl_dia * (1 + anti_warp));
}
