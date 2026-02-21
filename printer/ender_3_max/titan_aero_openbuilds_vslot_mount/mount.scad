/* Titan (Aero) Direct Drive mount for Openbuilds 20mm V-Slot Gantry and OpenBuilds V-Slot Mini Gantry
 *
 * Compatible part cooling fans:
 *   - https://www.thingiverse.com/thing:3078853
 *   - https://www.thingiverse.com/thing:3364313
 * 
 * Design resources:
 *   - https://grabcad.com/library/titan-aero-extruder-assembly-1
 *   - https://github.com/eric-wieser/2.12-robot/blob/master/hardware/Third-party/Openbuilds/PDF%20Drawings/V-Slot%20Gantry%20Plate%2020mm.PDF
 *   - https://github.com/eric-wieser/2.12-robot/blob/master/hardware/Third-party/Openbuilds/PDF%20Drawings/Mini%20V%20Wheel%20Plate.PDF
 *   - https://github.com/Creality3DPrinting/Ender-3/blob/master/Ender-3%20Mechanical/PDF/E%20plate.pdf
 *
 * This is file messy and unorganized as it was quickly hacked together, works fairly well tho
 */

titan_mount_wall_thickness = 2.5;
vslot_mount_wall_thickness = 3;
belt_thickness = 1.2;
belt_width = 7;

titan_to_20mm_plate_offset = [ -7, 0, 32.5 ]; // define the offset of titan from the plate, with that the titan mount can be moved
titan_to_mini_plate_offset = [ -12, 0, 32.5 ];

titan_motor_dia = 43;
titan_motor_holes_offset = [ 31 / 2, 31 / 2 ];
titan_motor_holes_dia    = 3.2;
titan_motor_shaft_hole_dia = 27;
titan_motor_size = [ titan_motor_dia, titan_motor_dia, 55 ];
titan_extruder1_size = [ 47, 45, 57 ];
titan_extruder1_offset = [ titan_mount_wall_thickness / 2 + titan_extruder1_size.z / 2, 2, -2 ];
titan_extruder2_size = [ 47, 60, 55 ];
titan_extruder2_offset = [ titan_mount_wall_thickness / 2 + titan_extruder2_size.z / 2 + 3.9, 0 ];
titan_hotend_clear_zone_size = [ titan_extruder1_size.z, titan_extruder1_size.z, titan_motor_dia * 3 ];
titan_hotend_clear_zone_offset = [ 0, -titan_extruder1_size.y / 2 - titan_mount_wall_thickness * 2 - titan_hotend_clear_zone_size.y / 2 + 2, 0 ];
titan_gear_dia = 38;
titan_gear_thickness = 8;
titan_gear_offset = [ titan_motor_holes_offset.x, titan_motor_holes_offset.y, titan_gear_thickness / 2 + titan_mount_wall_thickness / 2 + 4 ];
titan_motor_plug_size = [ 40, 12, 6 ];
titan_motor_plug_offset = [ -13 - titan_motor_plug_size.x / 2, 0, titan_motor_dia / 2 + titan_motor_plug_size.z / 2 ];

creality_fan_mount_thickness = 7.6;
creality_fan_mount_offset = [ 28.5, -creality_fan_mount_thickness / 2 + 1.3, 0.1 ];
creality_fan_mount_hole_length = 6;
creality_fan_mount_hole_width = 3.1;
creality_fan_mount_hole_wall_thickness = 2.8;

abl_mount_size = [ 3, 15, 7.15 ];
abl_mount_screw_dia = 2.8;
abl_mount_screw_length = 10;
abl_mount_offset = [ titan_mount_wall_thickness / 2 - abl_mount_size.x / 2 + 48, titan_motor_holes_offset.y - 1, abl_mount_size.z / 2 - vslot_mount_wall_thickness / 2 ];
abl_mount_extra_offset = [ 10, 0 ];
abl_mount_hull_height = abl_mount_size.z * 2;

vslot_20mm_holes_dia = 5.1;
vslot_20mm_holes_nut_dia = vslot_20mm_holes_dia; // actually 7.2 but we use normal M5 screws instead
vslot_20mm_holes_dis = 10; // plate holes distance from each other
vslot_20mm_holes_to_edge_offset = 15; // extend plate this amount of mm beyond screw limits
vslot_20mm_holes_top_bot_swap = 0;
vslot_20mm_holes_top_enable   = [ 0, 1, 0, 0, 0 ]; // what screw holes to generate, see below for pos
vslot_20mm_holes_top_head_offset = [ 1, 1, 1, 1, 1 ]; // additional hole height offset to plate (default is vslot plate thickness)
vslot_20mm_holes_top_head_nut = [ 1, 1, 1, 1, 1 ]; // generate a nut hole instead of a round hole
vslot_20mm_holes_top_head_nut_dia = [ vslot_20mm_holes_dia * 1.6,     // 1, nuts from left to right; only for nut holes, not round holes
					vslot_20mm_holes_dia * 1.6,   // 2
					vslot_20mm_holes_dia * 1.6,   // 3
					vslot_20mm_holes_dia * 1.6,   // 4
					vslot_20mm_holes_dia * 1.6 ]; // 5
vslot_20mm_holes_top_head_dia = [ vslot_20mm_holes_dia * 1.9,         // 1, holes from left to right; only for round holes, not nuts
					vslot_20mm_holes_dia * 1.9,   // 2
					vslot_20mm_holes_dia * 1.9,   // 3
					vslot_20mm_holes_dia * 1.9,   // 4
					vslot_20mm_holes_dia * 1.9 ]; // 5
vslot_20mm_holes_top_head_height = [ 5, 5, 5, 5, 5 ];
vslot_20mm_holes_top_head_fade = [ 50, 50, 50, 50, 50 ];
vslot_20mm_holes_top_head_fade_cutoff = [ 10, 10, 10, 10, 10 ];
vslot_20mm_holes_cross_enable = [ 0, 0, 0, 0, 0 ]; // what screw holes to generate, see below for pos
vslot_20mm_holes_cross_head_offset = [ 1, 1, 1, 1, 1 ]; // additional hole height offset to plate
vslot_20mm_holes_cross_head_nut = [ 1, 1, 1, 1, 1 ]; // generate a nut hole instead of a round hole
vslot_20mm_holes_cross_head_nut_dia = [ vslot_20mm_holes_dia * 1.6,     // 1, nuts from left to right; only for nut holes, not round holes
					vslot_20mm_holes_dia * 1.6,   // 2
					vslot_20mm_holes_dia * 1.6,   // 3
					vslot_20mm_holes_dia * 1.6,   // 4
					vslot_20mm_holes_dia * 1.6 ]; // 5
vslot_20mm_holes_cross_head_dia = [ vslot_20mm_holes_dia * 1.9,       // 1, holes from top clockwise
					vslot_20mm_holes_dia * 1.9,   // 2
					vslot_20mm_holes_dia * 1.9,   // 3
					vslot_20mm_holes_dia * 1.9,   // 4
					vslot_20mm_holes_dia * 1.9 ]; // center
