height		= 8;
screw_width	= 2;

inner_cyl_dia 	= 5;
outer_cyl_dia	= 8;
cyl_diff	= outer_cyl_dia - inner_cyl_dia;
cyl_45_vect	= sqrt(pow(outer_cyl_dia / 2, 2) - pow(inner_cyl_dia / 2, 2));
arm_len		= 9 + outer_cyl_dia / 2;
arm_width	= cyl_diff * 2/3;

$fn = $preview ? 25 : 50;

rotate([0, 0, 90]) {
	translate([inner_cyl_dia / 2 + cyl_diff - arm_width, 0, 0]) difference() {
		cube([arm_width, arm_len, height]);

		difference() {
			cube([arm_width, cyl_45_vect, height]);

			intersection() {
				translate([0, cyl_45_vect, 0]) scale([1, cyl_45_vect / arm_width, 1]) cylinder(height, r = arm_width);
				cube([arm_width, cyl_45_vect, height]);
			}
		}

		translate([0, arm_len * 0.75, height / 2]) {
			rotate([0, 90, 0]) {
				cylinder(arm_width, r = screw_width / 2);
				cylinder(arm_width * 1/3, r = screw_width);

				translate([0, arm_len * 0.25 - screw_width / 2, 0]) {
					translate([height / 2 - screw_width / 2, 0, 0]) difference() {
						cube([screw_width / 2, screw_width / 2, arm_width]);

						intersection() {
							cylinder(arm_width, r = screw_width / 2);
							cube([screw_width / 2, screw_width / 2, arm_width]);
						}
					}
					translate([-height / 2 + screw_width / 2, 0, 0]) rotate([0, 0, 90]) difference() {
						cube([screw_width / 2, screw_width / 2, arm_width]);

						intersection() {
							cylinder(arm_width, r = screw_width / 2);
							cube([screw_width / 2, screw_width / 2, arm_width]);
						}
					}
				}
			}
		}
	}

	in_corn_rad = cyl_diff;
	translate([inner_cyl_dia / 2 + cyl_diff - arm_width, outer_cyl_dia / 2 + in_corn_rad, 0]) {
		translate([-arm_width / 2 - 0.2, 0.3, 0]) scale([0.4, 1.3, 1]) rotate([0, 0, 270]) difference() {
			#cube([in_corn_rad, in_corn_rad, height]);

			intersection() {
				cylinder(height, r = in_corn_rad);
				cube([in_corn_rad, in_corn_rad, height]);
			}
		}

		translate([0, -in_corn_rad * 1.2, 0]) rotate([0, 0, 180]) cube([cyl_45_vect / 2, cyl_45_vect / 2, height]);
	}

	difference() {
		cylinder(height, r = outer_cyl_dia / 2);
		cylinder(height, r = inner_cyl_dia / 2);
	}
}
