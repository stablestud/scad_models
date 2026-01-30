/* References

   https://github.com/Creality3DPrinting/Ender-3/blob/master/Ender-3%20Mechanical/PDF/E%20motor%20bracket.pdf
   https://github.com/Creality3DPrinting/Ender-3/blob/master/Ender-3%20Mechanical/PDF/Z%20Stent.pdf
   https://github.com/Creality3DPrinting/Ender-3/blob/master/Ender-3%20Mechanical/PDF/X%20motor%20bracket.pdf

*/

plate_thickness = 3;
mount_thickness = plate_thickness * 1.3;

main_wheel_pos      = [ 11.9, 43.53 ];
main_wheel_diameter = 7.2;

counter_wheel_top_pos    = [ 72.1,  8.03 ];
counter_wheel_bottom_pos = [ 72.1, 79.03 ];
counter_wheels_diameter  = 5.1;

lead_screw_pos           = [ 50.8 - 9, 20, 17.15 - 2.5 / 2 + plate_thickness / 2];
lead_screw_hole_diameter = 12;
lead_screw_mount_holes_distance = 18;
lead_screw_mount_holes_diameter = 3;

wobblex_motor_hole_pos      = [ lead_screw_pos.x - 15, lead_screw_pos.y, lead_screw_pos.z + 2 ];
wobblex_motor_hole_diameter = 3;

wobblex_clearance_height = 25;
wobblex_clearance_width  = 33;
wobblex_clearance_mount_offset = 4;
wobblex_clearance_offset = [ 0, mount_thickness / 2 + wobblex_clearance_mount_offset + wobblex_clearance_height / 2 ];

motor_cutout_size    = [ 45, 45 ];
motor_cutout_pos     = [ counter_wheel_top_pos.x - 8, main_wheel_pos.y - 1 ];
motor_cutout_chamfer = 5;

weight_mount_hole_offset   = 15.5;
weight_mount_base_pos      = [ counter_wheel_top_pos.x, main_wheel_pos.y + 2 ];
weight_mount_offsets       = [[ 0, -weight_mount_hole_offset ], [ 0, weight_mount_hole_offset ]];
weight_mount_hole_diameter = 3;
weight_mount_clearance_offset = [ weight_mount_hole_offset, 0, plate_thickness ];
weight_mount_clearance_size   = 43.5;
weight_mount_cutout          = true;
weight_mount_cutout_diameter = 24;
weight_mount_cutout_offset   = [ weight_mount_hole_offset, 0 ];

filament_sensor_hole_diameter = 3;
filament_sensor_base_pos      = [ lead_screw_pos.x - 39, lead_screw_pos.y, 16.75 ];
filament_sensor_hole_offsets  = [[ 6.2, 0 ], [ -6.2, 0 ]];

wobblex_stack_height = 22;

wobblex_backlash_spring_slope          = true;
wobblex_backlash_spring_inner_diameter = lead_screw_hole_diameter;
wobblex_backlash_spring_outer_diameter = wobblex_backlash_spring_inner_diameter + 3;
wobblex_backlash_base_pos              = get_wobblex_backlash_base_pos(offset = 20);
wobblex_backlash_support_offsets = [
		[  wobblex_clearance_width / 2 + plate_thickness, (lead_screw_pos.y + wobblex_clearance_offset.y) - wobblex_backlash_base_pos.y + plate_thickness],
		[ -wobblex_clearance_width / 2 - plate_thickness, (lead_screw_pos.y + wobblex_clearance_offset.y) - wobblex_backlash_base_pos.y + plate_thickness ],
		[  wobblex_backlash_spring_outer_diameter, wobblex_backlash_base_pos.z / 2 + plate_thickness ],
		[ -wobblex_backlash_spring_outer_diameter, wobblex_backlash_base_pos.z / 2 + plate_thickness]];

mount_bracket_support_offset = lead_screw_hole_diameter / 2 + plate_thickness;
wheel_plate_support_offset   = lead_screw_hole_diameter + plate_thickness / 2;