vslot_20mm_holes_cross_head_height = [ 5, 5, 5, 5, 5 ];
vslot_20mm_holes_cross_head_fade = [ 50, 50, 50, 50, 50 ];
vslot_20mm_holes_cross_head_fade_cutoff = [ 10, 10, 10, 10, 10 ];
vslot_20mm_holes_bot_enable   = [ 0, 0, 1, 0, 0 ]; // what screw holes to generate, see below for pos
vslot_20mm_holes_bot_head_offset = [ 1, 1, 1, 1, 1 ]; // additional hole height offset to plate
vslot_20mm_holes_bot_head_nut = [ 1, 1, 1, 1, 1 ]; // generate a nut hole instead of a round hole
vslot_20mm_holes_bot_head_nut_dia = [ vslot_20mm_holes_dia * 1.6,     // 1, nuts from left to right; only for nut holes, not round holes
					vslot_20mm_holes_dia * 1.6,   // 2
					vslot_20mm_holes_dia * 1.6,   // 3
					vslot_20mm_holes_dia * 1.6,   // 4
					vslot_20mm_holes_dia * 1.6 ]; // 5
vslot_20mm_holes_bot_head_dia = [ vslot_20mm_holes_dia * 1.9,         // 1; holes from left to right
					vslot_20mm_holes_dia * 1.9,   // 2
					vslot_20mm_holes_dia * 1.9,   // 3
					vslot_20mm_holes_dia * 1.9,   // 4
					vslot_20mm_holes_dia * 1.9 ]; // 5
vslot_20mm_holes_bot_head_height = [ 5, 5, 5, 5, 5 ];
vslot_20mm_holes_bot_head_fade = [ 50, 50, 50, 50, 50 ];
vslot_20mm_holes_bot_head_fade_cutoff = [ 10, 10, 10, 10, 10 ];
vslot_20mm_holes_side_enable = [[ 1, 1], [ 1, 1 ]]; // left side (top, bottom), right side (top, bottom)
vslot_20mm_holes_side_bridge = [ 0, 0 ]; // weather the top and bottom should be connected/bridged (left, right)
vslot_20mm_holes_side_head_offset = [ 1, 1 ]; // additional hole height offset to plate (left, right)
vslot_20mm_holes_side_head_nut = [ 1, 1 ]; // generate a nut hole instead of a round hole (left, right)
vslot_20mm_holes_side_head_nut_dia = [ vslot_20mm_holes_dia * 1.6,    // left
					vslot_20mm_holes_dia * 1.6 ]; // right
vslot_20mm_holes_side_head_dia = [ vslot_20mm_holes_dia * 1.9,        // left
					vslot_20mm_holes_dia * 1.9 ]; // right
vslot_20mm_holes_side_head_height = [ vslot_20mm_holes_side_bridge[0] ? 3 : 5, vslot_20mm_holes_side_bridge[1] ? 3 : 5 ];
vslot_20mm_holes_side_head_fade = [ vslot_20mm_holes_side_bridge[0] ? 40 : 60, vslot_20mm_holes_side_bridge[1] ? 40 : 60 ];
vslot_20mm_holes_side_head_fade_cutoff = [ 20, 20 ];
vslot_20mm_wheel_screw_dia = 9; // cutout for screw to wheel spacing which must be reversed
vslot_20mm_wheel_screw_height = 6;
vslot_20mm_wheel_screw_eccentric_swap = 1; // if the eccentric nuts are on the top and not on the bottom
vslot_20mm_wheel_screw_nut = true; // if instead of a simple screw hole generate a nut hole
vslot_20mm_wheel_screw_nut_dia = vslot_20mm_holes_dia * 1.6;
vslot_20mm_wheel_screw_nut_eccentric_extra_dia = 1.5;
vslot_20mm_wheel_dia = 26;
vslot_20mm_wheel_height = 12;
vslot_20mm_wheel_washer_dia = 10.4;
vslot_20mm_wheel_washer_height = 6;
vslot_20mm_wheel_washer_wall_thickness = 1;
vslot_20mm_wheel_washer_top_height = 0.5;
vslot_20mm_wheel_top_plate_thickness = 1.25;
vslot_20mm_wheel_top_plate_dia = vslot_20mm_wheel_washer_dia - 0.5;
vslot_20mm_edge_hole_to_plate_offset = [ 8, 0 ];
vslot_20mm_edge_hole_offset = 3.3;
vslot_20mm_edge_hole_dia = 3.1;
vslot_20mm_belt_plate_thickness = 2.5;
vslot_20mm_belt_mount_height = vslot_20mm_wheel_washer_height + vslot_20mm_wheel_height + vslot_20mm_wheel_washer_top_height + vslot_20mm_wheel_top_plate_thickness;
vslot_20mm_belt_mount_offset = [ 14.5, 4.5, vslot_20mm_belt_mount_height / 2 - vslot_20mm_wheel_washer_height / 2];
vslot_20mm_belt_mount_screw_size = 2.2;
vslot_20mm_belt_mount_2screw_dis = 3.2;
vslot_20mm_belt_mount_scale = [ 1, 1, 1 ];
vslot_20mm_belt_slot_extra_height = 1.5;
vslot_20mm_belt_slot_offset = [ 0, 0, belt_width / 2 - vslot_20mm_wheel_height / 2 + vslot_20mm_belt_slot_extra_height];
vslot_20mm_belt_slot_tun_offset = [ 20, -8 ];
vslot_20mm_belt_slot_tun_dia = vslot_20mm_belt_mount_screw_size * 14;
vslot_20mm_belt_plate_bottom_offset = [ 0, 0, vslot_20mm_wheel_washer_height / 2 + vslot_20mm_belt_slot_extra_height - 1.5 ];
vslot_20mm_belt_bound_box_extra_size = [ 10, -10 ];

vslot_mini_plate_size = [ 50, 50, vslot_mount_wall_thickness ];
vslot_mini_holes_dia = 5.1;
vslot_mini_holes_dis = 10; // plate holes distance from each other
vslot_mini_holes_to_edge_offset = 10; // extend plate this amount of mm beyond screw limits
vslot_mini_holes_enable   = [ 0, 1, 1, 1, 0 ]; // what screw holes to generate, see below for pos
vslot_mini_holes_head_offset = [ 1, 1, 1, 1, 1 ]; // additional hole height offset to plate
vslot_mini_holes_head_nut = [ 0, 0, 0, 0, 0 ]; // generate a nut hole instead of a round hole
vslot_mini_holes_head_dia = [ vslot_mini_holes_dia * 1.9,         // 1, holes from top clockwise
					vslot_mini_holes_dia * 1.9,   // 2
					vslot_mini_holes_dia * 1.9,   // 3
					vslot_mini_holes_dia * 1.9,   // 4
					vslot_mini_holes_dia * 1.9 ]; // center
