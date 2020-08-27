include <contoursaddle.scad>;
use <rpipcb.scad>;

PARTNO = 0;
$fn=100;
fdm = 0;
tft_z=40;
tftoff_x = 76;
tftoff_y= 22;
tftoff_z=2;
tft_margin_connector=5.5;
plate_thickness=1.2;

tft_x = 1.6;
tft_y=67.5;
finger_y=5;
finger_x=2;
finger_z=6;
pirplate_y=95;
pirplate_x=2;
piroff_y=90;
frontplate_z=tft_z+1*tftoff_z+2*plate_thickness;
pirplate_hole_dia=10;
frontplate_y = 90;

dinrail_z = 25;
railcontact_z = frontplate_z;
clip_padding_z = (railcontact_z - dinrail_z)/2;

x_support_z = 8;
module topplate()
{
    difference()
    {
        cube([1+tftoff_x+tft_x,frontplate_y,plate_thickness]);
        translate([12, 25,-10])
            cube([50,50,50]);
    }
    translate([12,25,plate_thickness])
    {
        mirror([0,0,1])
        contoursaddle(50,50, 7, 4, 2, 2);
    }

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
                    translate([finger_x/2,finger_y/2,finger_z/2])
                        rotate([0,90,0]) cylinder(10 ,d=3,center=true);
                }
            }
        }
    }

}

if (PARTNO == 3||PARTNO==0)
{
    color("orange")
    translate([2,0,railcontact_z - plate_thickness - 2])
    topplate();
}

if(PARTNO==1||PARTNO==0)
{
    difference()
    {
        difference()
        {
            translate([160,-123,0])
            {
                linear_extrude(clip_padding_z)
                projection(cut=true)
                import("DIN_DEFAULT.stl");
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
        translate([2,0,railcontact_z - plate_thickness - 2])
        {
            cube([1+tftoff_x+tft_x,frontplate_y,plate_thickness+0.2]);
        }
    }

    // clip/lock holder
    translate([-1,-6,clip_padding_z])
        cube([3,6,4.4]);

    translate([0,20,0])
        cube([10,tft_y,2]);

    translate([10,89,0])
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
                    translate([finger_x/2,finger_y/2,finger_z/2])
                        rotate([0,90,0]) cylinder(10 ,d=3,center=true);
                }
            }
        }
    }
}

if (PARTNO==0)
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


if(PARTNO==2||PARTNO==0)
{
    translate([tftoff_x+tft_x,0,0])
    {
        frontplate_margin=plate_thickness;
        translate([ 
            -tft_x-pirplate_x+5,
            -frontplate_margin,
            -frontplate_margin
        ])
        {
            color("green")
            difference()
            {
                cube([plate_thickness,
                    frontplate_y+2*frontplate_margin,
                    frontplate_z+2*frontplate_margin]);

                translate([0,frontplate_margin,frontplate_margin])
                {

                    // gap for tft
                    tftborder_z = 2;
                    translate([tft_x-5,tftoff_y+tft_margin_connector+7,tftoff_z+tftborder_z])
                        cube([10,tft_y-1*(7+5.5)-7,tft_z-2*tftborder_z]);

                    for(i =[0,1,2])
                    {
                            button_dia=13;
                                translate([pirplate_x/2,12,2+button_dia/2+i*5*2.54])
                                    rotate([0,90,0]) cylinder(10 ,d=button_dia,center=true);
                    }
                }

            }

            
            for(y =[0,frontplate_y+frontplate_margin])
            {
                color("black")
                translate([-plate_thickness,y,0])
                cube([2*plate_thickness,plate_thickness,frontplate_z+2*frontplate_margin]);
            }
            for(z =[0,frontplate_z+frontplate_margin])
            {
                color("black")
                translate([-plate_thickness,0,z])
                cube([2*plate_thickness,frontplate_y+2*frontplate_margin,plate_thickness]);
            }

        }
    }
//    color("blue") cube([tftoff_x,pirplate_y,2]);
}



