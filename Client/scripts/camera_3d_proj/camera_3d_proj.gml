/// @function camera_3d_proj(camera, fov, aspect, znear, zfar)
/// @param camera
/// @param fov
/// @param aspect
/// @param znear
/// @param zfar

function camera_3d_proj(_camera, _fov, _aspect, _znear, _zfar)
{
	_camera.camera_fov = _fov;
	_camera.camera_aspect = _aspect;
	_camera.camera_znear = _znear;
	_camera.camera_zfar = _zfar;
}