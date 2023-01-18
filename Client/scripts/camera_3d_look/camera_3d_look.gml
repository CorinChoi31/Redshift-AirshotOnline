/// @function camera_3d_look(camera, xto, yto, zto, xfrom, yfrom, zfrom, xvec, yvec, zvec)
/// @param camera
/// @param xto
/// @param yto
/// @param zto
/// @param xfrom
/// @param yfrom
/// @param zfrom
/// @param xvec
/// @param yvec
/// @param zvec

function camera_3d_look(_camera, _xto, _yto, _zto, _xfrom, _yfrom, _zfrom, _xvec, _yvec, _zvec)
{
	_camera.camera_xto = _xto;
	_camera.camera_yto = _yto;
	_camera.camera_zto = _zto;

	_camera.camera_xfrom = _xfrom;
	_camera.camera_yfrom = _yfrom;
	_camera.camera_zfrom = _zfrom;

	_camera.camera_xvec = _xvec;
	_camera.camera_yvec = _yvec;
	_camera.camera_zvec = _zvec;
}
