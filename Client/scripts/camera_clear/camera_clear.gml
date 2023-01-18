/// @function camera_clear(camera)
/// @param camera

function camera_clear(_camera)
{
	with(_camera)
	{
		instance_destroy();
	}

	global.__camera_index -= 1;
	if(global.__camera_index == 0)
	{
		layer_force_draw_depth(false, 0);
	}
}