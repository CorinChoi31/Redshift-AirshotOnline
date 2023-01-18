/// @function camera_3d_look_from_target(camera, x, y, z)
/// @param camera
/// @param x
/// @param y
/// @param z

function camera_3d_look_from_target(_camera, _x, _y, _z)
{
	_camera.camera_xfrom_target = _x;
	_camera.camera_yfrom_target = _y;
	_camera.camera_zfrom_target = _z;
}
