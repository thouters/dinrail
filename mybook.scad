include <contoursaddle.scad>;
$fn=200;

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


base_hdd_width = 49.5;
hdd_x_width = 168;
fanbore_cylinderlength = 10;
fanbore_dia = 30;
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
PARTNO=1;
if(PARTNO==0)
{
    difference()
    {
        contoursaddle(hdd_x_width ,base_hdd_width, hdd_contact_z, 4, 5, 2);
        translate([-fanbore_cylinderlength/2,base_hdd_width/2,5+fanbore_dia/2])
        rotate([0,90,0]) cylinder(fanbore_cylinderlength ,d=fanbore_dia);
    }

    translate([168/2-middlesupport_x/2,0,0]) cube([middlesupport_x,base_hdd_width,4]);

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
else
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
