$fn = 50;

module base_model() {
	translate([0, -44]) rotate([0, 0, 54.75]) import("./SO_v4_5inch_arm_4mm_4x.dxf");
}

linear_extrude(2, center = true) base_model();
