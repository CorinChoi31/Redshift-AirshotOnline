/// @function camera_assign(view, camera)
/// @param view
/// @param camera

function camera_assign(_view, _camera)
{
	if(_camera != undefined)
	{
		if(view_camera[_view] != _camera.camera)
		{
			view_camera[_view] = _camera.camera;
			camera_apply(view_camera[_view]);
		}
	}
	else
	{
		if(view_camera[_view] != global.__camera)
		{
			view_camera[_view] = global.__camera;
			camera_apply(view_camera[_view]);
		}
	}
}