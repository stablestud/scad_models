sensor_diameter = 40;
sensor_depth = 14.5;
gasket_diameter = 42;
gasket_width = 1;
gasket_wing_len = 4;
gasket_wing_height = 2;

anti_warp = .15;
filament_thickness = 1.75;

$fa = $preview ? 15 : 5;
$fs = $preview ? 5 : 0.5;

function anti_warp_widen(v) = v + ((filament_thickness * anti_warp) * 2);
function anti_warp_shrink(v) = v - ((filament_thickness * anti_warp) * 2);

difference() {
	union() {
		cylinder(h = sensor_depth, d = anti_warp_shrink(gasket_diameter));
		cylinder(h = gasket_wing_height, d = anti_warp_widen(gasket_diameter + gasket_wing_len));
		translate([0, 0, gasket_wing_height + gasket_width]) cylinder(h = gasket_wing_height, d = anti_warp_widen(gasket_diameter + gasket_wing_len));
		translate([0, 0, sensor_depth]) {
			difference() {
				cylinder(h = gasket_wing_height, d = anti_warp_shrink(gasket_diameter));
				cylinder(h = gasket_wing_height, d = anti_warp_widen(sensor_diameter * .70));
			}
		}
	}
	cylinder(h = sensor_depth, d = anti_warp_widen(sensor_diameter));
}
