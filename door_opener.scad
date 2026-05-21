include <jl_scad/box.scad>
include <jl_scad/parts.scad>
include <jl_scad/utils.scad>

PCB_STANDOFF_H=6; // standoff from bottom
PCB_W_MARGIN = 2; // gets added to box dimensions and substracted from display-cutout to prevent cutout at left side for the display
PCB_W = 62+PCB_W_MARGIN; // inclusive 2mm display overhead
PCB_D = 51;
PCB_H = 17+PCB_STANDOFF_H; // z-position of the cutout for the display

DCF_W = 35;
DCF_D = 20;
DCF_SCREW_HOLE_X = 7;  // center
DCF_SCREW_HOLE_R = 2;

DISP_W = 35;
DISP_D = 19;
DISP_Y = 11;
DISP_X = 0;

box_make(print=true)
box_shell_base_lid([PCB_W,PCB_D,PCB_H], wall_sides=1.2, wall_top=2, base_height=PCB_H) {
    // display cut out
    back(-DISP_Y-DISP_D/2) left(PCB_W_MARGIN) box_pos(anchor=BACK+RIGHT,side=TOP) box_cutout(rect([DISP_W,DISP_D],rounding=2),chamfer=0.75,anchor=RIGHT);
    
    // back-left standoff
    box_half(BOT) back(DCF_D/2) right(DCF_SCREW_HOLE_X) box_pos(anchor=LEFT) standoff(h=PCB_STANDOFF_H, id=DCF_SCREW_HOLE_R);
    // back-right standoff
    box_half(BOT) back(-DCF_D/2) right(DCF_SCREW_HOLE_X) box_pos(anchor=LEFT) standoff(h=PCB_STANDOFF_H, id=DCF_SCREW_HOLE_R);
    
    // text
    box_part(TOP, inside=false)
    box_flip(axis=BOTTOM)
        back(PCB_D/2-3) Z(-0.4) box_cut() text3d("DOOR OPENER", h=2, size=3, atype="ycenter", anchor=BOTTOM);
}