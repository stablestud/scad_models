$fn = $preview ? 10 : 50;


module baseplate() {
	intersection() {
		translate([0, 0, 9.5]) import("./Aero_Mount_ABLversion.stl");
		translate([-35, -4, 0]) cube([85, 90, 0.1]);
	}
}

baseplate();
