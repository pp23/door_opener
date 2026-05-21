include <jl_scad/box.scad>
include <jl_scad/parts.scad>
include <jl_scad/utils.scad>

PCB_STANDOFF_H=6; // standoff from bottom
DISPLAY_MARGIN = 3; // overhead USB-C port right of display
ESP32_W_MARGIN = 10;// gets added to box dimensions as hangover of the display and USB-C port

BOX_W = 62+ESP32_W_MARGIN; // inclusive overhead
BOX_D = 51;
BOX_H = 17+PCB_STANDOFF_H; // z-position of the cutout for the display

DCF_W = 35;
DCF_D = 20;
DCF_SCREW_HOLE_X = 7;  // center
DCF_SCREW_HOLE_R = 2;  // inner radius

DISP_W = 35;
DISP_D = 19;
DISP_Y = 11;
DISP_X = 0;

// USBC port cutout below center of display
USBC_PORT_Z = BOX_H-4;
USBC_PORT_H = 4;
USBC_PORT_W = 11;
USBC_PORT_Y = DISP_Y;

box_make(explode=2)
box_shell_base_lid([BOX_W,BOX_D,BOX_H], wall_sides=1.2, wall_top=2, base_height=BOX_H) {
    // display cut out
    back(-DISP_Y-DISP_D/2) left(DISPLAY_MARGIN) box_pos(anchor=BACK+RIGHT,side=TOP) box_cutout(rect([DISP_W,DISP_D],rounding=2),chamfer=0.75,anchor=RIGHT);
    // USBC-Port cut out
    Z(USBC_PORT_Z) box_pos() back(USBC_PORT_Y-USBC_PORT_W/2) box_part(BOTTOM+RIGHT) box_cutout(rect([USBC_PORT_W,USBC_PORT_H],rounding=1));
    
    // back-left standoff for DCF77 screws
    box_half(BOT) back(DCF_D/2) right(DCF_SCREW_HOLE_X) box_pos(anchor=LEFT) standoff(h=PCB_STANDOFF_H, id=DCF_SCREW_HOLE_R);
    // back-right standoff for DCF77 screws
    box_half(BOT) back(-DCF_D/2) right(DCF_SCREW_HOLE_X) box_pos(anchor=LEFT) standoff(h=PCB_STANDOFF_H, id=DCF_SCREW_HOLE_R);
    // back-right standoff
    box_half(BOT) back(-3) left(3+ESP32_W_MARGIN) box_pos(anchor=BACK+RIGHT) standoff(h=PCB_STANDOFF_H, id=1,od=3);
    // front-right standoff
    box_half(BOT) back(3) left(3+ESP32_W_MARGIN) box_pos(anchor=FRONT+RIGHT) standoff(h=PCB_STANDOFF_H, id=1,od=3);
    
    // text
    box_part(TOP, inside=false)
        back(BOX_D/2-3) Z(-0.4) box_cut() text3d("DOOR OPENER", h=2, size=3, atype="ycenter", anchor=BOTTOM);
}