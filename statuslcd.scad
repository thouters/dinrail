include <contoursaddle.scad>;
use <rpipcb.scad>;

PARTNO_ALL = 0;
PARTNO_CHASSIS = 1;
PARTNO_FRONT = 2;
PARTNO_TOP = 3;
PARTNO_BUTTON = 4;
PARTNO_BUTTON_HOLDER = 5;

/* change the defaultpartno to view parts during development */
defaultpartno=PARTNO_BUTTON_HOLDER;
/* overridden to generate individual parts with -D in the Makefile */
PARTNO = defaultpartno;

$fn=100;
fdm = 0;
tft_z=40;
tftoff_x = 74;
tftoff_y= 22;
tftoff_z=2;
tft_margin_connector=5.5;
plate_thickness=1.2;

tft_x = 1.6;
tft_y=67.5;
finger_y=5;
finger_x=3;
finger_z=6;
pirplate_y=95;
pirplate_x=2;
piroff_y=90;
frontplate_z=tft_z+1*tftoff_z+2*plate_thickness;
pirplate_hole_dia=10;
frontplate_y = 90;
front_x = 2;

dinrail_z = 25;
railcontact_z = frontplate_z;
clip_padding_z = (railcontact_z - dinrail_z)/2;

x_support_z = 8;

ridge_z = 2;
fan_x = 13;
fan_y = 25;
button_pos = [0,2,20];
button_hole_dia = 18;
button_pcb_dim =[22,20];
button_pcb_inner_offset = 1;
module topplate()
{
    difference()
    {
        /* plate */
        cube([
            1+tftoff_x+tft_x,
            frontplate_y,
            plate_thickness]);
        /* hole for fan */
        translate([fan_x, fan_y,-10])
            cube([50,50,50]);
    }
    // ridge
    translate([0,0,-ridge_z])
    cube([
        2,
        frontplate_y,
        ridge_z]);

    /* fan holder */
    translate([fan_x,fan_y,plate_thickness])
    {
        fan_xy = 50;
        fan_z = 11.5;
        mirror([0,0,1])
        contoursaddle(fan_xy,fan_xy, plate_thickness + fan_z, plate_thickness, 2, 2);
    }

    /* mounting holes for tft */
    for(leg_y =[0,tft_y-x_support_z])
    {
        translate([0,tftoff_y+leg_y,0])
        {
//            cube([tftoff_x+finger_x,x_support_z,2]);

            translate([tftoff_x,leg_y>0?3:0,-finger_z])
            {
//                translate([-(finger_x*1+tft_x),0,-tftoff_z])
//%                        cube([finger_x*2+tft_x,finger_y,tftoff_z]);
                difference()
                {
                    union()
                    {
                        cube([finger_x,finger_y,finger_z]);
                        translate([-tft_x-finger_x,0,0])
                            cube([finger_x,finger_y,finger_z]);
                    }
//                    translate([finger_x/2,finger_y/2,finger_z/2])
//                        rotate([0,90,0]) cylinder(10 ,d=3,center=true);
                }
            }
        }
    }

}

if (PARTNO == PARTNO_TOP||PARTNO==PARTNO_ALL)
{
    color("orange")
    translate([2,0,railcontact_z- 2])
    topplate();
}

