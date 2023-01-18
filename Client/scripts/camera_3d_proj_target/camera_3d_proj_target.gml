/// @function camera_3d_proj(camera, fov, aspect, znear, zfar)
/// @param camera
/// @param fov
/// @param aspect
/// @param znear
/// @param zfar

function camera_3d_proj_target(_camera, _fov, _aspect, _znear, _zfar)
{
	_camera.camera_fov_target = _fov;
	_camera.camera_aspect_target = _aspect;
	_camera.camera_znear_target = _znear;
	_camera.camera_zfar_target = _zfar;
}
