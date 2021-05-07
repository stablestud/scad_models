// Configure the width of the protector to fit on the arm, not points measured are on both sides of "length"
// Required as the arm width increases from the motor side to the flight controller side
inner_width = 14;
outer_width = 15;

// Length of the wire guard
length = 25;

// Thickness (or rather height) of the arm
thickness = 4;
// Thickness of the wire guard walls
wall_thickness = 1;

// Add small clips/standoffs to the backside to keep the guard on the arm
clips = true;

// Required height for the wires to go through 
wire_thickness = 2.5;

$fn = $preview ? 15 : 50;

assert(length, "length cannot be zero");

module clip() {
	rotate([0, 0, 270]) translate([-wall_thickness / 2, -wall_thickness / 2]) difference() {
		polygon([[0, 0],
			[thickness / 2 + wall_thickness / 2, 0],
			[thickness / 2 + wall_thickness / 2, wall_thickness * 2],
			[thickness / 2, wall_thickness * 2],
			[thickness / 2, wall_thickness],
			[0, wall_thickness]]);
		translate([thickness / 2, wall_thickness / 2]) rotate([0, 0, 270]) difference() {
			square([wall_thickness / 2, wall_thickness / 2]);
			circle(d = wall_thickness);
		}
	}
}

module wire_shaft() {
	rotate([0, 0, 90]) translate([0, -inner_width / 2 - wall_thickness]) {
		difference() {
			polygon([[0, 0],
				[wire_thickness, 0],
				[wire_thickness + wall_thickness, wall_thickness],
				[wire_thickness + wall_thickness, wall_thickness + inner_width],
				[wire_thickness, wall_thickness * 2 + inner_width],
				[0, wall_thickness * 2 + inner_width]]);
			#translate([0, wall_thickness * 2]) square([wire_thickness, inner_width - wall_thickness * 2]);
		}
	}
}

module 2dmodel() {
	wire_shaft();
	translate([-inner_width / 2 - wall_thickness, -thickness / 2]) square([wall_thickness, thickness / 2]);
	translate([inner_width / 2, -thickness / 2]) square([wall_thickness, thickness / 2]);
	if (clips) {
		translate([inner_width / 2 + wall_thickness / 2, -thickness / 2 - wall_thickness / 2]) mirror([1, 0]) clip();
		translate([-inner_width / 2 - wall_thickness / 2, -thickness / 2 - wall_thickness / 2]) clip();
	}
}

module 3dmodel() {
	linear_extrude(height = length, center = true, scale = [outer_width / inner_width, 1]) 2dmodel();
}

rotate([270]) 3dmodel();
