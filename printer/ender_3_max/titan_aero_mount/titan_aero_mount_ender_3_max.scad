anti_warp     = .2;
base_height   = 7.14507;
height_offset = 9.4154;
width_offset  = -34.9542;
extra_height  = 5;
extra_offset  = 7;

pos_cover_leftwheelscrew  = [-28, 26];
pos_cover_rightwheelscrew = [12, 26];
pos_leftwheelspacing      = [-23.5, 32];
pos_rightwheelspacing     = [21, 32];
pos_lefthotendscrewhole   = [6.55, 18.85];
pos_righthotendscrewhole  = [20.55, 18.85];
pos_lefthotendcoverhole   = [-5, 41.7];
pos_righthotendcoverhole  = [32.3, 41.7];

$fn = $preview ? 15 : 55;

function genscrewhole(width) = width * (1 + anti_warp);

module cylindercube(length = 0, width = 0, height = 0) {
	translate([width / 2, 0, 0]) {
		assert(width != 0 && length != 0 && height != 0, "Cannot take 0 value args");
		hull() {
			cylinder(d = width, h = height);
			translate([length - width, 0, 0]) cylinder(d = width, h = height);
		}
	}
}

module mountbase2dslice() {
	projection() {
		rotate([270, 0, 0]) intersection() {
			translate([0, 0, height_offset]) import("./Aero_Mount_ABLversion.stl");
			translate([width_offset, 0, 0]) cube([64, 1, 14]);
		}
	}
}

module flattenmount() {
	difference() {
		translate([0, 44.56, 0]) rotate([90, 0, 0]) linear_extrude(40) mountbase2dslice();	
		translate([-1, 42, 7.75]) cube([1, 3, 10]);
	}
}

module closemounthole() {
	translate([0, 41.02, 0]) mirror([0, 1, 0]) intersection() {
		translate([0, 0, height_offset]) import("./Aero_Mount_ABLversion.stl");
		translate([-32, -3.54, 5]) cube([20, 5, 10]);
	}
}

module closescrewhole() {
	translate([0, 0, 68.1]) mirror([0, 0, 1]) intersection() {
		translate([0, 0, height_offset]) import("./Aero_Mount_ABLversion.stl");
		translate([-2, 26.3868, 39.6]) cube([2, 5.3168, 14.58]);
	}
}

module basehotend() {
	difference() {
		intersection() {
			translate([0, 0, height_offset]) import("./Aero_Mount_ABLversion.stl");
			translate([width_offset, -3.6]) cube([64.05, 48.16, 70]);
		}
		translate([0, 20, 0]) cube([30, 25, 9]);
	}
	flattenmount();
	closemounthole();
	closescrewhole();
	translate([-7, -3.54, 0]) cube([8, 1.2, 12.5]);
}

module hotend() {
	difference() {
		union() {
			intersection() {
				basehotend();
				translate([width_offset, -3.6]) cube([64.05, 48.16, 30]);
			}
			linear_extrude(50 + extra_height) motorbracketsidebumper();
		}
		translate([0, 0, extra_height]) motorbracketselect();
	}
	translate([0, 0, extra_height]) motorbracket();
	translate([0, 0, extra_height]) motortopbracket();
}

module motorbracketsidebumper() {
	projection(cut = true) translate([0, 0, -47]) basehotend();
}

module motorbracketselect() {
	translate([-2, 0, 12]) cube([2, 41, 42]);
}

module motorbracket() {
	intersection() {
		basehotend();
		motorbracketselect();
	}
}

module motortopbracket() {
	intersection() {
		basehotend();
		translate([-15, -3.54, 50]) cube([19, 48.1, 18.1]);
	}
}

module basebracket() {
	intersection() {
		translate([0, 0, height_offset]) import("./Aero_Mount_ABLversion.stl");
		translate([-10, 15, 0]) cube([58.05, 69.56, base_height]);
	}
}

module bracketarc() {
	intersection() {
		basebracket();
		translate([11.933, 40, 0]) cube([50, 50, 10]);
	}
}

module invbracketarc() {
	difference() {
		translate([11.933, 40, 0]) cube([50, 50, 10]);
		bracketarc();
	}
}

module bracket() {
	difference() {
		basebracket();
		translate([12.4, 0, 0]) mirror([1, 0, 0]) invbracketarc();
	}
	difference() {
		translate([-34.5, 39, 0]) cube([35, 12, base_height]);
		translate([12.4, 0, 0]) mirror([1, 0, 0]) invbracketarc();
	}
	translate([1.4, 21.5, 0]) cube([10, 29, base_height]);
	translate([width_offset + 0.4542, 44.56 - extra_offset, 0]) cube([24.5, extra_offset - 5.55987, base_height]);
}

module wheelscrewspacer() {
	scale([1, 1, 0.8]) sphere(d = 11.5);
}

module hotendscrewhole() {
	cylinder(h = 4, r = 3.15);
	translate([0, 0, 3.8])       cylinder(h = 1.5, d = genscrewhole(3));
	translate([0, 0, 3.8 + 1.5]) cylinder(h = base_height * 2, r = 3);
}

module hotendcoverhole() {
	cylinder(h = 2.5, d = genscrewhole(3));
	translate([0, 0, 2]) cylinder(h = base_height * 2, r = 3.15);
}

module bottomwheelscrewspacer() {
	cylinder(h = 5, d = 10.5);
	translate([0, 0, 5]) sphere(d = 10.5);
}

difference() {
	union() {
		translate([0, -extra_offset, 0]) hotend();
		bracket();
		translate(pos_cover_rightwheelscrew) cube([10.5, 10.5, base_height]); // cover right wheel screw spacing
	}
	translate([2.5, 36 - extra_offset, 18.55 + extra_height]) rotate([0, 90, 0]) cylinder(h = 10.5, d = 40); // make space for extruder gear
	translate(pos_leftwheelspacing)     wheelscrewspacer(); // increase size of left wheel screw spacing
	translate(pos_rightwheelspacing)    wheelscrewspacer(); // increase size of right wheel screw spacing
	translate(pos_lefthotendscrewhole)  hotendscrewhole();  // increase size of left stock hotend screw hole
	translate(pos_righthotendscrewhole) hotendscrewhole();  // increase size of right stock hotend screw hole
	translate(pos_lefthotendcoverhole)  hotendcoverhole();  // add left screw hole for stock hotend cover
	translate(pos_righthotendcoverhole) hotendcoverhole();  // add right screw hole for stock hotend cover
	translate([width_offset, 25, 0]) rotate([0, 0, 270]) cylindercube(30, 3 * 3, 30);
	translate([-2.25, -8.75, 0]) bottomwheelscrewspacer();
}
