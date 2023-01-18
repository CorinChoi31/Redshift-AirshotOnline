/// @function draw_rectangle_line_vertex(x1, y1, x2, y2, width, color, color, color, color, alpha, alpha, alpha, alpha)
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param width
/// @param color
/// @param color
/// @param color
/// @param color
/// @param alpha
/// @param alpha
/// @param alpha
/// @param alpha

function draw_rectangle_line_vertex(_x1, _y1, _x2, _y2, _width, _color1, _color2, _color3, _color4, _alpha1, _alpha2, _alpha3, _alpha4)
{
	var _pos_top_left_x = _x1 + _width;
	var _pos_top_left_y = _y1 + _width;
	
	var _pos_top_right_x = _x2 - _width;
	var _pos_top_right_y = _y1 + _width;
	
	var _pos_bottom_right_x = _x2 - _width;
	var _pos_bottom_right_y = _y2 - _width;
	
	var _pos_bottom_left_x = _x1 + _width;
	var _pos_bottom_left_y = _y2 - _width;
	
	draw_primitive_begin(pr_trianglestrip);
		draw_vertex_color(_x1, _y1, _color1, _alpha1);
		draw_vertex_color(_pos_top_left_x, _pos_top_left_y, _color1, _alpha1);
		draw_vertex_color(_x2, _y1, _color2, _alpha2);
		draw_vertex_color(_pos_top_right_x, _pos_top_right_y, _color2, _alpha2);
		draw_vertex_color(_x2, _y2, _color3, _alpha3);
		draw_vertex_color(_pos_bottom_right_x, _pos_bottom_right_y, _color3, _alpha3);
		draw_vertex_color(_x1, _y2, _color4, _alpha4);
		draw_vertex_color(_pos_bottom_left_x, _pos_bottom_left_y, _color4, _alpha4);
		draw_vertex_color(_x1, _y1, _color1, _alpha1);
		draw_vertex_color(_pos_top_left_x, _pos_top_left_y, _color1, _alpha1);
	draw_primitive_end();
}