generate_motorcutout          = false;
generate_weight_mount         = false;
generate_backlash_mount       = false;
generate_filamentsensor_mount = false;

features = [
		[ "motorcutout",          generate_motorcutout ],
		[ "filamentsensor_mount", generate_filamentsensor_mount ],
		[ "weight_mount",         generate_weight_mount ],
		[ "backlash_mount",       generate_backlash_mount ]];

function is_feature(feature) = let(val = features[search([feature], features)[0]][1]) !is_undef(val) && val;

function get_wobblex_backlash_base_pos(offset) = [ lead_screw_pos.x, lead_screw_pos.y + mount_thickness + wobblex_stack_height + offset, lead_screw_pos.z ];

function get_main_wheel_diameter() = (is_feature("filamentsensor_mount") || is_feature("motorcutout")) ? main_wheel_diameter : counter_wheels_diameter;

$fn = 32;

module stub_cylinder(height = plate_thickness)
{
	cylinder(center = true, d = plate_thickness, h = height);
}

module wheel_plate_factory(cwd, mwd)
{
	assert(cwd)
	assert(mwd)
	for(i = [counter_wheel_top_pos, counter_wheel_bottom_pos]) translate(i) cylinder(center = true, d = cwd, h = plate_thickness);
	translate(main_wheel_pos) cylinder(center = true, d = mwd, h = plate_thickness);
}

module wheel_plate_holes()
{
	wheel_plate_factory(counter_wheels_diameter, get_main_wheel_diameter());
}

module wheel_plate_outline()
{
	hull() {
		wheel_plate_factory(counter_wheels_diameter * 4, main_wheel_diameter * 2.5);
		mount_bracket_bridge([0, 0], offset = mount_thickness / 2, height = plate_thickness, diameter = mount_thickness);
		wheel_plate_support_points();
		if(is_feature("backlash_mount")) translate(wobblex_backlash_base_pos) wobblex_backlash_support_points();
	}
}

module lead_screw_mount_holes(lsd, md, height = mount_thickness)
{
	assert(lsd);
	assert(md);
	cylinder(center = true, d = lsd, h = height);
	rotate([0, 0, 90]) for(i = [-lead_screw_mount_holes_distance / 2, lead_screw_mount_holes_distance / 2]) {
		translate([i, 0]) cylinder(center = true, d = md, h = height);
	}
}

module wobblex_motor_hole(md, height = mount_thickness)
{
	assert(md)
	cylinder(center = true, d = md, h = height);
}

module filament_sensor_mount_holes(fsd, height = mount_thickness)
{
	assert(fsd)
	for(i = filament_sensor_hole_offsets) {
		translate(i) cylinder(center = true, d = fsd, h = height);
	}
}

module mount_bracket_factory(lsd, lsmd, wmd, fsd, height = mount_thickness)
{
	assert(lsd);
	assert(lsmd);
	assert(wmd);
	assert(fsd);
	translate(lead_screw_pos) rotate([90, 0]) lead_screw_mount_holes(lsd, lsmd, height);
	translate(wobblex_motor_hole_pos) rotate([90, 0]) wobblex_motor_hole(wmd, height);
	if(is_feature("filamentsensor_mount")) translate(filament_sensor_base_pos) rotate([90, 0]) filament_sensor_mount_holes(fsd, height);
}

module mount_bracket_holes(height = mount_thickness)
{
	mount_bracket_factory(lead_screw_hole_diameter, lead_screw_mount_holes_diameter, wobblex_motor_hole_diameter, filament_sensor_hole_diameter, height);
}

module mount_bracket_bridge(rotation = [90, 0], offset = 0, diameter = plate_thickness, height = mount_thickness)
{
	for(i = [counter_wheel_top_pos.x + counter_wheels_diameter * 2 + offset, is_feature("filamentsensor_mount") ? min(main_wheel_pos.x - offset, filament_sensor_base_pos.x + filament_sensor_hole_offsets[1].x - filament_sensor_hole_diameter * 2 - offset / 2) : main_wheel_pos.x - offset]) {
		translate([i, lead_screw_pos.y]) rotate(rotation) cylinder(center = true, d = diameter, h = height);
	}
}

