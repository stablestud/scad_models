/* bracket_backlash_motorcutout.scad
 *
 * Bracket with following features enabled
 * To customize the bracket, edit the variables in base.scad
 */

include <base.scad>

generate_backlash_mount = true;
generate_motorcutout = true;

mirror([1, 0]) wobblex_z_bracket();
