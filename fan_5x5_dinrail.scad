include <contoursaddle.scad>;
$fn=200;

difference()
{
    translate([160,-120,0])
        import("DIN_DEFAULT.stl");

    translate([-5,75,8])
    {
        rotate([0,90,0])
        cylinder(20,d=2.8);

        translate([0,0,9])
        rotate([0,90,0])
        cylinder(20,d=2.8);
    }
}

translate([12,10,0])
{
    //rotate([0,0,90])
    contoursaddle(50,50, 7, 4, 2, 2);
}

translate([0,0,0])
    cube([10,67,4.4]);


translate([12,-5,0])
{
    //rotate([0,0,90])
    contoursaddle(39.2,103, 7, 4, 2, 2);
}


