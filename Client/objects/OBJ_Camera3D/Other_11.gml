if(camera_enable)
{
	var _camera_velocity = 1;
	
	if(camera_fov != camera_fov_target
		or camera_aspect != camera_aspect_target
		or camera_znear != camera_znear_target
		or camera_zfar != camera_zfar_target
	)
	{
		camera_fov += (camera_fov_target-camera_fov)/(_camera_velocity);
		camera_aspect += (camera_aspect_target-camera_aspect)/(_camera_velocity);
		camera_znear += (camera_znear_target-camera_znear)/(_camera_velocity);
		camera_zfar += (camera_zfar_target-camera_zfar)/(_camera_velocity);
	}
	
	if(camera_xfrom != camera_xfrom_target
		or camera_yfrom != camera_yfrom_target
		or camera_zfrom != camera_zfrom_target
	)
	{
		camera_xfrom += (camera_xfrom_target-camera_xfrom)/(_camera_velocity);
		camera_yfrom += (camera_yfrom_target-camera_yfrom)/(_camera_velocity);
		camera_zfrom += (camera_zfrom_target-camera_zfrom)/(_camera_velocity);
	}
	if(camera_xto != camera_xto_target
		or camera_yto != camera_yto_target
		or camera_zto != camera_zto_target
	)
	{
		camera_xto += (camera_xto_target-camera_xto)/(_camera_velocity);
		camera_yto += (camera_yto_target-camera_yto)/(_camera_velocity);
		camera_zto += (camera_zto_target-camera_zto)/(_camera_velocity);
	}
	if(camera_xvec != camera_xvec_target
		or camera_yvec != camera_yvec_target
		or camera_zvec != camera_zvec_target
	)
	{
		camera_xvec += (camera_xvec_target-camera_xvec)/(_camera_velocity);
		camera_yvec += (camera_yvec_target-camera_yvec)/(_camera_velocity);
		camera_zvec += (camera_zvec_target-camera_zvec)/(_camera_velocity);
	}
	
	if(camera_width != camera_width_target
		or camera_height != camera_height_target
	)
	{
		camera_width += (camera_width_target-camera_width)/(_camera_velocity);
		camera_height += (camera_height_target-camera_height)/(_camera_velocity);
	}
	
	camera_set_view_size(camera, camera_width, camera_height);
	
	camera_matrix_projection = matrix_build_projection_perspective_fov(camera_fov, camera_aspect, camera_znear, camera_zfar);
	camera_set_proj_mat(camera, camera_matrix_projection);
	
	camera_matrix_lookat = matrix_build_lookat(camera_xfrom, camera_yfrom, camera_zfrom, camera_xto, camera_yto, camera_zto, camera_xvec, camera_yvec, camera_zvec);
	camera_set_view_mat(camera, camera_matrix_lookat);
}