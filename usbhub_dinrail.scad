include <contoursaddle.scad>;
$fn=200;

strap_pos_x = [8,34];
strap_pos_y= [10,119-10];

strapmount_z = 5;
strap_outer_dim = [6,8,strapmount_z];
strap_inner_dim = [2,4,2*strapmount_z];



translate([160,-120,0])
    import("DIN_DEFAULT.stl");

translate([12,-5,0])
{
    //rotate([0,0,90])
    contoursaddle(18.5,122, 7, 7-1.8, 2, 2);
}

difference()
{
    union()
    {
    translate([0,0,0])
        cube([10,115,4.4]);
    translate([0,80,0])
        cube([5,35,25]);
    }

    for (Y=[90,110])
    {
        translate([-5,Y,10])
        {
            rotate([0,90,0])
            cylinder(20,d=3);
            translate([0,0,9])
            rotate([0,90,0])
            cylinder(20,d=3);
        }
    }

    for (X=strap_pos_x)
    {
        for (Y=strap_pos_y)
        {
        translate([X,Y,strapmount_z/2])
                cube(strap_inner_dim,center=true);
        }
    }
}

for (X=strap_pos_x)
{
    for (Y=strap_pos_y)
    {
        translate([X,Y,strapmount_z/2])
        difference()
        {
            cube(strap_outer_dim,center=true);
            cube(strap_inner_dim,center=true);
        }
    }
}

