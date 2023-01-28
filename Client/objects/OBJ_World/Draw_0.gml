if(fixture != undefined) {
    draw_primitive_begin(pr_linestrip);
    var _x = x;
    var _y = y;
    for(var _i = 360; _i >= 0; _i -= 360/angle)
    {
    	draw_vertex_color(_x + lengthdir_x(range, _i + rot), _y + lengthdir_y(range, _i + rot), c_white, 0.75);
    }
    draw_primitive_end();
}