adapter_diameter=18.25;
syringe_diameter=14;
height=10;
offset_width=3;
offset_height=1; 

$fn=48;

module inner()
{
	cylinder(center=true, h=height, d=syringe_diameter);
}

module offset()
{
	difference() {
		cylinder(center=true, h=offset_height, d=offset_width*2+adapter_diameter);
		inner();
	}
}

module adapter_5cc()
{
	difference() {
		cylinder(center=true, h=height, d=adapter_diameter);
		inner();
	}
}

module main() {
	translate([0,0,height/2+offset_height/2]) adapter_5cc();
	offset();
}

main();
