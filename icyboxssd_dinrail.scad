include <contoursaddle.scad>;
$fn=200;

strap_pos_x = [8,55];
strap_pos_y= [10,90];

strapmount_z = 5;
strap_outer_dim = [6,8,strapmount_z];
strap_inner_dim = [2,4,2*strapmount_z];

difference()
{
    translate([160,-120,0])
        import("DIN_DEFAULT.stl");

    translate([-5,82,10])
    {
        rotate([0,90,0])
        cylinder(20,d=2.8);

        translate([0,0,9.2])
        rotate([0,90,0])
        cylinder(20,d=2.8);


    }
}

icybox_x=39.2;
icybox_y=103;

translate([12,-5,0])
{
    //rotate([0,0,90])
    contoursaddle(icybox_x,icybox_y, 7, 4, 2, 2);
}

difference()
{
    translate([0,0,0])
        cube([10,97,4.4]);

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

module fansaddle()
{

    //contoursaddle(50,50, 7, 4, 2, 2);
    contoursaddle(50,50, fansaddle_offset_z+4+11, fansaddle_offset_z+4, 2, 2);
}
fansaddle_offset_z=20;
{
    difference()
    {
        union()
        {
//            translate([8,20,fansaddle_offset_z])
            translate([8,20,0])
            {
                fansaddle();
//                translate([0,0,-fansaddle_offset_z])
 //               linear_extrude(fansaddle_offset_z)
  //              projection(cut=true)
   //             fansaddle();
            }
        }

        translate([12,-5+2,0])
            cube([icybox_x+0*2,icybox_y+2*2,50]);
    }

}

translate([-1,-6,0])
    cube([3,10,4.4]);


