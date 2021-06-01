/* Begin of configuration */

// Size of the lipo to fit on
lipo_length = 60;
lipo_height = 30;
lipo_width = 30;

// Shell thickness
thickness = 2.5;
anti_warp = .2;

bumper_prcnt = 20;

/* End of configuration */


$fs = $preview ? 2 : 0.5;
$fa = $preview ? 10 : 5;

bumper_length_radius  = getbpmrsize(lipo_length) / 2;
bumper_length_lradius = getbpmrsize(lipo_width) / 2;
bumper_width_radius   = bumper_length_lradius;
bumper_width_lradius  = bumper_length_radius;
bumper_height_radius  = bumper_length_radius;
bumper_height_lradius = 0;

bumper_stub_radius = greater(bumper_length_radius, bumper_width_radius);

function prcntof(value, percentage) = value / 100 * percentage;
function greater(val1, val2) = val1 > val2 ? val1 : val2;
function less(val1, val2) = val1 < val2 ? val1 : val2;
function is_uneven(value) = value % 2 ? true : false;
function is_less(val1, val2) = val1 < val2 ? true : false;
function is_greater(val1, val2) = val1 > val2 ? true : false;
function is_equal(val1, val2) = val1 == val2 ? true : false;

function getbpmrsize(size) = greater(prcntof(size, bumper_prcnt), thickness);
function lipovectors() = [[0, 0], [lipo_length, 0], [lipo_length, lipo_width], [0, lipo_width]];
function lipovectorrot() = [[0, 0, 0], [0, 0, 90], [0, 0, 180], [0, 0, 270]];
function lipovectorposrot() = [[[0, 0, 0], [0, 0, 90]],
				[[0, 0, 90], [0, 0, 0]],
				[[0, 0, 0], [0, 0, 90]],
				[[0, 0, 90], [0, 0, 0]]];

module bumper(radius, lradius, len) {
	assert(radius > 0 && len > 0);
	sphere(r = radius);
	rotate([0, 90, 0]) cylinder(r1 = radius, r2 = greater(lradius, thickness), h = len);
}

module lipo_shape() {
	color("LightGrey", alpha = 0.75) cube([lipo_length, lipo_width, lipo_height], center = true);
}

module lipo_bumper_length() {
	bumper(bumper_stub_radius, bumper_length_lradius, lipo_length / 2);
}

module lipo_bumper_width() {
	bumper(bumper_stub_radius, bumper_width_lradius, lipo_width / 2);
}

module lipo_bumper_height() {
	bumper(bumper_stub_radius, bumper_height_lradius, lipo_height * 3 / 4);
}

module lipo_bumpers_vector(lrot, wrot) {
	rotate(lrot) lipo_bumper_length();
	rotate(wrot) lipo_bumper_width();
	rotate([0, 90, 0]) lipo_bumper_height();
}

module lipo_bumpers_all() {
	for (i = [0:3]) {
		translate(lipovectors()[i]) rotate(lipovectorrot()[i]) {
			lipo_bumpers_vector(lipovectorposrot()[i][0], lipovectorposrot()[i][1]);
		}
	}
}

difference() {
	translate([-(lipo_length / 2), -(lipo_width / 2), lipo_height / 2]) lipo_bumpers_all();
	lipo_shape();
}
%lipo_shape();