module mount_bracket_base_bridge()
{
	translate(lead_screw_pos) translate([0, 0, -lead_screw_pos.z]) {
		for(i = [-1, 1]) {
			translate([(mount_bracket_support_offset - plate_thickness) * i, 0]) rotate([90, 0]) stub_cylinder(mount_thickness);
		}
	}
}

module mount_bracket_base_outline()
{
	hull() {
		mount_bracket_factory(lead_screw_hole_diameter * 2, lead_screw_mount_holes_diameter * 4, wobblex_motor_hole_diameter * 3, filament_sensor_hole_diameter * 3);
		mount_bracket_support_points();
		mount_bracket_base_bridge();
	}
}

module mount_bracket_outline()
{
	hull() {
		mount_bracket_base_outline();
		mount_bracket_bridge([90, 0]);
		translate([lead_screw_pos.x + lead_screw_hole_diameter * 1.2, lead_screw_pos.y, lead_screw_pos.z + lead_screw_hole_diameter / 2]) rotate([90, 0]) stub_cylinder(mount_thickness);
	}
}

module wobblex_clearance(scaling = [1, 1, 1])
{
	height = plate_thickness * 10;
	translate([0, 0, -lead_screw_pos.z + height / 2 - mount_thickness / 2]) translate(wobblex_clearance_offset) translate(lead_screw_pos) scale(scaling) resize([wobblex_clearance_width, 0]) cylinder(center = true, d = wobblex_clearance_height, h = height);
}

module mount_bracket_support_point(offset)
{
	assert(offset);
	translate([lead_screw_pos.x + offset, lead_screw_pos.y, lead_screw_pos.z + lead_screw_hole_diameter / 2]) rotate([90, 0]) cylinder(center = true, d = mount_thickness , h = mount_thickness);
}

module mount_bracket_support_points()
{
	for(i = [mount_bracket_support_offset, -mount_bracket_support_offset]) {
		mount_bracket_support_point(i);
	}
}

module wheel_plate_support_point(offset)
{
	assert(offset);
	translate([lead_screw_pos.x + offset, min(lead_screw_pos.y, counter_wheel_top_pos.y - counter_wheels_diameter / 2)]) cylinder(center = true, d = mount_thickness, h = plate_thickness);
}

module wheel_plate_support_points()
{
	for(i = [wheel_plate_support_offset, -wheel_plate_support_offset]) {
		wheel_plate_support_point(i);
	}
}

module hull_support_point(direction)
{
	assert(direction);
	assert(direction != 0);
	translate([lead_screw_pos.x, lead_screw_pos.y]) {
		translate([(wheel_plate_support_offset + mount_thickness / 2) * direction, 0]) cylinder(center = true, d = mount_thickness, h = plate_thickness);
		translate([(mount_bracket_support_offset - mount_thickness) * direction, 0]) cylinder(center = true, d = mount_thickness, h = plate_thickness);
	}
}

module mount_support_main_wheel()
{
	difference() {
		hull() {
			translate([wobblex_motor_hole_pos.x - wobblex_motor_hole_pos.x / main_wheel_pos.x + mount_thickness, lead_screw_pos.y]) rotate([90, 0]) stub_cylinder(mount_thickness);
			translate([main_wheel_pos.x + mount_thickness / 2, lead_screw_pos.y]) rotate([90, 0]) stub_cylinder(mount_thickness);
			translate([wobblex_motor_hole_pos.x - wobblex_motor_hole_pos.x / main_wheel_pos.x - plate_thickness, lead_screw_pos.y, wobblex_motor_hole_pos.z / 4 * 3]) rotate([90, 0]) stub_cylinder(mount_thickness);
			wheel_hole_support_point(main_wheel_pos, main_wheel_diameter / 4, [180, 0]);
		}
		translate([0, 0, plate_thickness / 2]) wheel_hole_support_point(main_wheel_pos, main_wheel_diameter * 1.5, height = is_feature("backlash_mount") ? plate_thickness * 1.5 * 5 : plate_thickness * 5);
	}
}

