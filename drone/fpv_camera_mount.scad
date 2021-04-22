module fpv_camera_mount_arc(depth, screwwidth, radius = 6)
{
	res = $preview ? 10 : 50;
	intersection() {
		outrad = screwwidth / 2 + radius;
		inrad = radius - screwwidth / 2;
		difference() {
			cylinder(depth, r = outrad, $fn = res);
			cylinder(depth, r = inrad, $fn = res);
		}
		arcextend = screwwidth / 2;
		cube([outrad + arcextend, outrad + arcextend, depth]);
	}
	translate([radius, 0, 0]) cylinder(depth, r = screwwidth / 2, $fn = res);
	translate([0, radius, 0]) cylinder(depth, r = screwwidth / 2, $fn = res);
}

module fpv_camera_mount_hole(depth, screwwidth = 2)
{
	res = $preview ? 10 : 20;
	cylinder(depth, r = screwwidth * 1.2 / 2, $fn = res);
}

module fpv_camera_mount(depth, screwwidth = 2)
{
	fpv_camera_mount_full_6mm(depth, screwwidth);
	rotate([0, 0, 160]) fpv_camera_mount_half_9mm(depth, screwwidth);
}

module fpv_camera_mount_full(depth, screwwidth = 2)
{
	fpv_camera_mount_full_6mm(depth, screwwidth);
	fpv_camera_mount_full_9mm(depth, screwwidth);
}

module fpv_camera_mount_half_6mm(depth, screwwidth = 2)
{
	fpv_camera_mount_hole(depth, screwwidth);
	fpv_camera_mount_arc(depth, screwwidth, 6);
}

module fpv_camera_mount_full_6mm(depth, screwwidth = 2)
{
	rotate([0, 0, 90]) fpv_camera_mount_half_6mm(depth, screwwidth);
	rotate([0, 0, 270]) fpv_camera_mount_half_6mm(depth, screwwidth);
}

module fpv_camera_mount_half_9mm(depth, screwwidth = 2)
{
	fpv_camera_mount_hole(depth, screwwidth);
	fpv_camera_mount_arc(depth, screwwidth, 9);
}

module fpv_camera_mount_full_9mm(depth, screwwidth = 2, angle_offset = -20)
{
	rotate([0, 0, angle_offset]) fpv_camera_mount_half_9mm(depth, screwwidth);
	rotate([0, 0, 180 + angle_offset]) fpv_camera_mount_half_9mm(depth, screwwidth);
}