if(PARTNO==PARTNO_CHASSIS||PARTNO==PARTNO_ALL)
{
    difference()
    {
        difference()
        {
            translate([160,-123,0])
            {
                union()
                {
                linear_extrude(clip_padding_z)
                projection(cut=true)
                import("DIN_DEFAULT.stl");
                translate([-160,160+40,0])
                {
                    cube([5,13,railcontact_z]);
                }
                }

                translate([0,0,clip_padding_z])
                {
                    import("DIN_DEFAULT.stl");
                    translate([0,0,dinrail_z])
                        linear_extrude(clip_padding_z)
                        projection(cut=true)
                        import("DIN_DEFAULT.stl");
                }
            }
        }
        // top plate
        translate([2,0,railcontact_z - 2*plate_thickness ])
        {
            cube([1+tftoff_x+tft_x,frontplate_y,plate_thickness+0.2]);
            translate([0,0,-ridge_z])
            cube([
                2,
                frontplate_y,
                ridge_z]);
        }
        // back clip
        translate([-7,0,railcontact_z - plate_thickness ])
        {
            cube([13,frontplate_y,plate_thickness+0.2]);

        translate([0,0,- (plate_thickness+0.2) ])
            cube([7,frontplate_y,plate_thickness+0.2]);
        }


        translate([-7,0,0])
            cube([13,frontplate_y,plate_thickness+0.2]);

        translate([-7,0,0])
            cube([7,frontplate_y,plate_thickness+0.2]);
    }

    // clip/lock holder
    translate([-1,-6,clip_padding_z])
        cube([3,6,4.4]);

    translate([0,20,0])
        cube([10,tft_y,2]);

    translate([tftoff_x-10,0,0])
        cube([14.6,1+tft_y+tftoff_y,2]);

    translate([8,89,0])
    rotate([0,0,-90])
            rpicradle();

    cube([10,87,2]);

    for(leg_y =[0,tft_y-x_support_z])
    {
        translate([0,tftoff_y+leg_y,0])
        {
            cube([tftoff_x+tft_x+finger_x,x_support_z,2]);

            translate([tftoff_x+tft_x,leg_y>0?3:0,tftoff_z])
            {
                translate([-(finger_x*1+tft_x),0,-tftoff_z])
                        cube([finger_x*2+tft_x,finger_y,tftoff_z]);
                difference()
                {
                    union()
                    {
                        cube([finger_x,finger_y,finger_z]);
                        translate([-tft_x-finger_x,0,0])
                            cube([finger_x,finger_y,finger_z]);
                    }
//                    translate([finger_x/2,finger_y/2,finger_z/2])
//                        rotate([0,90,0]) cylinder(10 ,d=3,center=true);
                }
            }
        }
    }
}

if (PARTNO==PARTNO_ALL)
{
/* display dummy */
    translate([0,0,tftoff_z])
    translate([tftoff_x,tftoff_y,0])
    {
        color("red")
            cube([tft_x, tft_y, tft_z]);
        // 8mm van kant
        // 23 breed
        // 2.5, tegen kant
        color("black")
            translate([-4,0,8])
            cube([4,10,23]);
        //5.5 van con, 7 van andere kant
        color("white")
            translate([tft_x,tft_margin_connector,0])
            cube([2,tft_y-(7+5.5),tft_z]);
    }
}


if(PARTNO==PARTNO_FRONT||PARTNO==PARTNO_ALL)
{
    translate([tftoff_x+tft_x,0,0])
    {
        frontplate_margin=plate_thickness;
        frontplate_margin_x = 5;
        translate([ 
            -tft_x-pirplate_x+5,
            -frontplate_margin,
            -frontplate_margin
        ])
        {
            color("green")
            difference()
            {
                cube([front_x,
                    frontplate_y+2*frontplate_margin,
                    frontplate_z+2*frontplate_margin]);

                translate([0,frontplate_margin,frontplate_margin])
                {

                    // gap for tft
                    tftborder_z = 2;
                    translate([tft_x-5,tftoff_y+tft_margin_connector+7,tftoff_z+tftborder_z])
                        cube([10,tft_y-1*(7+5.5)-7,tft_z-2*tftborder_z]);

if(0)
{
                    for(i =[0,1,2])
                    {
                            button_dia=13;
                                translate([pirplate_x/2,12,2+button_dia/2+i*5*2.54])
                                    rotate([0,90,0]) cylinder(10 ,d=button_dia,center=true);
                    }
}
                
                }
                translate(button_pos)
                {
                    //translate([0,2.5+10,1.5+10])
                    translate([0,
                            0+button_pcb_dim[1]/2, 
                            0+button_pcb_dim[0]/2]
                    )
                    rotate([0,90,0]) 
                        cylinder(10 ,d=button_hole_dia,center=true);
                }

            }

            
            for(y =[0,frontplate_y+frontplate_margin])
            {
                color("black")
                translate([-frontplate_margin_x,y,0])
                cube([frontplate_margin_x,plate_thickness,frontplate_z+2*frontplate_margin]);
            }
            for(z =[0,frontplate_z+frontplate_margin])
            {
                color("black")
                translate([-frontplate_margin_x,0,z])
                cube([frontplate_margin_x,frontplate_y+2*frontplate_margin,plate_thickness]);
            }

            translate(button_pos)
            {
                translate([plate_thickness,0,0]) // flush with front
                rotate([0,270,0])
                contoursaddle(button_pcb_dim[0],button_pcb_dim[1], 4+4,4+2.2, button_pcb_inner_offset,1);
            }
        }
    }
//    color("blue") cube([tftoff_x,pirplate_y,2]);
}

