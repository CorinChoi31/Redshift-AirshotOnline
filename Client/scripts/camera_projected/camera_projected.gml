/// @function camera_projected(camera, x, y, z)
/// @param camera
/// @param x
/// @param y
/// @param z

function camera_projected(_camera, _x, _y, _z)
{
	if(_camera == undefined)
	{
		_camera = global.__camera;
	}
	
	var _view_width = _camera.camera_width;
	var _view_height = _camera.camera_height;

	var _view_aspect = _camera.camera_aspect;
	
	var _matrix_lookat = _camera.camera_matrix_lookat;
	var _matrix_projection = _camera.camera_matrix_projection;

	var _fov = _camera.camera_fov;
	
	var _return = undefined;
	
	var __x;
	var __y;
	
	if(_matrix_projection[15] == 0)
	{
		var _w = _matrix_lookat[2] * _x + _matrix_lookat[6] * _y + _matrix_lookat[10] * _z + _matrix_lookat[14];
		
		if(_w != 0)
		{
			__x = _matrix_projection[8] + 
					_matrix_projection[0]*(_matrix_lookat[0]*_x + _matrix_lookat[4]*_y + _matrix_lookat[8]*_z + _matrix_lookat[12])/_w;
			__y = _matrix_projection[9] + 
					_matrix_projection[5]*(_matrix_lookat[1]*_x + _matrix_lookat[5]*_y + _matrix_lookat[9]*_z + _matrix_lookat[13])/_w;
			
			_return = [_view_width*(0.5 + 0.5*__x), _view_height*(0.5 + 0.5*__y)];
		}
	}
	else
	{
		__x = _matrix_projection[12] + 
				_matrix_projection[0]*(_matrix_lookat[0]*_x + _matrix_lookat[4]*_y + _matrix_lookat[8]*_z + _matrix_lookat[12]);
		__y = _matrix_projection[13] + 
				_matrix_projection[5]*(_matrix_lookat[1]*_x + _matrix_lookat[5]*_y + _matrix_lookat[9]*_z + _matrix_lookat[13]);
		
		_return = [_view_width*(0.5 + 0.5*__x), _view_height*(0.5 + 0.5*__y)];
	}
	
	return _return;
}