vslot_mini_holes_head_height = [ 5, 5, 5, 10, 5 ];
vslot_mini_holes_head_fade = [ 10, 10, 10, 10, 10 ];
vslot_mini_holes_head_fade_cutoff = [ 4, 4, 4, 2, 4 ];
vslot_mini_wheel_screw_offset = [ 15, 15.95 ];
vslot_mini_wheel_screw_height = 5.5;
vslot_mini_wheel_screw_dia = 9; // cutout for screw to wheel spacing which are preinstalled
vslot_mini_wheel_screw_nuts_swap = 1; // if eccentric nut is on the top and not on the bottom
vslot_mini_wheel_dia = 17;
vslot_mini_wheel_height = 10;
vslot_mini_wheel_washer_dia = 10.4;
vslot_mini_wheel_washer_height = 6;
vslot_mini_wheel_washer_wall_thickness = 1.5;
vslot_mini_wheel_side_cutout_offset = [ 0, -1 ];
vslot_mini_wheel_to_belt_edge_offset = [ 10.2, 0 ];
vslot_mini_belt_edge_extra_offset = [ 5, 0 ];
vslot_mini_belt_slot_extra_height = 1;
vslot_mini_belt_slot_mount_width = 14;
vslot_mini_belt_slot_offset = [ vslot_mini_wheel_dia / 2 + 3, 0.5 ];
vslot_mini_belt_slot_tun_offset = [ 0.5, 2, 0 ];
vslot_mini_belt_slot_tun_cyl_offset = [ 15, -1 ];
vslot_mini_belt_slot_tun_dia = vslot_mini_belt_slot_mount_width * 2;
vslot_mini_belt_mount_height = vslot_mini_wheel_washer_height + vslot_mini_wheel_height + vslot_mini_belt_slot_extra_height;
vslot_mini_belt_plate_thickness = 5;
vslot_mini_belt_plate_mount_screw_dia = 3;
vslot_mini_belt_plate_mount_screw_wall_thickness = 1.5;
vslot_mini_belt_plate_mount_depth = vslot_mini_belt_edge_extra_offset.x;
vslot_mini_belt_plate_mount_offset = [ vslot_mini_wheel_to_belt_edge_offset.x + vslot_mini_belt_plate_mount_depth / 2, vslot_mini_wheel_washer_dia / 2 - vslot_mini_belt_plate_mount_screw_dia + 0.5, -vslot_mini_wheel_washer_height / 2 - vslot_mini_belt_plate_thickness - vslot_mini_belt_plate_mount_screw_dia / 2 - vslot_mini_belt_plate_mount_screw_wall_thickness - 0.5 ];

$fn = $preview ? 15 : 30;

function face_distance(diameter) = diameter / cos(30);

module vslot_mini_wheel()
{
	translate([0, 0, vslot_mini_belt_slot_extra_height / 2]) cylinder(d = vslot_mini_wheel_dia, h = vslot_mini_wheel_height + vslot_mini_belt_slot_extra_height, center = true);
}

module vslot_mini_wheel_washer()
{
	cylinder(d = vslot_mini_wheel_washer_dia, h = vslot_mini_wheel_washer_height, center = true);
}

module vslot_mini_wheel_outline()
{
	translate([0, 0, vslot_mini_wheel_washer_height / 2 + vslot_mini_wheel_height / 2]) vslot_mini_wheel();
	vslot_mini_wheel_washer();
}

module vslot_mini_wheel_washer_wall()
{
	difference() {
		cube_dia = vslot_mini_wheel_washer_dia / 2 + vslot_mini_wheel_washer_wall_thickness;
		translate([-cube_dia / 2, cube_dia / 2])
				cube([cube_dia, cube_dia, vslot_mini_wheel_washer_height], center = true);
		cylinder(d = vslot_mini_wheel_washer_dia + vslot_mini_wheel_washer_wall_thickness * 2, h = vslot_mini_wheel_washer_height, center = true);
	}
	difference() {
		cylinder(d = vslot_mini_wheel_washer_dia + vslot_mini_wheel_washer_wall_thickness * 2, h = vslot_mini_wheel_washer_height, center = true);
		vslot_mini_wheel_washer();
	}
}

module vslot_mini_belt_plate_mount_hole()
{
	rotate([0, 90])
			cylinder(d = vslot_mini_belt_plate_mount_screw_dia, h = vslot_mini_belt_plate_mount_depth, center = true);
}

module vslot_mini_belt_plate_mount()
{
	rotate([0, 90])
			cylinder(d = vslot_mini_belt_plate_mount_screw_dia + vslot_mini_belt_plate_mount_screw_wall_thickness * 2, h = vslot_mini_belt_plate_mount_depth, center = true);
}

module vslot_mini_belt_slot_hole()
{
	belt_height_adjust = vslot_mini_belt_slot_extra_height + 1.5;
	translate([0, 0, vslot_mini_wheel_washer_height / 2 + vslot_mini_wheel_height / 2])
			translate([0, 0, belt_height_adjust / 2])
			translate(vslot_mini_belt_slot_offset)
			translate(vslot_mini_belt_slot_tun_offset)
			difference() {
				hull() {
					cylinder(d = vslot_mini_belt_slot_mount_width / 5 + belt_thickness * 2, h = belt_width + belt_height_adjust, center = true);
					translate(vslot_mini_belt_slot_tun_cyl_offset) cylinder(d = vslot_mini_belt_slot_tun_dia + belt_thickness * 2, h = belt_width + belt_height_adjust, center = true);
				}
				hull() {
					cylinder(d = vslot_mini_belt_slot_mount_width / 5, h = belt_width + belt_height_adjust, center = true);
					translate(vslot_mini_belt_slot_tun_cyl_offset) cylinder(d = vslot_mini_belt_slot_tun_dia, h = belt_width + belt_height_adjust, center = true);
				}
	}
}

module vslot_mini_belt_plate_cutout()
{
	translate([-20 / 2 + vslot_mini_wheel_to_belt_edge_offset.x, 0, -vslot_mini_belt_plate_thickness * 3 / 2 - vslot_mini_wheel_washer_height / 2])
			cube([20, 30, vslot_mini_belt_plate_thickness * 3], center = true);
}

module vslot_mini_belt_standoff_cutout()
{
	translate(vslot_mini_belt_edge_extra_offset)
		translate(vslot_mini_wheel_to_belt_edge_offset)
		translate([10 / 2, 0])
		cube([10, 40, vslot_mini_belt_plate_thickness + vslot_mini_belt_mount_height * 2], center = true);
}

module vslot_mini_belt_cutout()
{
	vslot_mini_wheel_outline();
	vslot_mini_belt_slot_hole();
	vslot_mini_belt_plate_cutout();
	vslot_mini_belt_standoff_cutout();
	translate(vslot_mini_belt_plate_mount_offset) vslot_mini_belt_plate_mount_hole();
	cube_dia = vslot_mini_wheel_washer_dia / 2 + vslot_mini_wheel_washer_wall_thickness;
	translate([-cube_dia / 2, cube_dia / 2, vslot_mini_wheel_washer_height])
			cube([cube_dia, cube_dia, vslot_mini_wheel_washer_height], center = true);
	translate([0, vslot_mini_wheel_washer_dia / 2 + vslot_mini_wheel_washer_wall_thickness + 10 / 2])
			translate(vslot_mini_wheel_side_cutout_offset)
			cube([40, 10, 60], center = true);
}

module vslot_mini_belt_slot_mount()
{
	translate([0, 0, vslot_mini_belt_mount_height / 2 - vslot_mini_wheel_washer_height / 2])
			intersection() {
				translate(vslot_mini_belt_slot_offset)
						cylinder(d = vslot_mini_belt_slot_mount_width, h = vslot_mini_belt_mount_height, center = true);
	}
}

