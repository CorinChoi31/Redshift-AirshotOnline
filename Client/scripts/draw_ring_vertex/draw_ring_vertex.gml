/// @function draw_ring_vertex(x, y, angle, density, in_radius, out_radius, in_color, out_color, in_alpha, out_alpha, rotate, outline)
/// @param x
/// @param y
/// @param angle
/// @param density
/// @param in_radius
/// @param out_radius
/// @param in_color
/// @param out_color
/// @param in_alpha
/// @param out_alpha
/// @param rotate
/// @param outline

function draw_ring_vertex(_x, _y, _angle, _density, _in_radius, _out_radius, _in_color, _out_color, _in_alpha, _out_alpha, _rot, _outline)
{
	_angle = _angle <= 360 ? _angle : 360;
	_density = _density >= 2 ? _density : 2;
	
	_in_radius /= 2;
	_out_radius /= 2;
	
	var _i = 0;
	var _a = _angle/_density;
	
	if(_outline)
	{
		if(_in_radius == 0)
		{
			draw_primitive_begin(pr_linestrip);
				for(_i = 0; _i <= _angle; _i += _a)
				{
					draw_vertex_color(_x+lengthdir_x(_out_radius, _i+_rot), _y+lengthdir_y(_out_radius, _i+_rot), _out_color, _out_alpha);
				}
			draw_primitive_end();
		}
		else
		{
			draw_primitive_begin(pr_linestrip);
				draw_vertex_color(_x+lengthdir_x(_in_radius, _rot), _y+lengthdir_y(_in_radius, _rot), _in_color, _in_alpha);
				for(_i = 0; _i <= _angle; _i += _a)
				{
					draw_vertex_color(_x+lengthdir_x(_out_radius, _i+_rot), _y+lengthdir_y(_out_radius, _i+_rot), _out_color, _out_alpha);
				}
			draw_primitive_end();
			draw_primitive_begin(pr_linestrip);
				draw_vertex_color(_x+lengthdir_x(_in_radius, _angle+_rot), _y+lengthdir_y(_in_radius, _angle+_rot), _in_color, _in_alpha);
				for(_i = _angle-_a; _i >= 0; _i -= _a)
				{
					draw_vertex_color(_x+lengthdir_x(_in_radius, _i+_rot), _y+lengthdir_y(_in_radius, _i+_rot), _in_color, _in_alpha);
				}
			draw_primitive_end();
		}
	}
	else
	{
		if(_in_radius == 0)
		{
			draw_primitive_begin(pr_trianglelist);
				for(_i = 0; _i < _angle; _i += _a)
				{
					draw_vertex_color(_x+lengthdir_x(_out_radius, _i+_rot), _y+lengthdir_y(_out_radius, _i+_rot), _out_color, _out_alpha);
					draw_vertex_color(_x, _y, _in_color, _in_alpha);
					draw_vertex_color(_x+lengthdir_x(_out_radius, _i+_a+_rot), _y+lengthdir_y(_out_radius, _i+_a+_rot), _out_color, _out_alpha);
				}
				for(_i = 0; _i < _angle; _i += _a)
				{
					draw_vertex_color(_x, _y, _in_color, _in_alpha);
					draw_vertex_color(_x+lengthdir_x(_out_radius, _i+_a+_rot), _y+lengthdir_y(_out_radius, _i+_a+_rot), _out_color, _out_alpha);
					draw_vertex_color(_x, _y, _in_color, _in_alpha);
				}
			draw_primitive_end();
		}
		else
		{
			draw_primitive_begin(pr_trianglelist);
				for(_i = 0; _i < _angle; _i += _a)
				{
					draw_vertex_color(_x+lengthdir_x(_out_radius, _i+_rot), _y+lengthdir_y(_out_radius, _i+_rot), _out_color, _out_alpha);
					draw_vertex_color(_x+lengthdir_x(_in_radius, _i+_rot), _y+lengthdir_y(_in_radius, _i+_rot), _in_color, _in_alpha);
					draw_vertex_color(_x+lengthdir_x(_out_radius, _i+_a+_rot), _y+lengthdir_y(_out_radius, _i+_a+_rot), _out_color, _out_alpha);
				}
				for(_i = 0; _i < _angle; _i += _a)
				{
					draw_vertex_color(_x+lengthdir_x(_in_radius, _i+_rot), _y+lengthdir_y(_in_radius, _i+_rot), _in_color, _in_alpha);
					draw_vertex_color(_x+lengthdir_x(_out_radius, _i+_a+_rot), _y+lengthdir_y(_out_radius, _i+_a+_rot), _out_color, _out_alpha);
					draw_vertex_color(_x+lengthdir_x(_in_radius, _i+_a+_rot), _y+lengthdir_y(_in_radius, _i+_a+_rot), _in_color, _in_alpha);
				}
			draw_primitive_end();
		}
	}
}