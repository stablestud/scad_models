/* Case for the EMI filter ZS-0004 */

box_length  = 200;
box_width   = 60;
box_height  = 35;
box_wall    = 2;
box_cf      = 5;

cable_dia   = 8;
screw_width = 3;

mod_length = 138;
mod_width  = 49;
mod_l_offset = 3;
mod_w_offset = 7;
mod_standoff_h  = 5;
mod_standoff_offset = [mod_length/2-mod_l_offset, -mod_width/2+mod_w_offset];

mounting_x_offset = box_length/2-box_wall*3;
mounting_y_offset = box_width/2-box_wall*3;

$fn = 32;

module cuboid(x, y, z, c = 0)
{
	minkowski() {
		cube([x-2*c, y-2*c, z-2*c], center = true);
		sphere(r = c);
	}
}

module box_interior()
{
	cuboid(box_length-box_wall, box_width-box_wall, box_height-box_wall, c = box_cf);
}

module box_exterior()
{
	cuboid(box_length+box_wall, box_width+box_wall, box_height+box_wall, c = box_cf);
}

module cable_hole()
{
	c = 2;
	translate([0, 0, box_height/4]) cuboid(box_length+c*2, cable_dia, cable_dia*1.1, c = c);
}

module cable_holes()
{
	for(i = [-box_width/3:box_width/3:box_width/3]) {
		translate([0, i]) cable_hole();
	}
}

module emi_standoff()
{
	translate([0, 0, -box_height/2+box_wall]) difference() {
		cylinder(center = true, h = mod_standoff_h, d1 = screw_width+box_wall*4, d2 = screw_width+box_wall*2);
		cylinder(center = true, h = mod_standoff_h, d  = screw_width);
	}
}

module emi_bottom()
{
	intersection() {
		box_exterior();
		for (i = [-mod_length/2+mod_l_offset*2:mod_length/11:mod_length/2-mod_l_offset*2]) {
			translate([i, 0, -box_height/2+box_wall]) cube([2, box_width+2*box_wall, mod_standoff_h], center = true);
		}
	}
}

module emi_mounting_holes()
{
	translate(mod_standoff_offset) emi_standoff();
	translate(-mod_standoff_offset) emi_standoff();
}

module box_mounting_hole()
{
	cylinder(center = true, h = box_wall*2, d = screw_width);
}

module box_mounting_standoff()
{
	difference() {
		cylinder(center = true, h = box_wall*2, d1 = screw_width+box_wall*4, d2 = screw_width+box_wall*2);
		box_mounting_hole();
	}
}

module box_mounting_holes_pos()
{
	translate([mounting_x_offset, 0, -box_height/2+box_wall/2]) {
		translate([0, mounting_y_offset]) children();
		translate([0, -mounting_y_offset]) children();
	}
	translate([-mounting_x_offset, 0, -box_height/2+box_wall/2]) {
		translate([0, mounting_y_offset]) children();
		translate([0, -mounting_y_offset]) children();
	}
}

module box_mounting_holes()
{
	box_mounting_holes_pos() box_mounting_standoff();
}

module lid_mounting_hole()
{
	cylinder(d = screw_width, h = box_height/2, center = true);
	translate([0, 0, box_height/4-screw_width/2]) cylinder(d = screw_width*1.5, h = screw_width*1.5, center = true);
}

module lid_mounting_holes()
{
	lid_mounting_pos([-box_wall*1.25, -box_wall*1.25]) lid_mounting_hole();
}

module lid_mounting_block()
{
	s = screw_width+box_wall*4;
	cuboid(s, s, box_height/2, 2);
}

module lid_mounting_pos(offset = [0, 0, 0])
{
	for(r = [0, 180], i = [-1, 1]) {
		rotate([0, 0, r]) translate([offset.x, i*offset.y]) translate([box_length/2, box_width/2*i, box_height/4+box_wall]) children();
	}
}

module lid_mounting()
{
	difference() {
		intersection() {
			box_exterior();
			lid_mounting_pos() lid_mounting_block();
		}
		lid_mounting_holes();
	}
}

module hex(d, h)
{
	cylinder(h = h, d = d, $fn = 6, center = true);
}

module hexgrid(l, w, h, d, t)
{
	t=t/4;
	translate([-l/2, -w/2, 0]) for(x = [0:d+t:l+l/4], y = [0:d+t:w]) {
		s = x/(d+t)%2 == 1 ? (d+t)/2 : 0;
		if(s == 0 || y < w-d) translate([x-x/8, y+s]) hex(d, h);
	}
}

module box()
{
	translate([0, 0, -(box_height/4+box_wall*2)]) {
		difference() {
			box_exterior();
			box_interior();
			cable_holes();
			box_mounting_holes_pos() box_mounting_hole();
			lid_mounting_holes();
			rotate([0, 0, 90]) hexgrid(box_width/2+box_wall*2, box_length/2+2*box_wall, box_height+2*box_wall, box_width/10, box_width/30);
		}
		difference() {
			emi_bottom();
			hull() translate(mod_standoff_offset) emi_standoff();
			hull() translate(-mod_standoff_offset) emi_standoff();
		}
		emi_mounting_holes();
		intersection() {
			box_mounting_holes();
			box_exterior();
		}
		lid_mounting();
	}
}