module vslot_mini_belt_slot_mount_plate()
{
	hull() {
		vslot_mini_wheel_washer_wall();
		vslot_mini_belt_slot_mount();
	}
}

module vslot_mini_belt_plate()
{
	difference() {
		union() {
			vslot_mini_belt_slot_mount_plate();
			hull() {
				intersection() {
					cube([40, 40, vslot_mini_wheel_washer_height], center = true);
					vslot_mini_belt_slot_mount_plate();
				}
				translate(vslot_mini_belt_plate_mount_offset)
						vslot_mini_belt_plate_mount();
			}
		}
		vslot_mini_belt_cutout();
	}
}

module vslot_20mm_wheel()
{
	cylinder(d = vslot_20mm_wheel_dia, h = vslot_20mm_wheel_height, center = true);
}

module vslot_20mm_wheel_washer()
{
	cylinder(d = vslot_20mm_wheel_washer_dia, h = vslot_20mm_wheel_washer_height, center = true);
}

module vslot_20mm_wheel_outline()
{
	translate([0, 0, vslot_20mm_wheel_washer_height / 2 + vslot_20mm_wheel_height / 2]) vslot_20mm_wheel();
	vslot_20mm_wheel_washer();
}

module vslot_20mm_wheel_washer_wall()
{
	difference() {
		cylinder(d = vslot_20mm_wheel_washer_dia + vslot_20mm_wheel_washer_wall_thickness * 2, h = vslot_20mm_wheel_washer_height, center = true);
		vslot_20mm_wheel_washer();
	}
}

module vslot_20mm_edge_hole(extra_dia = 0)
{
	for (i = [-1, 1]) {
		translate([0, i * vslot_20mm_edge_hole_offset]) cylinder(d = vslot_20mm_edge_hole_dia + extra_dia, h = vslot_20mm_wheel_washer_height, center = true);
	}
}

module vslot_20mm_edge_wall()
{
	hull() vslot_20mm_edge_hole(vslot_20mm_belt_plate_thickness * 2);
}

module vslot_20mm_belt_cutout()
{
	vslot_20mm_wheel_outline();
	translate(vslot_20mm_edge_hole_to_plate_offset) vslot_20mm_edge_hole();
	scale([1, 1, 50]) vslot_20mm_plate_hole();
	translate([0, 0, vslot_20mm_wheel_height + vslot_20mm_wheel_washer_height / 2]) {
		translate([0, 0, vslot_20mm_wheel_washer_top_height + max(1.5, vslot_20mm_wheel_top_plate_thickness / 2)]) cylinder(d = vslot_20mm_wheel_washer_dia + vslot_20mm_wheel_washer_wall_thickness * 3, h = vslot_20mm_wheel_top_plate_thickness);
		difference() {
			cylinder(d = vslot_20mm_wheel_dia, h = vslot_20mm_wheel_washer_top_height);
			cylinder(d = vslot_20mm_wheel_top_plate_dia, h = vslot_20mm_wheel_washer_top_height);
		}
	}
	translate(vslot_20mm_belt_mount_offset) {
		vslot_20mm_belt_mount_screw();
		translate(vslot_20mm_belt_slot_offset) vslot_20mm_belt_slot_hole();
	}
}

module vslot_20mm_belt_mount_screw()
{
	cylinder(d = vslot_20mm_belt_mount_screw_size, h = vslot_20mm_belt_mount_height, center = true);
	translate([0, 0, vslot_20mm_belt_mount_height / 2 + -vslot_20mm_belt_mount_screw_size / 2]) cylinder(d = vslot_20mm_belt_mount_screw_size * 2, h = vslot_20mm_belt_mount_screw_size, center = true);
}

module vslot_20mm_belt_mount_2screw()
{
	for (i = [-1, 1]) {
		translate([i * vslot_20mm_belt_mount_2screw_dis / 2, 0]) {
			cylinder(d = vslot_20mm_belt_mount_screw_size, h = vslot_20mm_belt_mount_height, center = true);
			translate([0, 0, -i * vslot_20mm_belt_mount_height / 2 + i * vslot_20mm_belt_mount_screw_size / 2]) cylinder(d = vslot_20mm_belt_mount_screw_size * 2, h = vslot_20mm_belt_mount_screw_size, center = true);
		}
	}
}

module vslot_20mm_belt_slot_mount()
{
	difference() {
		scale(vslot_20mm_belt_mount_scale) cylinder(d = vslot_20mm_belt_mount_screw_size * 5.5, h = vslot_20mm_belt_mount_height, center = true);
		vslot_20mm_belt_mount_screw();
	}
}

module vslot_20mm_belt_slot_hole()
{
	difference() {
		hull() {
			cylinder(d = vslot_20mm_belt_mount_screw_size + belt_thickness * 2, h = belt_width);
			translate(vslot_20mm_belt_slot_tun_offset) cylinder(d = vslot_20mm_belt_slot_tun_dia + belt_thickness * 2, h = belt_width);
		}
		hull() {
			cylinder(d = vslot_20mm_belt_mount_screw_size, h = belt_width);
			translate(vslot_20mm_belt_slot_tun_offset) cylinder(d = vslot_20mm_belt_slot_tun_dia, h = belt_width);
		}
	}
}

module vslot_20mm_wheel_top_plate()
{
	cylinder(d = vslot_20mm_wheel_top_plate_dia, h = vslot_20mm_wheel_washer_top_height);
	translate([0, 0, vslot_20mm_wheel_washer_top_height]) cylinder(d = vslot_20mm_wheel_washer_dia + vslot_20mm_wheel_washer_wall_thickness * 3, h = vslot_20mm_wheel_top_plate_thickness);
}

module vslot_20mm_belt_bounding_box()
{
	cube([vslot_20mm_wheel_dia + vslot_20mm_belt_bound_box_extra_size.x, vslot_20mm_wheel_dia + vslot_20mm_belt_bound_box_extra_size.y, vslot_20mm_belt_mount_height], center = true);
}

module vslot_20mm_belt_plate()
{
	intersection() {
		translate([0, 0, vslot_20mm_belt_mount_height / 2 - vslot_20mm_wheel_washer_height / 2]) vslot_20mm_belt_bounding_box();
		union() {
			hull() {
				vslot_20mm_wheel_washer_wall();
				translate(vslot_20mm_edge_hole_to_plate_offset) vslot_20mm_edge_wall();
			}
			translate([0, 0, vslot_20mm_wheel_height + vslot_20mm_wheel_washer_height / 2]) vslot_20mm_wheel_top_plate();
			translate(vslot_20mm_belt_mount_offset) vslot_20mm_belt_slot_mount();
		}
	}
}

module vslot_20mm_belt_plate_top()
{
	difference() {
		hull() intersection() {
			translate([0, 0, vslot_20mm_belt_mount_height]) translate(vslot_20mm_belt_plate_bottom_offset) vslot_20mm_belt_bounding_box();
			vslot_20mm_belt_plate();
		}
		vslot_20mm_belt_cutout();
	}
}

