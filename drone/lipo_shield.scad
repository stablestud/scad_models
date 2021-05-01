/* Begin of configuration */

lipo_length = 60;
lipo_height = 30;
lipo_width = 30;

thickness = 2.5;
anti_warp = .2;

lipo_strap_hole_length = 10;
lipo_strap_hole_height = 2;

lipo_strap_border_spacing = 10; // Opposite strength to middle_spacing
lipo_strap_middle_spacing = 1;
lipo_strap_vertical_spacing = 30;

wing_min_width = 15;
wing_width_prcnt = 10; // Percentage of lipo_width

/* End of configuration */

$fs = $preview ? 4 : 0.5;
$fa = $preview ? 20 : 5;

lipo_strap_hole_length_awarp = lipo_strap_hole_length * (1 + anti_warp);
lipo_strap_hole_height_awarp = lipo_strap_hole_height * (1 + anti_warp);

strap_offset_border = prcntof(lipo_length, lipo_strap_border_spacing);
strap_offset_middle = prcntof(lipo_length, lipo_strap_middle_spacing);

function prcntof(value, percentage) = value / 100 * percentage;
function greater(val1, val2) = val1 > val2 ? val1 : val2;
function less(val1, val2) = val1 < val2 ? val1 : val2;
function is_uneven(value) = value % 2 ? true : false;
function is_less(val1, val2) = val1 < val2 ? true : false;
function is_greater(val1, val2) = val1 > val2 ? true : false;
function is_equal(val1, val2) = val1 == val2 ? true : false;
function restoffset(length, offsetl, offsetr) = offsetl + (length - offsetl - offsetr) / 2;

module cubic_inv(l = 1, d, h) {
	depth = d ? d : l;
	height = h ? h : l;
	for (i = [0:1:$children-1]) {
		difference() {
			cube([l, depth, height]);
			children(i);
		}
	}
}

module half_cylinder(h = 1, r = 0, d = 0, center = false) {
	radius = greater(r, d / 2);
	intersection() {
		cylinder(h = h, r = radius);
		translate([-radius, 0, 0]) cube([radius * 2, radius, h]);
	}
}

// TODO Fix bug that makes model not manifold
module lipo_strap_hole(width, depth, height) {
	difference() {
		cube([width, depth, height]);
		//cubic_inv(depth / 2, depth, depth) translate([depth / 2, depth / 2, 0]) rotate([0, 0, 90]) half_cylinder(h = height, d = depth);
		//translate([width - depth / 2, 0, 0]) cubic_inv(depth / 2, depth, depth) translate([0, depth / 2, 0]) rotate([0, 0, 270]) half_cylinder(h = height, d = depth);
	}
}

lipo_shield_top();

module lipo_shield_top() {
	wing_width = greater(prcntof(lipo_width, wing_width_prcnt), wing_min_width);
	lipo_shield_base(lipo_length, thickness, lipo_width);
	translate([lipo_length / 2, lipo_width, 0]) lipo_shield_wing(lipo_length, wing_width, thickness);
	//translate([lipo_length / 2, 0, thickness]) rotate([180, 0, 0]) lipo_shield_wing(lipo_length, wing_width, thickness);
}

module lipo_shield_bottom() {
	lipo_shield_base(lipo_length, lipo_width, thickness / 2);
}

module lipo_shield_wing(length, width, height) {
	difference() {
		resize([length, width, height]) half_cylinder(h = thickness, d = length);
		translate([0, prcntof(width, lipo_strap_vertical_spacing), 0 ]) {
			translate([restoffset(length / 2, strap_offset_middle, strap_offset_border) - lipo_strap_hole_length_awarp / 2, 0, 0]) lipo_strap_hole(lipo_strap_hole_length, lipo_strap_hole_height, height);
			translate([-restoffset(length / 2, strap_offset_middle, strap_offset_border) - lipo_strap_hole_length_awarp / 2, 0, 0]) lipo_strap_hole(lipo_strap_hole_length_awarp, lipo_strap_hole_height_awarp, height);
		}
	}
}

module lipo_shield_base(length, width, height) {
	cube([length, height, width]);
}
