$fn=32;

difference() {
	union() {
		translate([-54.5,06.6,-54]) rotate([90,0]) import("mushroom_top.stl");
		import("part_connector.stl");
	}
}
