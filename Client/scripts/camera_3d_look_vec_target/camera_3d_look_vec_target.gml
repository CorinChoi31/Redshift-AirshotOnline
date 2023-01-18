///@function camera_3d_look_vec_target(camera, x, y, z)
/// @param camera
/// @param x
/// @param y
/// @param z

function camera_3d_look_vec_target(_camera, _x, _y, _z)
{
	_camera.camera_xvec_target = _x;
	_camera.camera_yvec_target = _y;
	_camera.camera_zvec_target = _z;
}