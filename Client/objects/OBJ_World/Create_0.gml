fixture = undefined;

range = 0;
angle = 360;
rotate = 0;

CreateFixture = function(_range, _angle, _rotate) {
    var _fixture = physics_fixture_create();
    physics_fixture_set_chain_shape(_fixture, true);

    for(var _i = 360; _i > 0; _i -= 360/_angle)
    {
    	physics_fixture_add_point(_fixture, lengthdir_x(_range, _i + _rotate), lengthdir_y(_range, _i + _rotate));
    }

    physics_fixture_bind(_fixture, self);
    
    range = _range;
    angle = _angle;
    rotate = _rotate;
    
    return _fixture;
}

/*
var _flag = phy_debug_render_aabb | phy_debug_render_collision_pairs | phy_debug_render_coms | phy_debug_render_core_shapes | phy_debug_render_joints | phy_debug_render_obb | phy_debug_render_shapes;
physics_world_draw_debug(_flag);

repeat(irandom_range(range/400, range/100))
{
	var i = random(360);
	var _dis = random(room_width/8*3-128);
	var _x = room_width/2+lengthdir_x(_dis, i);
	var _y = room_height/2+lengthdir_y(_dis, i);
		
	with(instance_create_depth(_x,_y,10, choose(Wall_01)))
	{
		phy_rotation = random(360);
		phy_fixed_rotation = false;	
	}
}
*/