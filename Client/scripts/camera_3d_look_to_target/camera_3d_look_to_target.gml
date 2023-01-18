///@function camera_3d_look_to_target(camera, x, y, z)
/// @param camera
/// @param x
/// @param y
/// @param z

function camera_3d_look_to_target(_camera, _x, _y, _z)
{
	_camera.camera_xto_target = _x;
	_camera.camera_yto_target = _y;
	_camera.camera_zto_target = _z;
}