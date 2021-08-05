

board_z = 10;
screw_spacing=67.5;
screw_dia = 3.2;

dinz=20.6;

module holes()
{
    for (hole_y= [-screw_spacing/2,screw_spacing/2])
    {
        translate([0,hole_y,0])
        {
            cylinder(h=board_z+1,d=screw_dia,$fn=200,center=true);
        }
    }
}

{
    difference()
    {

        union()
        {
            translate([160,-123,0])
                import("DIN_DEFAULT.stl");

    translate([0,80,-0])
        cube([5,35,25]);
        }
        translate([0,30+85/2,25/2])
        rotate([-90,90,90])
        holes();
    }
    // lock the clip
    translate([-1,-6,0])
        cube([3,6,4.4]);
}
