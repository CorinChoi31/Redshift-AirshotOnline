/// @function camera_3d_look_vec(camera, x, y, z)
/// @param camera
/// @param x
/// @param y
/// @param z

function camera_3d_look_vec(_camera, _x, _y, _z)
{
	_camera.camera_xvec = _x;
	_camera.camera_yvec = _y;
	_camera.camera_zvec = _z;
}