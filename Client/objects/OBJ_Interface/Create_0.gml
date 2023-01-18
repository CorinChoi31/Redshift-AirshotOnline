game = noone;
player = noone;

global.__camera = view_camera[0];

var _tofrom = 0;
_tofrom = (global.screen_height*2)*sin(degtorad(24));
camera3d_left = camera_3d_create("GameForeground", 60, global.screen_width/global.screen_height, 32, 32000, global.screen_width/2, global.screen_height/2, 0, global.screen_width/2, global.screen_height/2, 0, 0, 1, 0, global.__frame*0.5, global.screen_width, global.screen_height);
	camera_3d_look_from_target(camera3d_left, camera3d_left.camera_xfrom, camera3d_left.camera_yfrom, -_tofrom);
	camera_3d_look_from(camera3d_left, camera3d_left.camera_xfrom, camera3d_left.camera_yfrom, -_tofrom);
_tofrom = (global.screen_height*2)*sin(degtorad(24));
camera3d_right = camera_3d_create("GameForeground", 60, global.screen_width/global.screen_height, 32, 32000, global.screen_width/2, global.screen_height/2, 0, global.screen_width/2, global.screen_height/2, 0, 0, 1, 0, global.__frame*0.5, global.screen_width, global.screen_height);
	camera_3d_look_from_target(camera3d_right, camera3d_right.camera_xfrom, camera3d_right.camera_yfrom, -_tofrom);
	camera_3d_look_from(camera3d_right, camera3d_right.camera_xfrom, camera3d_right.camera_yfrom, -_tofrom);
    
cursor_x = 0;
cursor_y = 0;
cursor_range = 0;
cursor_range_target = 32;