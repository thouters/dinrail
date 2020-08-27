use <rpipcb.scad>;
translate([10,89,0])
rotate([0,0,-90])
        rpicradle();
translate([160,-120,0])
    import("DIN_DEFAULT.stl");




translate([0,3,0])
cube([10,87,4.4]);
