rpi_pcb_height=1.4;

peg_grip_width = 1.3;
peg_height=4;
clip_y_size = 2;
rpi_pcb_size_x =85.5;
rpi_pcb_size_y =56;
rpi_corner_radius=3;
rpi_clip_z_gap = 1.8;
peg_support_stickout=4;
layerheight=0.2;
rpitype=2;
module rpipcb_2d()
{
//    square([rpi_pcb_size_x,rpi_pcb_size_y]);

   translate([rpi_pcb_size_x/2,rpi_pcb_size_y/2,0])
   hull()
   {
        for (Mirror_X=[0:1:1])
        {
           mirror([Mirror_X,0,0])
           {
                for (Mirror_Y=[0:1:1])
                {
                   mirror([0,Mirror_Y,0])
                   {
                        translate([
                            rpi_pcb_size_x/2-rpi_corner_radius,
                            rpi_pcb_size_y/2-rpi_corner_radius,
                            0
                        ])
                        if(rpitype==2)
                        {
                            circle(r=rpi_corner_radius,center=true,$fn = 80);
                        }
                        else
                        {
                            square(2*rpi_corner_radius,true);
                        }
                    }
                }


            }
        }
    }

}
module rpicontour(offsetradius)
{
    if( offsetradius > 0)
    {
        difference()
        {
            offset(delta=offsetradius)
            {
                rpipcb_2d();
            }
            rpipcb_2d();
        }
    }
    else
    {
        difference()
        {
            offset(delta=abs(offsetradius))
            {
                rpipcb_2d();
            }
            offset(delta=offsetradius)
            {
                rpipcb_2d();
            }
        }
   }
}


module rpicradle(base_plate_height=2.4,rpiraise_height=8,  clip_x_size = 5)
{
    clip_height = rpiraise_height+base_plate_height+6;
    difference()
    {
        union()
        {
            // inside support
            linear_extrude(base_plate_height+rpiraise_height,center=false)
                    rpicontour(-1.5);
            // outside container
            linear_extrude(base_plate_height+rpiraise_height+rpi_pcb_height+0.8,center=false)
                    rpicontour(1.5);
        }
        // clip gaps
        translate([rpi_pcb_size_x/2,rpi_pcb_size_y/2,rpiraise_height+base_plate_height])
            cube([clip_x_size+68,rpi_pcb_size_y+4,rpiraise_height+base_plate_height],center=true);

        translate([rpi_pcb_size_x/2,(rpi_pcb_size_y)/2,rpiraise_height+base_plate_height])
            cube([rpi_pcb_size_x+20,rpi_pcb_size_y-10,rpiraise_height+base_plate_height],center=true);
    }
    translate([0,rpi_pcb_size_y/2,0])
    {
        for (Mirror_Y=[0:1:1])
        {
           mirror([0,Mirror_Y,0])
           {
            for (tabx=[((rpitype==1)? 30: 10),((rpitype==1)? 30: rpi_pcb_size_x-19)])
            {
                translate([
                    tabx,
                    rpi_pcb_size_y/2,
                    0
                ])
                {

                    translate([
                        0,
                        1,
                        clip_height/2
                    ])
                    {
                        // clip body
                        color("blue")
                        cube([ clip_x_size,
                               clip_y_size,
                               clip_height],center=true);
                    }

                    translate([
                        0,
                        0 ,
                        (rpiraise_height+base_plate_height)/2
                    ])
                    {
                        // clip body
                        cube([ clip_x_size,
                               clip_y_size+1,
                               rpiraise_height+base_plate_height],center=true);
                    }
                    translate([
                        - clip_x_size/2,
                        0,
                        rpiraise_height+base_plate_height+rpi_clip_z_gap+peg_height/2+2
                    ])
                    {
                        color("lime")
                        rotate([-90,0,-90])
                        // retention peg 
                        linear_extrude(clip_x_size)
                            polygon([
                                [0,0],
                                [peg_grip_width,peg_height],
                                [0,peg_height],
                                [0,0],
                            ]);
                    }
                }
             }
            }
        }
    }
}
