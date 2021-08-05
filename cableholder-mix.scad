
translate([10,0,0])
rotate([0,0,90]) translate([0,0,-27]) import("external/DIN_Rail_Cable_Clamp.stl");

translate([-10,0,0])
difference()
{
rotate([0,0,180]) import("external/DIN_rail_cable_clip.stl");
translate([20,0,0])
cube([10,50,10],center=true);
}