module vslot_20mm_belt_plate_bot()
{
	difference() {
		hull() intersection() {
			translate(vslot_20mm_belt_plate_bottom_offset) vslot_20mm_belt_bounding_box();
			vslot_20mm_belt_plate();
		}
		vslot_20mm_belt_cutout();
	}
}

module creality_fan_mount_hole()
{
	hull() {
		for (i = [1, -1]) {
			translate([0, i * creality_fan_mount_hole_length - i * creality_fan_mount_hole_width]) cylinder(d = creality_fan_mount_hole_width, h = creality_fan_mount_thickness, center = true);
		}
	}
}

module creality_fan_mount_holes()
{
	for (i = [1, -1]) {
		translate([0, i * creality_fan_mount_hole_length]) creality_fan_mount_hole();
	}
}

module creality_fan_mount()
{
	minkowski() {
		hull() creality_fan_mount_holes();
		cylinder(d = creality_fan_mount_hole_wall_thickness, h = 0.001, center = true);
	}
}

module creality_fan_mount_bridge()
{
	hull() {
		titan_mount_outline();
		translate([titan_mount_wall_thickness / 2, 0]) translate(creality_fan_mount_offset) creality_fan_mount();
	}
}

module titan_motor_holes()
{
	for (i = [[1, 1], [-1, 1], [-1, -1], [1, -1]]) {
		translate([i.x * titan_motor_holes_offset.x, i.y * titan_motor_holes_offset.y])
				cylinder(d = titan_motor_holes_dia, h = titan_mount_wall_thickness, center = true);
	}
}

module cyl_cube(size, roundness)
{
	minkowski() {
		cube([size.x - roundness, size.y - roundness, size.z - 0.001], center = true);
		cylinder(d = roundness, h = 0.001 / 2, center = true);
	}
}

module titan_motor_shaft_hole()
{
	cylinder(d = titan_motor_shaft_hole_dia, h = titan_mount_wall_thickness, center = true);
}

module titan_motor()
{
	cyl_cube(titan_motor_size, 4);
}

module titan_motor_plug()
{
	cyl_cube(titan_motor_plug_size, 4);
}

module titan_extruder1()
{
	translate(titan_extruder1_offset) rotate([0, 90]) cyl_cube(titan_extruder1_size, 2);
}

module titan_extruder2()
{
	translate(titan_extruder2_offset) rotate([0, 90]) cyl_cube(titan_extruder2_size, 2);
}

module titan_hotend_clear_zone()
{
	translate(titan_hotend_clear_zone_offset) cyl_cube(titan_hotend_clear_zone_size, 2);
}

module titan_mount_holes()
{
	titan_motor_shaft_hole();
	titan_motor_holes();
}

module titan_mount_outline()
{
	rotate([0, 0, 270]) scale([1, 1, 2]) minkowski() {
		hull() titan_mount_holes();
		cube([(titan_motor_dia - titan_motor_holes_offset.x * 2), (titan_motor_dia - titan_motor_holes_offset.y * 2), 0.001], center = true);
	}
}

module titan_outline()
{
	translate([-titan_mount_wall_thickness / 2, 0]) {
			translate([-titan_motor_size.z / 2, 0]) rotate([0, 90]) titan_motor();
			rotate([270, 0]) translate([0, 0, -0.02]) translate(titan_motor_plug_offset) titan_motor_plug();
	}
	titan_extruder1();
	titan_extruder2();
}

module titan_gear()
{
	rotate([0, 90]) translate(titan_gear_offset) cylinder(d = titan_gear_dia, titan_gear_thickness, center = true);
}

module abl_mount_hole()
{
	rotate([0, 90]) cylinder(d = abl_mount_screw_dia, h = abl_mount_screw_length, center = true);
}

module abl_mount_plate()
{
	translate([-abl_mount_size.x, 0]) abl_mount_interface();
}

module abl_mount_interface()
{
	translate([-abl_mount_size.x / 2, 0]) translate(abl_mount_offset) difference() {
		cube(abl_mount_size, center = true);
		abl_mount_hole();
	}
}

module vslot_20mm_plate_hole(height, dia = vslot_20mm_holes_dia)
{
	cylinder(d = vslot_20mm_holes_dia, h = height, center = true);
}

module vslot_20mm_plate_nut_hole(height, dia = vslot_20mm_holes_dia)
{
	cylinder(d = vslot_20mm_holes_nut_dia, h = height, center = true);
}

module vslot_20mm_plate_side_hole(height, dia = vslot_20mm_holes_dia, bridge = true, nut = false, side_enable = [1, 1])
{
	if (bridge) {
		hull() for (i = [[-1, side_enable[0]], [1, side_enable[1]]]) {
			if (i[1]) {
				translate([0, i[0] * -vslot_20mm_holes_dis]) rotate([0, 0, nut ? 30 : 0]) cylinder(d = dia, h = height, center = true, $fn = nut ? 6 : $fn);
			}
		}
	} else {
		for (i = [[-1, side_enable[0]], [1, side_enable[1]]]) {
			if (i[1]) {
				translate([0, i[0] * -vslot_20mm_holes_dis]) rotate([0, 0, nut ? 30 : 0]) cylinder(d = dia, h = height, center = true, $fn = nut ? 6 : $fn);
			}
		}
	}
}

module vslot_20mm_plate_side_fade_hole(height, d1 = vslot_20mm_holes_dia, d2 = vslot_20mm_holes_dia, bridge = true, side_enable = [1, 1])
{
	if (bridge) {
		hull() for (i = [[-1, side_enable[0]], [1, side_enable[1]]]) {
			if (i[1]) {
				translate([0, i[0] * -vslot_20mm_holes_dis]) cylinder(d1 = d1, d2 = d2, h = height, center = true);
			}
		}
	} else {
		for (i = [[-1, side_enable[0]], [1, side_enable[1]]]) {
			if (i[1]) {
				translate([0, i[0] * -vslot_20mm_holes_dis]) cylinder(d1 = d1, d2 = d2, h = height, center = true);
			}
		}
	}
}

module vslot_20mm_holes_side(side_enable, head=false)
{
	translate([-vslot_20mm_holes_dis * 2, 0]) for (i = [0,1]) {
		if (side_enable[i] && (side_enable[i][0] || side_enable[i][1])) {
			offset = head ? vslot_20mm_holes_side_head_offset[i] : 0;
			translate([vslot_20mm_holes_dis * 4 * i, 0]) {
				translate([0, 0, offset / 2]) vslot_20mm_plate_side_hole(height = offset + vslot_mount_wall_thickness, bridge = vslot_20mm_holes_side_bridge[i], side_enable = side_enable[i]);
				if (head) {
					head_height = vslot_20mm_holes_side_head_height[i];
					is_nut = vslot_20mm_holes_side_head_nut[i] ? true : false;
					dia = is_nut ? face_distance(vslot_20mm_holes_side_head_nut_dia[i]) : vslot_20mm_holes_side_head_dia[i];
					translate([0, 0, offset + vslot_mount_wall_thickness / 2 + head_height / 2]) {
						vslot_20mm_plate_side_hole(height = head_height, dia = dia, bridge = vslot_20mm_holes_side_bridge[i], nut = is_nut, side_enable = side_enable[i]);
						translate([0, 0, head_height / 2]) intersection() {
							translate([0, 0, vslot_20mm_holes_side_head_fade[i] / 2]) vslot_20mm_plate_side_fade_hole(d1 = dia, d2 = 0, height = vslot_20mm_holes_side_head_fade[i], bridge = vslot_20mm_holes_side_bridge[i]);
							if (vslot_20mm_holes_side_head_fade_cutoff[i] > 0) {
								translate([0, 0, vslot_20mm_holes_side_head_fade_cutoff[i] / 2]) vslot_20mm_plate_side_hole(dia = dia, height = vslot_20mm_holes_side_head_fade_cutoff[i], bridge = vslot_20mm_holes_side_bridge[i], side_enable = side_enable[i]);
							}
						}
					}
				}
			}
		}
	}
}

