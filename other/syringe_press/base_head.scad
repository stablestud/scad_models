include <BOSL/threading.scad>

module offset(offset_width, offset_height, tube_diameter)
{
	cylinder(center=true, d1=tube_diameter, d2=tube_diameter+offset_width, h=offset_height);
}

module screw_hole(screw_diameter, tube_height, thread_pitch)
{
	threaded_rod(d=screw_diameter, l=tube_height*2, pitch=thread_pitch, internal=true);
}

module tube(tube_diameter, tube_height)
{
	cylinder(center=true, d=tube_diameter, h=tube_height);
}

module head(screw_diameter, offset_width, offset_height, tube_diameter, tube_height, thread_pitch)
{
	translate([0,0,-offset_height/2]) offset(offset_width, offset_height, tube_diameter);
	translate([0,0,tube_height/2]) difference() {
		tube(tube_diameter, tube_height);
		screw_hole(screw_diameter, tube_height, thread_pitch); 
	}
}

$fn=32;
