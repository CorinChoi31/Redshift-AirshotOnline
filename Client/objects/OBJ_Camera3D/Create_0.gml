camera = camera_create();

camera_enable = true;
camera_velocity = global.__frame;

camera_fov = -60;
camera_aspect = global.screen_width/global.screen_height;
camera_znear = 32;
camera_zfar = 32000;

camera_fov_target = camera_fov;
camera_aspect_target = camera_aspect;
camera_znear_target = camera_znear;
camera_zfar_target = camera_zfar;

camera_xfrom = global.screen_width/2;
camera_yfrom = global.screen_height/2;
camera_zfrom = 0;

camera_xto = global.screen_width/2;
camera_yto = global.screen_height/2;
camera_zto = 0;

camera_xvec = 0;
camera_yvec = 0;
camera_zvec = 0;

camera_xfrom_target = camera_xfrom;
camera_yfrom_target = camera_yfrom;
camera_zfrom_target = camera_zfrom;

camera_xto_target = camera_xto;
camera_yto_target = camera_yto;
camera_zto_target = camera_zto;

camera_xvec_target = camera_xvec;
camera_yvec_target = camera_yvec;
camera_zvec_target = camera_zvec;

camera_width = 0;
camera_height = 0;

camera_width_target = 0;
camera_height_target = 0;

camera_set_view_size(camera, camera_width, camera_height);

camera_matrix_projection = matrix_build_projection_perspective_fov(camera_fov, camera_aspect, camera_znear, camera_zfar);
camera_set_proj_mat(camera, camera_matrix_projection);
	
camera_matrix_lookat = matrix_build_lookat(camera_xfrom, camera_yfrom, camera_zfrom, camera_xto, camera_yto, camera_zto, camera_xvec, camera_yvec, camera_zvec);
camera_set_view_mat(camera, camera_matrix_lookat);