module mount_support_non_wheel()
{
	hull() {
		translate([lead_screw_pos.x + lead_screw_hole_diameter * 1.2, lead_screw_pos.y]) rotate([90, 0]) stub_cylinder(mount_thickness);
		translate([counter_wheel_top_pos.x, lead_screw_pos.y]) rotate([90, 0]) stub_cylinder(mount_thickness);
		translate([lead_screw_pos.x + lead_screw_hole_diameter * 1.2, lead_screw_pos.y, lead_screw_pos.z + lead_screw_hole_diameter / 2]) rotate([90, 0]) stub_cylinder(mount_thickness);
		translate(wobblex_backlash_base_pos + wobblex_backlash_support_offsets[0] + [-0.5, 3]) rotate([90, 0]) stub_cylinder(plate_thickness);
	}
}

module mount_support_mount()
{
	for(i = [[wheel_plate_support_offset, mount_bracket_support_offset], [-wheel_plate_support_offset, -mount_bracket_support_offset]]) { 
		hull() {
			wheel_plate_support_point(i[0]);
			mount_bracket_support_point(i[1]);
			hull_support_point(i[0] > 0 ? 1 : -1);
		}
	}
}

module mount_support()
{
	mount_support_mount();
	mount_support_main_wheel();
	mount_support_non_wheel();
}

module wheel_hole_support_point(pos, diameter, rotation = [0, 0], height = plate_thickness)
{
	assert(pos);
	assert(diameter);
	translate([0, 0, height > plate_thickness ? (height - plate_thickness) / 2 : 0]) translate(pos) rotate(rotation) cylinder(center = true, d1 = diameter, d2 = diameter * 2.5, h = height);
}

module plate_support()
{
	thickness  = is_feature("backlash_mount") ? plate_thickness * 1.5 : plate_thickness;
	cwdiameter = is_feature("backlash_mount") ? counter_wheels_diameter * 1.5 : counter_wheels_diameter;
	mwdiameter = is_feature("backlash_mount") ? main_wheel_diameter * 1.5 : main_wheel_diameter;
	translate([0, 0, plate_thickness / 2]) difference() {
		intersection() {
			resize([0, 0, wobblex_motor_hole_pos.z]) wheel_plate_outline();
			union() {
				if(!is_feature("motorcutout")) hull() {
					wheel_hole_support_point(counter_wheel_top_pos, diameter = cwdiameter, rotation = [180, 0], height = thickness);
					wheel_hole_support_point(counter_wheel_bottom_pos, diameter = cwdiameter, rotation = [180, 0], height = thickness);
				}
				hull() {
					wheel_hole_support_point(counter_wheel_bottom_pos, diameter = cwdiameter, rotation = [180, 0], height = thickness);
					wheel_hole_support_point(main_wheel_pos, diameter = mwdiameter, rotation = [180, 0], height = thickness);
				}
			}
		}
		wheel_hole_support_point(counter_wheel_top_pos, diameter = cwdiameter, height = thickness);
		wheel_hole_support_point(counter_wheel_bottom_pos, diameter = cwdiameter, height = thickness);
		wheel_hole_support_point(main_wheel_pos, diameter = mwdiameter, height = thickness * 5);
	}
}

module weight_mount_cutout()
{
	translate(weight_mount_base_pos) translate(weight_mount_cutout_offset) cylinder(center = true, d = weight_mount_cutout_diameter, h = plate_thickness * 5);
}

module weight_mount_holes()
{
	translate(weight_mount_base_pos) {
		for(i = weight_mount_offsets) {
			translate(i) cylinder(center = true, d = weight_mount_hole_diameter, h = plate_thickness * 5);
		}
	}
}

