module contoursaddle(size_x, size_y, outer_z, inner_z, inner_offset, outer_offset)
{
    linear_extrude(outer_z)
    difference()
    {
    offset(outer_offset) square([size_x,size_y]);
    square([size_x,size_y]);
    }

    linear_extrude(inner_z)
    difference()
    {
        square([size_x,size_y]);
        offset(-inner_offset) square([size_x,size_y]);
    }
}
