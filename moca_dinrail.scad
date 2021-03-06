include <contoursaddle.scad>;
$fn=200;

strap_pos_x = [8,58];
strap_pos_y= [25,119-25];

strapmount_z = 4;
strap_outer_dim = [6,8,strapmount_z];
strap_inner_dim = [2,4,2*strapmount_z];

dinz=20.6;

translate([160,-120,-dinz])
    import("DIN_DEFAULT.stl");


difference()
{
    union()
    {
    translate([0,0,0])
        cube([63,115,4.4]);
    translate([0,80,-dinz])
        cube([5,35,25]);
    }

    for (X=strap_pos_x)
    {
        for (Y=strap_pos_y)
        {
        translate([X,Y,strapmount_z/2])
                cube(strap_inner_dim,center=true);
        }
    }
    for (Y= [5,110])
    {
        translate([33,Y,strapmount_z/2])
        {

strap_inner_dim = [2,4,2*strapmount_z];
            cube([strap_inner_dim[1],strap_inner_dim[0],strap_inner_dim[2]]
            ,center=true);

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

