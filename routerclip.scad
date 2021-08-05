

board_z = 10;
screw_spacing=13;
nut_z = 2.5;
nut_dia = 6.5;
nut_handling_dia=8;
screw_dia = 3.2;


module holes()
{
    for (hole_y= [-screw_spacing/2,screw_spacing/2])
    {
        translate([0,hole_y,0])
        {
            cylinder(h=board_z+1,d=screw_dia,$fn=200,center=true);
            
            nut_z_a = board_z/2 - nut_z/2+0.5;

            translate([0,0,nut_z_a])
            {
                    cylinder(h=nut_z,d=nut_handling_dia,$fn=200,center=true);
            }

            if (0)
            {
            nut_z_b = board_z/2 - 2*nut_z/2+0.5;
            translate([0,0,-nut_z_b])
            {
                    cylinder(h=2*nut_z,d=nut_dia,$fn=6,center=true);
            }
            }
        }
    }

}
if(1)
{
    difference()
    {

        union()
        {
        translate([160,-123,0])
            import("DIN_DEFAULT.stl");
            if(0)
        translate([-1,85/2,25/2])
        rotate([-90,90,90])
        cube([25,20,7],center=true);
        
        }
        translate([0,85/2,25/2])
        rotate([-90,90,90])
        holes();
    }
    // lock the clip
    translate([-1,-6,0])
        cube([3,6,4.4]);

} else if (0==1){
    difference()
    {
        cube([16,22,board_z],center=true);
        holes();
        
    }

}
else
{


locklength = 100;
translate([283.8,-261.5,0])
import("external/DIN_LOCK.stl");
translate([-16.4,-locklength,0])
cube([16.4,locklength,2.5]);
}
