/// @function camera_3d_look_from(camera, x, y, z)
/// @param camera
/// @param x
/// @param y
/// @param z

function camera_3d_look_from(_camera, _x, _y, _z)
{
	_camera.camera_xfrom = _x;
	_camera.camera_yfrom = _y;
	_camera.camera_zfrom = _z;
}
