/// @function camera_perspected(camera, x, y)
/// @param camera
/// @param x
/// @param y

function camera_perspected(_camera, _x, _y)
{
	if(_camera == undefined)
	{
		_camera = global.__camera;
	}
	
	var _view_width = _camera.camera_width;
	var _view_height = _camera.camera_height;

	var _view_aspect = _camera.camera_aspect;

	var _matrix = _camera.camera_matrix_lookat;

	var _fov = _camera.camera_fov;
	
	var _return = undefined;

	_x = _view_aspect *	dtan(_fov/2)*(2*_x/_view_width-1);
	_y =				dtan(_fov/2)*(2*_y/_view_height-1);

	var mouse_vector_x = (_x * _matrix[0]) + (_y * _matrix[1]) + _matrix[2];
	var mouse_vector_y = (_x * _matrix[4]) + (_y * _matrix[5]) + _matrix[6];
	var mouse_vector_z = (_x * _matrix[8]) + (_y * _matrix[9]) + _matrix[10];

	if(mouse_vector_z != 0)
	{
		var _t = -_camera.camera_zfrom / mouse_vector_z;
		if(_t >= 0)
		{
			_return = [_camera.camera_xfrom + mouse_vector_x * _t, _camera.camera_yfrom + mouse_vector_y * _t];
		}
	}
	return _return;
}
