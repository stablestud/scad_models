tube_diameter = 24;
separator_height = 4;
separator_diameter = tube_diameter * 4;
separator_twist = 0;
tooth_count = 32;
tooth_outer_diameter = (separator_diameter - tube_diameter) / 2 + tube_diameter;
tooth_inner_diameter = tube_diameter * 0.75;

$fn = 360/tooth_count * 4;

module tooth()
{
	angle=360/tooth_count;
	for (i = [0:angle:360]) {
		rotate([0,0,i]) polygon([[0,tooth_inner_diameter/2*cos(angle/4)],
				[0,tooth_outer_diameter/2],
				[tooth_outer_diameter/2*sin(angle),tooth_outer_diameter/2*cos(angle)]]);
	}
}

module main()
{
	linear_extrude(height=separator_height,center=true,twist=separator_twist) {
		difference() {
			tooth();
			circle(d=tube_diameter);
		}
		difference() {
			circle(d=separator_diameter);
			circle(d=tooth_outer_diameter*0.98);
		}
	}
}

main();
