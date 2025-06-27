tube_diameter = 24.75;
separator_height = 4;
separator_diameter = tube_diameter * 4;

$fn = 64;

difference() {
	cylinder(h=separator_height, d=separator_diameter, center=true);
	cylinder(h=separator_height, d=tube_diameter, center=true);
}