module weight_mount_clearance()
{
	translate(weight_mount_base_pos) translate([weight_mount_clearance_offset.x, weight_mount_clearance_offset.y, is_feature("backlash_mount") ? weight_mount_clearance_offset.z * 1.5 : weight_mount_clearance_offset.z]) translate([0, 0, weight_mount_clearance_size / 2]) cube(weight_mount_clearance_size, center = true); 
}

module motor_cutout()
{
	offset = [ 14, 12 ];
	translate(motor_cutout_pos) { 
		translate([motor_cutout_size.x / 2, 0]) minkowski() {
			union() {
				cube([motor_cutout_size.x - motor_cutout_chamfer, motor_cutout_size.y - motor_cutout_chamfer, plate_thickness * 20], center = true);
				translate(offset) cube([motor_cutout_size.x - motor_cutout_chamfer, motor_cutout_size.y - motor_cutout_chamfer, plate_thickness * 20], center = true);
			}
			cylinder(center = true, d = motor_cutout_chamfer, h = plate_thickness);
		}
	}
}

module cutouts()
{
	wobblex_clearance();
	if(is_feature("motorcutout")) motor_cutout();
	if(is_feature("weight_mount")) weight_mount_clearance();
}

module wobblex_backlash_spring_insert(height = mount_thickness)
{
	rotate([90, 0]) difference() {
		cylinder(center = true, d = wobblex_backlash_spring_outer_diameter + mount_thickness, h = height);
		translate([0, 0, mount_thickness / 4]) {
			difference() {
				cylinder(center = true, d = wobblex_backlash_spring_outer_diameter, h = height / 2);
				if(wobblex_backlash_spring_slope) cylinder(center = true, d1 = wobblex_backlash_spring_outer_diameter - (wobblex_backlash_spring_outer_diameter - wobblex_backlash_spring_inner_diameter) / 2, d2 = wobblex_backlash_spring_inner_diameter,  h = height / 2);
			}
		}
		cylinder(center = true, d = wobblex_backlash_spring_inner_diameter, h = height * 5);
	}
}

module wobblex_backlash_support_points()
{
	translate([0, 0, -wobblex_backlash_base_pos.z]) for(i = wobblex_backlash_support_offsets) { 
		translate(i) cylinder(center = true, h = plate_thickness, d = mount_thickness);
	}
}

module wobblex_backlash_support_insert(neg = 1)
{
	assert(neg != 0);
	translate([neg * (wobblex_backlash_spring_outer_diameter / 2 + mount_thickness / 2), 0, wobblex_backlash_spring_outer_diameter / 3]) rotate([90, 0]) cylinder(center = true, d = mount_thickness, h = mount_thickness);
}

module wobblex_backlash_outline()
{
	hull() {
		wobblex_backlash_spring_insert();
		for(i = [-1, 1]) {
			translate([i * (wobblex_backlash_spring_outer_diameter / 2 + mount_thickness / 2), 0, wobblex_backlash_spring_outer_diameter / 3]) rotate([90, 0]) cylinder(center = true, d = mount_thickness, h = mount_thickness);
			translate([i * (wobblex_backlash_spring_outer_diameter / 2), 0]) {
				translate([0, 0, -wobblex_backlash_base_pos.z]) rotate([90, 0]) cylinder(center = true, d = plate_thickness, h = mount_thickness);
			}
			translate([i * (wobblex_backlash_spring_outer_diameter / 4), 0, wobblex_backlash_spring_outer_diameter / 2 + mount_thickness / 2]) rotate([90, 0]) cylinder(center = true, d = mount_thickness, h = mount_thickness);
		}
	}
}

module wobblex_backlash_support()
{
	zbase = [0, 0, -wobblex_backlash_base_pos.z];
	platehullpts = [[-wobblex_backlash_spring_outer_diameter + mount_thickness / 2, 0],
			[-wobblex_backlash_spring_outer_diameter / 2, 0],
			[wobblex_backlash_spring_outer_diameter / 2, 0],
			[wobblex_backlash_spring_outer_diameter - mount_thickness / 2, 0]];
	for(i = wobblex_backlash_support_offsets) {
		hull() {
			for(y = platehullpts) {
				if(i.x * y.x >= 0) {
					translate(zbase) translate(y) cylinder(center = true, d = mount_thickness, h = plate_thickness);
				}
			}
			translate(zbase) translate(i) cylinder(center = true, d = mount_thickness, h = plate_thickness);
			if(i.x < 0) {
				wobblex_backlash_support_insert(-1);
			} else {
				wobblex_backlash_support_insert(1);
			}
		}
	}
}

