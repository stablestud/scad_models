anti_warp = .2;

$fn = $preview ? 25 : 50;

module baseplate() {
	difference() {
		union() {
			projection(cut = true) {
				translate([0, 0, 9.4]) import("./Aero_Mount_ABLversion.stl");
			}
			translate([-28, 26]) square(10.5); // cover left wheel screw spacing
			translate([12, 26]) square(10.5); // cover right wheel screw spacing
			translate([-23.8, 8.5]) square(3.5); // cover unused left bottom screw hole
			translate([-6.2, 27.4]) square(3.5); // cover screw hole under stepper
			translate([3.5, 16]) square(6); // cover left stock hotend screw hole
			translate([17.5, 16]) square(6); // cover right stock hotend screw hole
		}
		translate([-23, 31.5]) circle(d = 12); // increase size of left wheel screw spacing
		translate([20, 31.5]) circle(d = 12); // increase size of right wheel screw spacing
		translate([6.55, 18.85]) circle(3.5); // increase size of left stock hotend screw hole
		translate([20.55, 18.85]) circle(3.5); // increase size of right stock hotend screw hole
		translate([-4.4, 40]) circle(d = 3 * (anti_warp + 1)); // add left screw hole for stock hotend cover // TODO: test
		translate([35, 40]) circle(d = 3 * (anti_warp + 1)); // add right screw hole for stock hotend cover // TODO: test
	}
}

translate([0, 0, 9.5]) import("./Aero_Mount_ABLversion.stl");
//linear_extrude(0.2) baseplate();
