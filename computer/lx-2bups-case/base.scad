model_width = 46.6;

mount_x_offset = 40;
mount_y_offset = 3.7;
mount_height = 3;
mount_hole_width = 4;

$fn = 32;

module ups_case_box()
{
	translate([0, 0, 1]) import(file="ups_case_box.stl", convexity=1, center=true);
}

module ups_case_lid()
{
	translate([0, 0, -10.75/3+0.27]) import(file="ups_case_lid.stl", convexity=1, center=true);
}

module ups_case_box_mount()
{
	y_offset = model_width/2;
	case(y_offset) ups_case_box();
}

module ups_case_lid_mount()
{
	y_offset = model_width/2;
	case(y_offset) ups_case_lid();
}

module ups2_case(y_offset=model_width, holes=false)
{
	difference() {
		for (y = [-y_offset/2, y_offset/2]) {
			translate([0, y]) children();
		}
		if (holes) for (x = [-mount_x_offset/1.2, mount_x_offset/1.2]) {
			hull() for (y = [-y_offset/2, y_offset/2]) {
				translate([x, y, 8]) rotate([90, 0]) cylinder(h = mount_hole_width, d = mount_hole_width * 2);
			}
		}
	}
}

module ups2_case_mount(holes=false)
{
	y_offset = model_width;
	case(y_offset) {
		ups2_case(y_offset, holes=holes) children();
	}
}

module ups2_case_box()
{
	ups2_case() ups_case_box();
}

module ups2_case_lid()
{
	ups2_case(holes=true) ups_case_lid();
}

module ups2_case_box_mount()
{
	ups2_case_mount() ups_case_box();
}

module ups2_case_lid_mount()
{
	ups2_case_mount(holes=true) ups_case_lid();
}

module mount()
{
	cylinder(h = mount_height, d = mount_hole_width*2);
}

module mount_hole()
{
	cylinder(h = mount_height, d = mount_hole_width);
}

module mounts_y(y_offset)
{
	for (y = [-mount_y_offset - y_offset, mount_y_offset + y_offset]) {
		translate([0, y]) children();
	}
}

module mounts_x()
{
	for (x = [-mount_x_offset, mount_x_offset]) {
		translate([x, 0]) children();
	}
}

module mounts(y_offset)
{
	mounts_x() mounts_y(y_offset) children();
}

module mounts_hull(y_offset)
{
	mounts_x() hull() mounts_y(y_offset) children();
}

module case(y_offset)
{
	difference() {
		mounts_hull(y_offset) mount();
		hull() children();
		mounts(y_offset) mount_hole();
	}
	children();
}