module wobblex_backlash_clearance(diameter)
{
	assert(diameter);
	height = diameter * 3;
	translate([0, height / 2, 0])  rotate([90, 0]) cylinder(center = true, d = diameter, h = height);
}

module wobblex_backlash()
{
	translate(wobblex_backlash_base_pos) {
		wobblex_backlash_spring_insert();
		difference() {
			wobblex_backlash_support();
			hull() wobblex_backlash_spring_insert();
			rotate([0, 0, 180]) wobblex_backlash_clearance(wobblex_backlash_spring_outer_diameter);
			wobblex_backlash_clearance(wobblex_backlash_spring_inner_diameter);
		}
		difference() {
			wobblex_backlash_outline();
			hull() wobblex_backlash_spring_insert();
		}
	}
}

module support()
{
	difference() {
		union() {
			plate_support();
			mount_support();
			hull() intersection() {
				translate([main_wheel_diameter / 2, -main_wheel_diameter * 0]) translate(main_wheel_pos) {
					cylinder(center = true, d1 = (wobblex_motor_hole_pos.x - main_wheel_pos.x) * 3, d2 = main_wheel_diameter * 2, h = plate_thickness * 10);
				}
				union() {
					plate_support();
					mount_support();
				}
			}
		}
		translate([0, 0, plate_thickness * 1.75]) scale([1, 1, 4]) wheel_hole_support_point(main_wheel_pos, main_wheel_diameter * 1.25);
		mount_bracket_holes(mount_thickness * 10);
		if (is_feature("weight_mount") && weight_mount_cutout) {
			weight_mount_clearance();
			weight_mount_cutout();
		}
	}
}

module wobblex_z_bracket()
{
	assert(lead_screw_hole_diameter < lead_screw_mount_holes_distance - lead_screw_mount_holes_diameter, "Mount holes distance must be greater than lead screw hole diameter");
	assert(!(is_feature("motorcutout") && is_feature("weight_mount")), "Motor cutout and weight mount are not compatible");

	difference() {
		union() {
			wheel_plate_outline();
			difference() {
				mount_bracket_outline();
				mount_bracket_holes();
			}
			support();
			if(is_feature("backlash_mount")) wobblex_backlash();
		}
		cutouts();
		wheel_plate_holes();
		if(is_feature("weight_mount")) {
			weight_mount_clearance();
			weight_mount_holes();
		}
	}
}

module backlash_test()
{
	base_thickness = plate_thickness * 2;
	difference() {
		translate([0, 0, -base_thickness / 4]) resize([0, 0, base_thickness]) hull() intersection() {
			translate([lead_screw_pos.x, lead_screw_pos.y]) cube(center = true, [180, 180, plate_thickness]);
			union() {
				mount_support_mount();
				mount_bracket_base_outline();
				wobblex_backlash();
				wobblex_clearance(scaling = [1.25, 1.25]);
			}
		}
		translate([0, 0, -lead_screw_pos.z - plate_thickness]) translate(wobblex_clearance_offset) translate(lead_screw_pos) rotate([0, 0, 180]) {
			linear_extrude(plate_thickness / 2) text(text = str(wobblex_backlash_base_pos.y - get_wobblex_backlash_base_pos(0).y,"mm"), font = "Liberation Mono", halign = "center", valign = "center", size = 8);
		}
		wobblex_clearance();
	}
	mount_support_mount();
	difference() {
		mount_bracket_base_outline();
		mount_bracket_holes();
	}
	difference() {
		wobblex_backlash();
		wobblex_clearance();
	}
}
