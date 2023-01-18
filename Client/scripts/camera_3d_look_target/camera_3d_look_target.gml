/// @function camera_3d_look_target(camera, xto, yto, zto, xfrom, yfrom, zfrom, xvec, yvec, zvec)
/// @param xto
/// @param yto
/// @param zto
/// @param camera
/// @param xfrom
/// @param yfrom
/// @param zfrom
/// @param xvec
/// @param yvec
/// @param zvec

function camera_3d_look_target(_camera, _xto, _yto, _zto, _xfrom, _yfrom, _zfrom, _xvec, _yvec, _zvec) 
{
	_camera.camera_xto_target = _xto;
	_camera.camera_yto_target = _yto;
	_camera.camera_zto_target = _zto;

	_camera.camera_xfrom_target = _xfrom;
	_camera.camera_yfrom_target = _yfrom;
	_camera.camera_zfrom_target = _zfrom;

	_camera.camera_xvec_target = _xvec;
	_camera.camera_yvec_target = _yvec;
	_camera.camera_zvec_target = _zvec;
}
