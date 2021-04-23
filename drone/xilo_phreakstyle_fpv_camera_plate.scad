use <fpv_camera_mount.scad>

d = 3;
h = 27;
w = 40;

translate([0, 0, 0.5]) {
	sh = d / 12 * 11;
	sd = sh;
	translate([10, -sd, 0]) cube([7.75, sh, sd]);
	translate([4, h, 0])    cube([4.75, sh, sd]);
	translate([19, h, 0])   cube([4.75, sh, sd]);
}

difference() {
	d1 = d / 4 * 5;
	mh = h / 2;
	mw = w / 5 * 4;

	union() {
		difference() {
			cube([mw, h, d1]);
		}

		translate([mw, mh, 0]) difference () {
			intersection() {
				cylinder(d1, r = mh);
				translate([-2, 0, 0]) scale([1, 1.3, 1]) cylinder(d1, r = mh);
				translate([0, -mh, 0]) cube([mh, h, d1]);
			}
		}
	}
	translate([mw / 6 * 4 , 0, 0]) {
		intersection() {
			translate([0, mh / 5, 0]) cube([mw / 6 * 3.5, mh / 5 * 8, d1]);
			translate([0, mh, 0]) {
				translate([mw / 6 * 1.8, 0, 0]) {
					scale([0.8, 0.8, 1]) intersection() {
						scale([0.9, 2, 1]) cylinder(d1, r = 10);
						scale([1, 1.1, 1]) cylinder(d1, r = mh / 5 * 4);
						scale([2, 1, 1]) cylinder(d1, r = mh / 5 * 4);
						scale([1.1, 1, 1]) cylinder(d1, r = mh / 5 * 4);
						scale([1, 1.15, 1]) cylinder(d1, r = mh / 5 * 3.8);
					}
				}
			}
		}
	}
	translate([w / 3, mh, 0]) {
		fpv_camera_mount(d1, 2.2);
		translate([0, 0, -0.2]) fpv_camera_mount(1, 4.5);
		translate([0, 0, d1 - 0.8]) fpv_camera_mount(1, 4.5);
	}
}