module button()
{
    //cube([18-0.5,20-0.5,1],center=true);
    // 22 20 - 2*button_pcb_inner_offset
    round_z = 4;
    plate_z = 1;
    sign_z = 0.4;
    cube([
        button_pcb_dim[0]-2*button_pcb_inner_offset-0.5,
        button_pcb_dim[1]-2*button_pcb_inner_offset-0.5,
        plate_z
        ],center=true);
    color("white")
    translate([0,0,plate_z/2+round_z/2])
        cylinder(round_z, d=button_hole_dia-1,center=true);

    translate([0,0,plate_z/2+round_z+sign_z/2])
    color("green")
    {
        translate([5,0,0])
        rotate([0,0,00])
        cylinder(sign_z, d=5,center=true,$fn=3);

        translate([-5,0,0])
        rotate([0,0,180])
        cylinder(sign_z, d=5,center=true,$fn=3);

        translate([0,5,0])
        rotate([0,0,90])
        cylinder(sign_z, d=5,center=true,$fn=3);

        translate([0,-5,0])
        rotate([0,0,-90])
        cylinder(sign_z, d=5,center=true,$fn=3);
    }
}
module button_holder()
{
    button_z=2.5;
    button_w=6.2;
    button_h=6.2;
    difference()
    {
        cube([
            button_pcb_dim[0]-button_pcb_inner_offset,
            button_pcb_dim[1]-button_pcb_inner_offset,
            button_z
            ],center=true);

        translate([(button_pcb_dim[0]-button_pcb_inner_offset)/2-button_w/2,0,0])
            cube([ button_w, button_h,2*button_z],center=true);
        translate([-((button_pcb_dim[0]-button_pcb_inner_offset)/2-button_w/2),0,0])
            cube([ button_w, button_h,2*button_z],center=true);

        translate([0,((button_pcb_dim[1]-button_pcb_inner_offset)/2-button_w/2),0])
            cube([ button_h, button_w, 2*button_z],center=true);
        translate([0,-((button_pcb_dim[1]-button_pcb_inner_offset)/2-button_w/2),0])
            cube([ button_h, button_w, 2*button_z],center=true);

    }
    color("red")
    translate([0,0,1/2+button_z/2])
    difference()
    {
        cube([
            button_pcb_dim[0]-0*button_pcb_inner_offset,
            button_pcb_dim[1]-0*button_pcb_inner_offset,
            1
            ],center=true);

        translate([(button_pcb_dim[0]-button_pcb_inner_offset)/2-button_w/2,0,0])
        {
            translate([-2,0,0])
                cube([ 2, 2+button_h,2*button_z],center=true);
            translate([2,0,0])
                cube([ 2, 2+button_h,2*button_z],center=true);
        }
        translate([-((button_pcb_dim[0]-button_pcb_inner_offset)/2-button_w/2),0,0])
        {
            translate([-2,0,0])
                cube([ 2, 2+button_h,2*button_z],center=true);
            translate([2,0,0])
                cube([ 2, 2+button_h,2*button_z],center=true);
        }

        translate([0,((button_pcb_dim[1]-button_pcb_inner_offset)/2-button_w/2),0])
        {
            translate([0,-2,0])
                cube([8+button_w,2,2*button_z],center=true);
            translate([0,2,0])
                cube([8+button_w,2,2*button_z],center=true);

        }
        translate([0,-((button_pcb_dim[1]-button_pcb_inner_offset)/2-button_w/2),0])
        {
            translate([0,-2,0])
                cube([8+button_w,2,2*button_z],center=true);
            translate([0,2,0])
                cube([8+button_w,2,2*button_z],center=true);
        }
    }

}
if(PARTNO==PARTNO_BUTTON)
{
    button();
}
if(PARTNO==PARTNO_BUTTON_HOLDER)
{
    button_holder();
}

if(PARTNO==PARTNO_ALL)
{
  translate(button_pos)
  {
    translate([plate_thickness,0,0])
    rotate([0,270,0])
    button();
  }
}


