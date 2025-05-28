/* bracket_backlash_filamentsensor.scad
 *
 * Bracket with following features enabled
 * To customize the bracket, edit the variables in base.scad
 */

include <base.scad>

generate_motorcutout = true; // Filament sensour mount implies motor cutout
generate_backlash_mount = true;
generate_filamentsensor_mount = true;

mirror([1, 0]) wobblex_z_bracket();