// Select what holes to project
module vslot_20mm_holes_cross(cross_enable, head=false)
{
	for (i = [0:1:len(cross_enable) - 2]) {
		if (cross_enable[i]) {
			offset = head ? vslot_20mm_holes_cross_head_offset[i] : 0;
			rotate([0, 0, i * -90]) translate([0, vslot_20mm_holes_dis]) {
				translate([0, 0, offset / 2]) vslot_20mm_plate_hole(height = offset + vslot_mount_wall_thickness);
				if (head) {
					head_height = vslot_20mm_holes_cross_head_height[i];
					is_nut = vslot_20mm_holes_cross_head_nut[i] ? true : false;
					dia = is_nut ? face_distance(vslot_20mm_holes_cross_head_nut_dia[i]) : vslot_20mm_holes_cross_head_dia[i];
					translate([0, 0, offset + vslot_mount_wall_thickness / 2 + head_height / 2]) {
						cylinder(d = dia, h = head_height, center = true, $fn = is_nut ? 6 : $fn);
						translate([0, 0, head_height / 2]) intersection() {
							translate([0, 0, vslot_20mm_holes_cross_head_fade[i] / 2]) cylinder(d1 = dia, d2 = 0, h = vslot_20mm_holes_cross_head_fade[i], center = true);
							if (vslot_20mm_holes_cross_head_fade_cutoff[i] > 0) {
								translate([0, 0, vslot_20mm_holes_cross_head_fade_cutoff[i] / 2]) cylinder(d = dia, h = vslot_20mm_holes_cross_head_fade_cutoff[i], center = true);
							}
						}
					}
				}
			}
		}
	}
	if (cross_enable[4]) {
		offset = head ? vslot_20mm_holes_cross_head_offset[4] : 0;
		translate([0, 0, offset / 2]) vslot_20mm_plate_hole(height = offset + vslot_mount_wall_thickness);
		if (head) {
			head_height = vslot_20mm_holes_cross_head_height[4];
			is_nut = vslot_20mm_holes_cross_head_nut[4] ? true : false;
			dia = is_nut ? face_distance(vslot_20mm_holes_cross_head_nut_dia[4]) : vslot_20mm_holes_cross_head_dia[4];
			translate([0, 0, offset + vslot_mount_wall_thickness / 2 + head_height / 2]) {
				cylinder(d = dia, h = head_height, center = true, $fn = is_nut ? 6 : $fn);
				translate([0, 0, head_height / 2]) intersection() {
					translate([0, 0, vslot_20mm_holes_cross_head_fade[4] / 2]) cylinder(d1 = dia, d2 = 0, h = vslot_20mm_holes_cross_head_fade[4], center = true);
					if (vslot_20mm_holes_cross_head_fade_cutoff[4] > 0) {
						translate([0, 0, vslot_20mm_holes_cross_head_fade_cutoff[4] / 2]) cylinder(d = dia, h = vslot_20mm_holes_cross_head_fade_cutoff[4], center = true);
					}
				}
			}
		}
	}
}

// Select what holes to project, from left to right
module vslot_20mm_holes_top(top_enable, head=false)
{
	translate([-vslot_20mm_holes_dis * 2, vslot_20mm_holes_dis * 2 * (vslot_20mm_holes_top_bot_swap ? -1 : 1)]) for (i = [0:1:len(top_enable) - 1]) {
		if (top_enable[i]) {
			offset = head ? vslot_20mm_holes_top_head_offset[i] : 0;
			translate([vslot_20mm_holes_dis * i, 0]) {
				translate([0, 0, offset / 2]) vslot_20mm_plate_hole(height = offset + vslot_mount_wall_thickness);
				if (head) {
					head_height = vslot_20mm_holes_top_head_height[i];
					is_nut = vslot_20mm_holes_top_head_nut[i] ? true : false;
					dia = is_nut ? face_distance(vslot_20mm_holes_top_head_nut_dia[i]) : vslot_20mm_holes_top_head_dia[i];
					translate([0, 0, offset + vslot_mount_wall_thickness / 2 + head_height / 2]) {
						cylinder(d = dia, h = head_height, center = true, $fn = is_nut ? 6 : $fn);
						translate([0, 0, head_height / 2]) intersection() {
							translate([0, 0, vslot_20mm_holes_top_head_fade[i] / 2]) cylinder(d1 = dia, d2 = 0, h = vslot_20mm_holes_top_head_fade[i], center = true);
							if (vslot_20mm_holes_top_head_fade_cutoff[i] > 0) {
								translate([0, 0, vslot_20mm_holes_top_head_fade_cutoff[i] / 2]) cylinder(d = dia, h = vslot_20mm_holes_top_head_fade_cutoff[i], center = true);
							}
						}
					}
				}
			}
		}
	}
}

