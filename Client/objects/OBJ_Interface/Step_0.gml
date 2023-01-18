var _mouse_x_gui = device_mouse_x_to_gui(0);
var _mouse_y_gui = device_mouse_y_to_gui(0);


cursor_x = lerp(cursor_x, _mouse_x_gui, 0.5);
cursor_y = lerp(cursor_y, _mouse_y_gui, 0.5);
cursor_range = lerp(cursor_range, cursor_range_target, 0.2);


var _mouse_y = global.screen_height/2;
_mouse_y += (global.screen_height/2 - _mouse_y_gui) * 0.1;

var _mouse_x = global.screen_width/16*7;
_mouse_x += (global.screen_width/16*7 - _mouse_x_gui) * 0.032;
camera_3d_look_from_target(camera3d_left, _mouse_x, _mouse_y, camera3d_left.camera_zfrom);


_mouse_x = global.screen_width/16*9;
_mouse_x += (global.screen_width/16*9 - _mouse_x_gui) * 0.032;
camera_3d_look_from_target(camera3d_right, _mouse_x, _mouse_y, camera3d_right.camera_zfrom);