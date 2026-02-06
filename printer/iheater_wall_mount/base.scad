wall_thickness = 1.5;
screw_diameter = 3; // Specify what countersunk screw you are using, e.g for M4 use 4
screw_pos_offset = [ -11, -11 ]; // Countersunk screw position offset from the edges

// Here you can specify to what percentage (0.0-1.0) the mount should cover the iHeater
half_length_percentage = 0.6; // for the length mount
half_width_percentage = 0.6;  // for the width mount

iheater_length = 140;
iheater_width  = 115.5;
iheater_height = 33.2;
iheater_edge_roundness = 8;

screw_shaft_dia = screw_diameter * 1.05;
screw_head_dia  = screw_shaft_dia * 2;
screw_head_height = (screw_head_dia - screw_shaft_dia) / 2 + 0.2;

mount_thickness = max(wall_thickness, screw_head_height + 0.1);

$fn = $preview ? 15 : 45;

module case()
{
	difference() {
		translate([0, 0, (wall_thickness - mount_thickness) / 2]) cyl_cube(iheater_width + wall_thickness * 2, iheater_length + wall_thickness * 2, iheater_height + wall_thickness + mount_thickness, iheater_edge_roundness, center = true);
		cyl_cube(iheater_width, iheater_length, iheater_height, iheater_edge_roundness, center = true);
	}
}

module reference_model()
{
	// STEP file can be downloaded from https://github.com/pavluchenkor/iHeater/tree/main/CAD
	// It must be converted to STL before use here
	translate([-iheater_width / 2, iheater_length / 2, -15]) import("./iHeater_200W_r1.1_upd.stl", convexity=1);
}

module cyl_cube(width, length, height, roundness, center = true)
{
	minkowski() {
		cube([width - roundness + 1, length - roundness + 1, height - 1], center = center);
		cylinder(d = roundness, h = 1, center = true);
	};
}

module countersunk()
{
	translate([0, 0, -screw_head_height / 2]) cylinder(d1 = screw_shaft_dia, d2 = screw_head_dia, h = screw_head_height, center = true);
	translate([0, 0, (iheater_height + wall_thickness) / 2]) cylinder(d = 6, h = iheater_height + wall_thickness, center = true);
	translate([0, 0, -screw_head_height - mount_thickness / 2]) cylinder(d = screw_shaft_dia, h = mount_thickness, center = true);
}

module power_plug()
{
	translate([-37, -70, -7.7]) rotate([90, 0]) cyl_cube(23, 14, 20, 12);
}

module pcb_vent()
{
	translate([-40.25, -44.25, iheater_height / 2]) cyl_cube(27, 34, 20, 4);
}

module electronics_vent()
{
	translate([-53, -14.5, -6]) rotate([0, 90]) cyl_cube(14, 48, 20, 4);
}

module pins()
{
	translate([-53, -3.25, 7.5]) rotate([0, 90]) {
		cyl_cube(7, 41, 20, 2);
		translate([1.25, 4.2, 0]) cyl_cube(6, 12, 20, 2);
	}
}

module button()
{
	translate([-37, -8.5, iheater_height / 2]) cyl_cube(25, 15, 20, 4);
}

module heater()
{
	translate([0, 54.5, iheater_height / 2]) cyl_cube(98, 29, 20, 4);
}

module fan()
{
	translate([13.25, -30.75, iheater_height / 2]) cylinder(d = 57, h = 20, center = true);
}

module cutouts()
{
	power_plug();
	pcb_vent();
	electronics_vent();
	pins();
	button();
	heater();
	fan();
}

module screw_holes(x_zero_screws = false, y_zero_screws = false)
{
	base_holes   = [[-1, -1], [-1, 1], [1, 1], [1, -1]];
	x_zero_holes = [[0, -1], [0, 1]];
	y_zero_holes = [[-1, 0], [1, 0]];
	holes = concat(base_holes, x_zero_screws ? x_zero_holes : [], y_zero_screws ? y_zero_holes : []);
	for (i = holes) {
		translate([iheater_width  / 2 * i.x + screw_pos_offset.x * i.x, iheater_length / 2 * i.y + screw_pos_offset.y * i.y, -iheater_height / 2]) countersunk();
	}
	// Print the screw hole distance from each other, the user can use this information to drill holes into the wall
	echo(str("Mounting screw distance: ",
			(x_zero_screws ? iheater_width * half_width_percentage : iheater_width) + screw_pos_offset.x * 2, "mm x ",
			(y_zero_screws ? iheater_length * half_length_percentage : iheater_length) + screw_pos_offset.y * 2, "mm"));
}

module iheater_wall_mount(x_zero_screws = false, y_zero_screws = false)
{
	difference() {
		case();
		cutouts();
		rotate([0, 0, 180]) cutouts();
		screw_holes(x_zero_screws, y_zero_screws);
	}
}

module half_width_case()
{
	case_width = (iheater_width + wall_thickness * 2) * half_width_percentage;
	case_length = iheater_length + wall_thickness * 2;
	intersection() {
		iheater_wall_mount(x_zero_screws = true);
		translate([(iheater_width + wall_thickness * 2) / 2 - case_width / 2 , 0, (wall_thickness - mount_thickness) / 2]) cyl_cube(case_width, case_length, iheater_height + wall_thickness + mount_thickness, iheater_edge_roundness, center = true);
	}
}

module half_length_case()
{
	case_width = iheater_width + wall_thickness * 2;
	case_length = (iheater_length + wall_thickness * 2) * half_length_percentage;
	intersection() {
		iheater_wall_mount(y_zero_screws = true);
		translate([0, (iheater_length + wall_thickness * 2) / 2 - case_length / 2, (wall_thickness - mount_thickness) / 2]) cyl_cube(case_width, case_length, iheater_height + wall_thickness + mount_thickness, iheater_edge_roundness, center = true);
	}
}

reference_model();
#cutouts();