// Select what holes to project, from left to right
module vslot_20mm_holes_bottom(bot_enable, head=false)
{
	translate([-vslot_20mm_holes_dis * 2, -vslot_20mm_holes_dis * 2 * (vslot_20mm_holes_top_bot_swap ? -1 : 1)]) for (i = [1,3]) {
		if (bot_enable[i]) {
			offset = head ? vslot_20mm_holes_bot_head_offset[i] : 0;
			translate([vslot_20mm_holes_dis * i, 0]) {
				translate([0, 0, offset / 2]) vslot_20mm_plate_hole(height = offset + vslot_mount_wall_thickness);
				if (head) {
					head_height = vslot_20mm_holes_bot_head_height[i];
					is_nut = vslot_20mm_holes_bot_head_nut[i] ? true : false;
					dia = is_nut ? face_distance(vslot_20mm_holes_bot_head_nut_dia[i]) : vslot_20mm_holes_bot_head_dia[i];
					translate([0, 0, offset + vslot_mount_wall_thickness / 2 + head_height / 2]) {
						cylinder(d = dia, h = head_height, center = true, $fn = is_nut ? 6 : $fn);
						translate([0, 0, head_height / 2]) intersection() {
							translate([0, 0, vslot_20mm_holes_bot_head_fade[i] / 2]) cylinder(d1 = dia, d2 = 0, h = vslot_20mm_holes_bot_head_fade[i], center = true);
							if (vslot_20mm_holes_bot_head_fade_cutoff[i] > 0) {
								translate([0, 0, vslot_20mm_holes_bot_head_fade_cutoff[i] / 2]) cylinder(d = dia, h = vslot_20mm_holes_bot_head_fade_cutoff[i], center = true);
							}
						}
					}
				}
			}
		}
	}
	translate([-vslot_20mm_holes_dis * 2, -vslot_20mm_holes_dis * 2 * (vslot_20mm_holes_top_bot_swap ? -1 : 1)]) for (i = [0:2:4]) {
		if (bot_enable[i]) {
			offset = head ? vslot_20mm_holes_bot_head_offset[i] : 0;
			translate([vslot_20mm_holes_dis * i, 0]) {
				translate([0, 0, offset / 2]) vslot_20mm_plate_nut_hole(height = offset + vslot_mount_wall_thickness);
				if (head) {
					head_height = vslot_20mm_holes_bot_head_height[i];
					is_nut = vslot_20mm_holes_bot_head_nut[i] ? true : false;
					dia = is_nut ? face_distance(vslot_20mm_holes_bot_head_nut_dia[i]) : vslot_20mm_holes_bot_head_dia[i];
					translate([0, 0, offset + vslot_mount_wall_thickness / 2 + head_height / 2]) {
						cylinder(d = dia, h = head_height, center = true, $fn = is_nut ? 6 : $fn);
						translate([0, 0, head_height / 2]) intersection() {
							translate([0, 0, vslot_20mm_holes_bot_head_fade[i] / 2]) cylinder(d1 = dia, d2 = 0, h = vslot_20mm_holes_bot_head_fade[i], center = true);
							if (vslot_20mm_holes_bot_head_fade_cutoff[i] > 0) {
								translate([0, 0, vslot_20mm_holes_bot_head_fade_cutoff[i] / 2]) cylinder(d = dia, h = vslot_20mm_holes_bot_head_fade_cutoff[i], center = true);
							}
						}
					}
				}
			}
		}
	}
}

module vslot_20mm_mount_holes(head=false)
{
	vslot_20mm_holes_top(vslot_20mm_holes_top_enable, head);
	vslot_20mm_holes_cross(vslot_20mm_holes_cross_enable, head);
	vslot_20mm_holes_bottom(vslot_20mm_holes_bot_enable, head);
	vslot_20mm_holes_side(vslot_20mm_holes_side_enable, head);
}

module vslot_20mm_mount_outline()
{
	minkowski() {
		hull() {
			vslot_20mm_holes_top(vslot_20mm_holes_top_enable);
			vslot_20mm_holes_cross(vslot_20mm_holes_cross_enable);
			rotate([0, 0, 180]) vslot_20mm_holes_top(vslot_20mm_holes_top_enable);
			v = vslot_20mm_holes_side_enable;
			vslot_20mm_holes_side([(v[0][0] || v[0][1]) ? [1, 1] : [0, 0], (v[0][0] || v[0][1]) ? [1, 1] : [0, 0]]);
		}
		cube([vslot_20mm_holes_to_edge_offset, vslot_20mm_holes_to_edge_offset, 0.001], center = true);
	}
}

module vslot_mini_plate_hole(height, dia = vslot_mini_holes_dia)
{
	cylinder(d = vslot_mini_holes_dia, h = height, center = true);
}


module vslot_mini_holes(cross_enable, head=false)
{
	for (i = [0:1:len(cross_enable) - 2]) {
		if (cross_enable[i]) {
			offset = head ? vslot_mini_holes_head_offset[i] : 0;
			rotate([0, 0, i * -90]) translate([0, vslot_mini_holes_dis]) {
				translate([0, 0, offset / 2]) vslot_mini_plate_hole(height = offset + vslot_mount_wall_thickness);
				if (head) {
					translate([0, 0, offset + vslot_mount_wall_thickness / 2 + vslot_mini_holes_head_height[i] / 2]) {
						cylinder(d = vslot_mini_holes_head_dia[i], h = vslot_mini_holes_head_height[i], center = true);
						translate([0, 0, vslot_mini_holes_head_height[i] / 2]) intersection() {
							translate([0, 0, vslot_mini_holes_head_fade[i] / 2]) cylinder(d1 = vslot_mini_holes_head_dia[i], d2 = 0, h = vslot_mini_holes_head_fade[i], center = true);
							if (vslot_mini_holes_head_fade_cutoff[i] > 0) {
								translate([0, 0, vslot_mini_holes_head_fade_cutoff[i] / 2]) cylinder(d = vslot_mini_holes_head_dia[i], h = vslot_mini_holes_head_fade_cutoff[i], center = true);
							}
						}
					}
				}
			}
		}
	}
	if (cross_enable[4]) {
		offset = head ? vslot_mini_holes_head_offset[4] : 0;
		translate([0, 0, offset / 2]) vslot_mini_plate_hole(height = offset + vslot_mount_wall_thickness);
		if (head) {
			translate([0, 0, offset + vslot_mount_wall_thickness / 2 + vslot_mini_holes_head_height[4] / 2]) {
				cylinder(d = vslot_mini_holes_head_dia[4], h = vslot_mini_holes_head_height[4], center = true);
				translate([0, 0, vslot_mini_holes_head_height[4] / 2]) intersection() {
					translate([0, 0, vslot_mini_holes_head_fade[4] / 2]) cylinder(d1 = vslot_mini_holes_head_dia[4], d2 = 0, h = vslot_mini_holes_head_fade[4], center = true);
					if (vslot_mini_holes_head_fade_cutoff[4] > 0) {
						translate([0, 0, vslot_mini_holes_head_fade_cutoff[4] / 2]) cylinder(d = vslot_mini_holes_head_dia[4], h = vslot_mini_holes_head_fade_cutoff[4], center = true);
					}
				}
			}
		}
	}
}

module vslot_mini_plate()
{
	difference() {
		vslot_mini_mount_outline();
		vslot_mini_holes(vslot_mini_holes_enable, head=false);
	};
}

module vslot_mini_plate_to_belt_mount()
{
	for (i = [[1, -1], [-1, -1]]) {
		translate([vslot_mini_wheel_screw_offset.x * i.x, vslot_mini_wheel_screw_offset.y * i.y])
				translate([(vslot_mini_belt_plate_mount_offset.x - vslot_mini_belt_plate_mount_depth) * i.x, -vslot_mini_belt_plate_mount_offset.y * i.y, vslot_mini_belt_plate_mount_screw_wall_thickness])
				vslot_mini_belt_plate_mount();
	}
}

module vslot_mini_plate_to_belt_mount_hole()
{
	for (i = [[1, -1], [-1, -1]]) {
		translate([vslot_mini_wheel_screw_offset.x * i.x, vslot_mini_wheel_screw_offset.y * i.y])
				translate([(vslot_mini_belt_plate_mount_offset.x - vslot_mini_belt_plate_mount_depth) * i.x, -vslot_mini_belt_plate_mount_offset.y * i.y, vslot_mini_belt_plate_mount_screw_wall_thickness])
				vslot_mini_belt_plate_mount_hole();
	}
}

module vslot_mini_wheel_screws(nut_offset=false, height = vslot_mini_wheel_screw_height)
{
	for (i = [[1, 1], [-1, 1], [-1, -1], [1, -1]]) {
		translate([-vslot_mini_wheel_screw_offset.x * i.x, vslot_mini_wheel_screw_offset.y * i.y])
				cylinder(d = vslot_mini_wheel_screw_dia + (((i.y < 0 && nut_offset && !vslot_mini_wheel_screw_nuts_swap) || (i.y > 0 && nut_offset && vslot_mini_wheel_screw_nuts_swap)) ? 1.5 : 0), h = height, center = true);
	}
}

