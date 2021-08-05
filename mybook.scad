include <contoursaddle.scad>;
$fn=200;

PARTNO_ALL = 0;
PARTNO_RAILCLIP = 1;
PARTNO_BOX = 2;

/* change the defaultpartno to view parts during development */
defaultpartno=PARTNO_ALL;
/* overridden to generate individual parts with -D in the Makefile */
PARTNO = defaultpartno;


module contact(w_base, w_y, y, spacing)
{
    for(space=[0, spacing+w_base])
    {

        translate([space,0,0])
        polygon([[-w_base/2,0],
        [-w_base/2, -2],
        [w_base/2, -2],
        [w_base/2, 0],
        [w_y/2, y],
        [-w_y/2,y]]
        );
    }
}


base_hdd_width = 49.5+4;
hdd_x_width = 168+1;
fanbore_cylinderlength = 10;
fanbore_dia = 10;
hdd_contact_z = 80;
//hdd_contact_z = 30;
middlesupport_x = 10;
contact_a = 5;
contact_b = 10;
contact_d=5;

hook_x_margin = 6;
hook_x_width = 2*contact_b+2*contact_a+hook_x_margin;
hook_y_width = contact_d+2;

hook_z_overlap = 4;
bottom_z =2;

if (PARTNO == PARTNO_BOX||PARTNO==PARTNO_ALL)
{
    difference()
    {
        contoursaddle(hdd_x_width ,base_hdd_width, hdd_contact_z, bottom_z, 5, 1.5);
        y_0 = 4+ fanbore_dia/2;
        z_0 = 4+fanbore_dia/2;
        for (zstep = [0,1,2,3])
        {
            for (ystep = [0,1,2])
            {
                y = ystep*(fanbore_dia+8)+y_0;
                z = zstep*(fanbore_dia+8)+z_0;

                translate([hdd_x_width/2,y,z])
                    //rotate([0,90,0]) cylinder(hdd_x_width*2 ,d=fanbore_dia,center=true);
                    cube([hdd_x_width*2,fanbore_dia,fanbore_dia],center=true);
            }
        }
    }

    translate([168/2-middlesupport_x/2,0,0]) cube([middlesupport_x,base_hdd_width,bottom_z]);

    for(hookmount_x=[0, hdd_x_width-hook_x_width])
    {
        translate([hookmount_x,-hook_y_width, 0])
        difference()
        {
            cube([hook_x_width, hook_y_width, hdd_contact_z]);
            
            translate([hook_x_margin/2+contact_a/2+contact_b/2,0,0])
            translate([0,0,-hook_z_overlap/2])
            linear_extrude(hdd_contact_z+hook_z_overlap)
                offset(0.1)
                contact(contact_a,contact_b , contact_d,contact_a*2);
        }
    }

}

module railclip()
{
    translate([160,-123,0])
        import("DIN_DEFAULT.stl");

    translate([5.2,80,19.9])
        rotate([90,90,0])
            linear_extrude(80)
                offset(-0.2)
                contact(contact_a,contact_b , contact_d,contact_a*2);

    translate([5,0,0])
        cube([10,5,25]);

    // lock the clip
    translate([-1,-6,0])
        cube([3,6,4.4]);
}

if (PARTNO == PARTNO_RAILCLIP)
{
    railclip();
}

if (PARTNO == PARTNO_ALL)
{
    translate([6,-12,-5])
    color("red")
    rotate([90,0,90])
    railclip();

    translate([138,-12,-5])
    color("red")
    rotate([90,0,90])
    railclip();


}
