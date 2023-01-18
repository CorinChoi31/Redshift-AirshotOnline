/// @function camera_3d_create(layer, fov, aspect, znear, zfar, xfrom, yfrom, zfrom, xto, yto, zto, xvec, yvec, zvec, velocity, width, height)
/// @param layer
/// @param fov
/// @param aspect
/// @param znear
/// @param zfar
/// @param xfrom
/// @param yfrom
/// @param zfrom
/// @param xto
/// @param yto
/// @param zto
/// @param xvec
/// @param yvec
/// @param zvec
/// @param velocity
/// @param width
/// @param height

function camera_3d_create()
{
	var _camera = instance_create_layer(global.screen_width/2, global.screen_height/2, argument[0], OBJ_Camera3D);

	if(argument_count >= 5)
	{
		_camera.camera_fov = argument[1];
		_camera.camera_aspect = argument[2];
		_camera.camera_znear = argument[3];
		_camera.camera_zfar = argument[4];
	
		_camera.camera_fov_target = _camera.camera_fov;
		_camera.camera_aspect_target = _camera.camera_aspect;
		_camera.camera_znear_target = _camera.camera_znear;
		_camera.camera_zfar_target = _camera.camera_zfar;
	}
	if(argument_count >= 11)
	{
		_camera.camera_xfrom = argument[5];
		_camera.camera_yfrom = argument[6];
		_camera.camera_zfrom = argument[7];

		_camera.camera_xto = argument[8];
		_camera.camera_yto = argument[9];
		_camera.camera_zto = argument[10];
	
		_camera.camera_xfrom_target = _camera.camera_xfrom;
		_camera.camera_yfrom_target = _camera.camera_yfrom;
		_camera.camera_zfrom_target = _camera.camera_zfrom;

		_camera.camera_xto_target = _camera.camera_xto;
		_camera.camera_yto_target = _camera.camera_yto;
		_camera.camera_zto_target = _camera.camera_zto;
	}
	if(argument_count >= 14)
	{
		_camera.camera_xvec = argument[11];
		_camera.camera_yvec = argument[12];
		_camera.camera_zvec = argument[13];
	
		_camera.camera_xvec_target = _camera.camera_xvec;
		_camera.camera_yvec_target = _camera.camera_yvec;
		_camera.camera_zvec_target = _camera.camera_zvec;
	}
	if(argument_count >= 15)
	{
		_camera.camera_velocity = argument[14];
	}
	if(argument_count >= 17)
	{
		_camera.camera_width = argument[15];
		_camera.camera_height = argument[16];
		
		_camera.camera_width_target = _camera.camera_width;
		_camera.camera_height_target = _camera.camera_height;
	}

	if(global.__camera_index == 0)
	{
		layer_force_draw_depth(true, 0);
	}
	global.__camera_index += 1;

	return _camera;
}