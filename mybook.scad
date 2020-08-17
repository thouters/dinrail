include <contoursaddle.scad>;
$fn=200;

module contact(w_base, w_y, y, spacing)
{
//    translate([-w_base/2, 0,0])
    polygon([[-w_base/2,0],
    [-w_base/2, -2],
    [w_base/2, -2],
    [w_base/2, 0],
    [w_y/2, y],
    [-w_y/2,y]]
    );
}
if(0)
difference()
{
//translate([160,-120,0]) import("DIN_DEFAULT.stl");

    translate([-5,75,8])
    {
        rotate([0,90,0])
        cylinder(20,d=2.8);

        translate([0,0,9])
        rotate([0,90,0])
        cylinder(20,d=2.8);


    }
}

base_hdd_width = 49;
hdd_x_width = 168;
fanbore_cylinderlength = 10;
fanbore_dia = 30;
//hdd_contact_z = 70;
hdd_contact_z = 10;
//translate([12,10,0])
difference()
{
    //rotate([0,0,90])
    contoursaddle(hdd_x_width ,base_hdd_width, hdd_contact_z, 4, 5, 2);
    translate([-fanbore_cylinderlength/2,base_hdd_width/2,5+fanbore_dia/2])
    rotate([0,90,0]) cylinder(fanbore_cylinderlength ,d=fanbore_dia);
}

//translate([0,0,0]) cube([10,67,4.4]);
middlesupport_x = 10;
translate([168/2-middlesupport_x/2,0,0]) cube([middlesupport_x,base_hdd_width,4]);

contact_a = 5;
contact_b = 10;
contact_d=5;

hook_x_margin = 6;
hook_x_width = 2*contact_b+1.5*hook_x_margin;
hook_y_width = contact_d+2;

for(hookmount_x=[0, hdd_x_width-hook_x_width])
{
    translate([hookmount_x,-hook_y_width, 0])
    difference()
    {
        cube([hook_x_width, hook_y_width, hdd_contact_z]);
        
        hook_z_overlap = 4;
        translate([hook_x_margin/2+contact_b/2,0,0])
        {
        translate([0,0,-hook_z_overlap/2])
        linear_extrude(hdd_contact_z+hook_z_overlap)
            offset(0.1)
            contact(contact_a,contact_b , contact_d);

        translate([contact_b+hook_x_margin/2,0,-hook_z_overlap/2])
        linear_extrude(hdd_contact_z+hook_z_overlap)
            offset(0.1)
            contact(contact_a,contact_b , contact_d);
        }

    }
}