module vslot_mini_mount_outline()
{
	hull() {
		vslot_mini_holes(vslot_mini_holes_enable);
		vslot_mini_wheel_screws(height = vslot_mount_wall_thickness);
		cyl_cube(vslot_mini_plate_size, 8);
		vslot_mini_plate_to_belt_mount();
	}
}

module vslot_20mm_wheel_screws()
{
	is_nut = vslot_20mm_wheel_screw_nut;
	for (i = [[1, 1], [-1, 1], [-1, -1], [1, -1]]) {
		translate([-vslot_20mm_holes_dis * 2 * i.x, vslot_20mm_holes_dis * 2 * i.y])
				cylinder(d = (is_nut ? face_distance(vslot_20mm_wheel_screw_nut_dia) : vslot_20mm_wheel_screw_dia) + ((i.y < 0 && !vslot_20mm_wheel_screw_eccentric_swap) || (i.y > 0 && vslot_20mm_wheel_screw_eccentric_swap) ? vslot_20mm_wheel_screw_nut_eccentric_extra_dia : 0), h = vslot_20mm_wheel_screw_height, center = true, $fn = is_nut ? 6 : $fn);
	}
}

module vslot_20mm_edge_screw_cutout()
{
	for (i = [-1, 1]) {
		translate([(vslot_20mm_holes_dis * 2 + vslot_20mm_edge_hole_to_plate_offset.x) * i, vslot_20mm_holes_dis * 2 * (vslot_20mm_wheel_screw_eccentric_swap ? -1 : 1) + vslot_20mm_edge_hole_to_plate_offset.y])
				hull() {
					for (k = [-1, 1]) {
						translate([0, vslot_20mm_edge_hole_offset * k]) cylinder(d = vslot_20mm_edge_hole_dia * 2, h = vslot_20mm_edge_hole_dia, center = true);
					}
				}
	}
}

module vslot_20mm_plate()
{
	difference() {
		vslot_20mm_mount_outline();
		scale([1, 1, 1.01]) vslot_20mm_mount_holes(head=false);
	};
}

module titan_mount_on_vslot_20mm(abl_mount=false, abl_mount_extra=false)
{
	difference() {
		union() {
			hull() {
				vslot_20mm_plate();
				translate(titan_to_20mm_plate_offset) rotate([0, 270, 0]) titan_mount_outline();
			}
			translate(titan_to_20mm_plate_offset) rotate([0, 270, 0]) creality_fan_mount_bridge();
			if (abl_mount) {
				hull() {
					intersection() {
						hull() {
							vslot_20mm_plate();
							translate(titan_to_20mm_plate_offset) rotate([0, 270, 0]) titan_mount_outline();
						}
						translate([0, 100]) cube([200, 200, abl_mount_hull_height], center = true);
					}
					translate(let(offset = abl_mount_extra ? abl_mount_extra_offset : [0, 0]) offset)
							translate([titan_to_20mm_plate_offset.x + titan_mount_wall_thickness / 2, titan_to_20mm_plate_offset.y])
							abl_mount_plate();
				}
				translate(let(offset = abl_mount_extra ? abl_mount_extra_offset : [0, 0]) offset)
						translate([titan_to_20mm_plate_offset.x + titan_mount_wall_thickness / 2, titan_to_20mm_plate_offset.y])
						abl_mount_interface();
			}
		}
		translate(titan_to_20mm_plate_offset) {
			titan_outline();
			titan_hotend_clear_zone();
			rotate([90, 0, 270]) scale([1, 1, 1.01]) titan_mount_holes();
			scale([1.2, 1, 1]) rotate([0, 270])
					translate([titan_mount_wall_thickness / 2, 0])
					translate(creality_fan_mount_offset)
					creality_fan_mount_holes();
			titan_gear();
		}
		translate([0, 0, -0.001]) vslot_20mm_mount_holes(head=true);
		translate([0, 0, -0.001]) translate([0, 0, vslot_20mm_wheel_screw_height / 2 - vslot_mount_wall_thickness / 2])
				vslot_20mm_wheel_screws();
		translate([0, 0, -0.001]) translate([0, 0, vslot_20mm_edge_hole_dia / 2 - vslot_mount_wall_thickness / 2])
				vslot_20mm_edge_screw_cutout();
		translate(let(offset = abl_mount_extra ? abl_mount_extra_offset : [0, 0]) offset)
				translate([-abl_mount_screw_length / 2, 0])
				translate([titan_to_mini_plate_offset.x + titan_mount_wall_thickness / 2, titan_to_mini_plate_offset.y])
				translate(abl_mount_offset)
				abl_mount_hole();
	}
}

module titan_mount_on_vslot_mini(abl_mount=false, abl_mount_extra=false)
{
	difference() {
		union() {
			hull() {
				vslot_mini_plate();
				translate(titan_to_mini_plate_offset) rotate([0, 270, 0]) titan_mount_outline();
			}
			if (abl_mount) {
				hull() {
					intersection() {
						hull() {
							vslot_mini_plate();
							translate(titan_to_20mm_plate_offset) rotate([0, 270, 0]) titan_mount_outline();
						}
						translate([0, 100]) cube([200, 200, abl_mount_hull_height], center = true);
					}
					translate(let(offset = abl_mount_extra ? abl_mount_extra_offset : [0, 0]) offset)
							translate([titan_to_mini_plate_offset.x + titan_mount_wall_thickness / 2, titan_to_mini_plate_offset.y])
							abl_mount_plate();
				}
				translate(let(offset = abl_mount_extra ? abl_mount_extra_offset : [0, 0]) offset)
						translate([titan_to_mini_plate_offset.x + titan_mount_wall_thickness / 2, titan_to_mini_plate_offset.y])
						abl_mount_interface();
			}
			translate(titan_to_mini_plate_offset) rotate([0, 270, 0]) creality_fan_mount_bridge();
		}
		translate(titan_to_mini_plate_offset) {
			titan_outline();
			titan_hotend_clear_zone();
			rotate([90, 0, 270]) scale([1, 1, 1.01]) titan_mount_holes();
			scale([1.2, 1, 1]) rotate([0, 270])
					translate([titan_mount_wall_thickness / 2, 0])
					translate(creality_fan_mount_offset)
					creality_fan_mount_holes();
			titan_gear();
		}
		translate([0, 0, -0.001]) {
			vslot_mini_wheel_screws(nut_offset=true);
			vslot_mini_plate_to_belt_mount_hole();
			vslot_mini_holes(vslot_mini_holes_enable, head=true);
		}
		translate(let(offset = abl_mount_extra ? abl_mount_extra_offset : [0, 0]) offset)
				translate([-abl_mount_screw_length / 2, 0])
				translate([titan_to_mini_plate_offset.x + titan_mount_wall_thickness / 2, titan_to_mini_plate_offset.y])
				translate(abl_mount_offset)
				abl_mount_hole();
	}
}
