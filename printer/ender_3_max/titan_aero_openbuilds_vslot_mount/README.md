# Openbuilds V-Slot Plate Mounts for E3D Titan (Aero) Extruder

These models make it possible to mount the E3D Titan (Aero) Extruder onto Openbuilds V-Slot gantry plates.
The gantry plates also needs belt mounts. Currently the belt mount models are only optimized for the Creality Ender 3 series (might work for other systems).

Following gantry plates are supported:
* [OpenBuilds V-Slot 20mm](https://github.com/eric-wieser/2.12-robot/blob/master/hardware/Third-party/Openbuilds/PDF%20Drawings/V-Slot%20Gantry%20Plate%2020mm.PDF)
* [OpenBuilds V-Slot Mini](https://github.com/eric-wieser/2.12-robot/blob/master/hardware/Third-party/Openbuilds/PDF%20Drawings/Mini%20V%20Wheel%20Plate.PDF)

I had issues with the original Ender 3 extruder gantry as it was too loose.
So I switched to these gantries as they have 4 wheels and are therefore more stiff.

## Models

Depending on the gantry plate you have different models available:
* V-Slot 20mm:
  * `titan_mount_vslot_20mm.stl`
  * `belt_mount_vslot_20mm_top.stl`
  * `belt_mount_vslot_20mm_bottom.stl`
* V-Slot Mini:
  * `titan_mount_vslot_mini.stl`

The `titan_mount_*` models are the actual Titan (Aero) mount and the `belt_mount_*` are the mounts required to be able to hook the gantries to the 3D printers belt system.

## BOM

Extra materials are needed, dependent on the gantry plate you use:

* V-Slot 20mm:
  * Screws
  * 4x M3x8  screws
  * 2x M2x20 screws
* V-Slot Mini:
  * 3x M6x10 screws
  * 4x M3x8  screws
  * 2x M2x20 screws

## Assembly

TODO

## Part Cooling Fan

I do not provide a part cooling fan as pretty good ones already exist.

The mounts are compatible with existing part-cooling fans:
* https://www.thingiverse.com/thing:3078853 (for Titan Aero)
* https://www.thingiverse.com/thing:3364313 (for Titan Aero)
