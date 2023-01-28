randomize();

network_set_config(network_config_connect_timeout, 5000);
network_set_config(network_config_use_non_blocking_socket, true);

#region
var _particle = undefined;
global.particle_system = part_system_create();
part_system_depth(global.particle_system, layer_get_depth("GameEffect"));

global.particle = ds_map_create();

global.particle[? "Plane.Move.Trail.Self"] = part_type_create();
    _particle = global.particle[? "Plane.Move.Trail.Self"];
    part_type_shape(_particle, pt_shape_square);
    part_type_size(_particle, 0.05, 0.35, -0.0025, 0);
    part_type_scale(_particle, 1, 1);
    part_type_orientation(_particle, 0, 360, 0, 0, true);
    part_type_color3(_particle, c_blue, c_aqua, c_white);
    part_type_alpha3(_particle, 0, 1, 0);
    part_type_blend(_particle, true);
    part_type_speed(_particle, 0, 0, -0.0375, 0);
    part_type_direction(_particle, 0, 0, 0, 0);
    part_type_life(_particle, global.__frame * 0.2, global.__frame * 1);

global.particle[? "Plane.Move.Trail.Enemy"] = part_type_create();
    _particle = global.particle[? "Plane.Move.Trail.Enemy"];
    part_type_shape(_particle, pt_shape_square);
    part_type_size(_particle, 0.05, 0.35, -0.0025, 0);
    part_type_scale(_particle, 1, 1);
    part_type_orientation(_particle, 0, 360, 0, 0, true);
    part_type_color3(_particle, c_red, c_orange, c_white);
    part_type_alpha3(_particle, 0, 1, 0);
    part_type_blend(_particle, true);
    part_type_speed(_particle, 0, 0, -0.0375, 0);
    part_type_direction(_particle, 0, 0, 0, 0);
    part_type_life(_particle, global.__frame * 0.2, global.__frame * 1);
    
global.particle[? "Plane.Move.Dead.Self"] = part_type_create();
    _particle = global.particle[? "Plane.Move.Dead.Self"];
    part_type_shape(_particle, pt_shape_square);
    part_type_size(_particle, 0.1, 0.5, -0.01, 0);
    part_type_scale(_particle, 1, 1);
    part_type_orientation(_particle, 0, 0, 0, 0, true);
    part_type_color3(_particle, c_red, c_blue, c_aqua);
    part_type_alpha3(_particle, 1, 0.5, 0);
    part_type_blend(_particle, true);
    part_type_speed(_particle, 0, 5, -0.1, 0);
    part_type_direction(_particle, 0, 360, 0, 0);
    part_type_life(_particle, global.__frame * 1, global.__frame * 5);

global.particle[? "Plane.Move.Dead.Enemy"] = part_type_create();
    _particle = global.particle[? "Plane.Move.Dead.Enemy"];
    part_type_shape(_particle, pt_shape_square);
    part_type_size(_particle, 0.1, 0.5, -0.01, 0);
    part_type_scale(_particle, 1, 1);
    part_type_orientation(_particle, 0, 0, 0, 0, true);
    part_type_color3(_particle, c_blue, c_red, c_orange);
    part_type_alpha3(_particle, 1, 0.5, 0);
    part_type_blend(_particle, true);
    part_type_speed(_particle, 0, 5, -0.1, 0);
    part_type_direction(_particle, 0, 360, 0, 0);
    part_type_life(_particle, global.__frame * 1, global.__frame * 5);
    
    
global.particle[? "Projectile.Bullet.Trail.Self"] = part_type_create();
    _particle = global.particle[? "Projectile.Bullet.Trail.Self"];
    part_type_shape(_particle, pt_shape_square);
	part_type_size(_particle, 0.05, 0.05, 0, 0);
	part_type_scale(_particle, 1, 1);
	part_type_color3(_particle, c_blue, c_aqua, c_red);
	part_type_alpha3(_particle, 1, 1, 0);
	part_type_blend(_particle, true);
	part_type_speed(_particle, 0, 0, 0, 0);
	part_type_direction(_particle, 0, 360, 0, 0);
	part_type_orientation(_particle, 0, 360, 0, 0, true);
	part_type_life(_particle, global.__frame/10, global.__frame/10);

global.particle[? "Projectile.Bullet.Trail.Enemy"] = part_type_create();
    _particle = global.particle[? "Projectile.Bullet.Trail.Enemy"];
    part_type_shape(_particle, pt_shape_square);
	part_type_size(_particle, 0.05, 0.05, 0, 0);
	part_type_scale(_particle, 1, 1);
	part_type_color3(_particle, c_red, c_orange, c_blue);
	part_type_alpha3(_particle, 1, 1, 0);
	part_type_blend(_particle, true);
	part_type_speed(_particle, 0, 0, 0, 0);
	part_type_direction(_particle, 0, 360, 0, 0);
	part_type_orientation(_particle, 0, 360, 0, 0, true);
	part_type_life(_particle, global.__frame * 0.1, global.__frame * 0.1);

global.particle[? "Projectile.Bullet.Hit.Self"] = part_type_create();
    _particle = global.particle[? "Projectile.Bullet.Hit.Self"];
    part_type_shape(_particle, pt_shape_square);
	part_type_size(_particle, 0.05, 0.15, -0.001, 0);
	part_type_scale(_particle, 1, 1);
	part_type_color3(_particle, c_blue, c_aqua, c_red);
	part_type_alpha3(_particle, 1, 0.25,0);
	part_type_blend(_particle, true);
	part_type_speed(_particle, 0, 1, 0, 0);
	part_type_direction(_particle, 0, 360, 0, 0);
	part_type_orientation(_particle, 0, 360, 0, 0, true);
	part_type_life(_particle, global.__frame * 0.5, global.__frame * 4);

global.particle[? "Projectile.Bullet.Hit.Enemy"] = part_type_create();
    _particle = global.particle[? "Projectile.Bullet.Hit.Enemy"];
    part_type_shape(_particle, pt_shape_square);
	part_type_size(_particle, 0.05, 0.15, -0.001, 0);
	part_type_scale(_particle, 1, 1);
	part_type_color3(_particle, c_red, c_orange, c_blue);
	part_type_alpha3(_particle, 1, 0.25,0);
	part_type_blend(_particle, true);
	part_type_speed(_particle, 0, 1, 0, 0);
	part_type_direction(_particle, 0, 360, 0, 0);
	part_type_orientation(_particle, 0, 360, 0, 0, true);
	part_type_life(_particle, global.__frame * 0.5, global.__frame * 4);
    
  

global.particle[? "Projectile.Missile.Trail.Self"] = part_type_create();
	_particle = global.particle[? "Projectile.Missile.Trail.Self"];
    part_type_shape(_particle, pt_shape_square);
	part_type_size(_particle, 0.05, 0.125, -0.001, 0);
	part_type_scale(_particle, 1, 1);
	part_type_color3(_particle, c_navy, c_blue, c_aqua);
	part_type_alpha3(_particle, 1, 1, 0);
	part_type_blend(_particle, true);
	part_type_speed(_particle, 0, 0, 0, 0);
	part_type_direction(_particle, 0, 360, 0, 0);
	part_type_orientation(_particle, 0, 360, 0, 0, true);
	part_type_life(_particle, global.__frame * 0.01, global.__frame * 0.5);
    
global.particle[? "Projectile.Missile.Trail.Enemy"] = part_type_create();
	_particle = global.particle[? "Projectile.Missile.Trail.Enemy"];
    part_type_shape(_particle, pt_shape_square);
	part_type_size(_particle, 0.05, 0.125, -0.001, 0);
	part_type_scale(_particle, 1, 1);
	part_type_color3(_particle, c_maroon, c_red, c_orange);
	part_type_alpha3(_particle, 1, 1, 0);
	part_type_blend(_particle, true);
	part_type_speed(_particle, 0, 0, 0, 0);
	part_type_direction(_particle, 0, 360, 0, 0);
	part_type_orientation(_particle, 0, 360, 0, 0, true);
	part_type_life(_particle, global.__frame * 0.01, global.__frame * 0.5);

global.particle[? "Projectile.Missile.Hit.Self"] = part_type_create();
	_particle = global.particle[? "Projectile.Missile.Hit.Self"];
    part_type_shape(_particle, pt_shape_square);
	part_type_size(_particle, 0.1, 0.3, -0.001, 0);
	part_type_scale(_particle, 1, 1);
	part_type_color3(_particle, c_navy, c_blue, c_aqua);
	part_type_alpha3(_particle, 1, 1, 0);
	part_type_blend(_particle, true);
	part_type_speed(_particle, 0, 5, -0.1, 0);
	part_type_direction(_particle, 0, 360, 0, 0);
	part_type_orientation(_particle, 0, 360, 0, 0, true);
	part_type_life(_particle, global.__frame * 0.5, global.__frame * 2.5);
    
global.particle[? "Projectile.Missile.Hit.Enemy"] = part_type_create();
	_particle = global.particle[? "Projectile.Missile.Hit.Enemy"];
    part_type_shape(_particle, pt_shape_square);
	part_type_size(_particle, 0.1, 0.3, -0.001, 0);
	part_type_scale(_particle, 1, 1);
	part_type_color3(_particle, c_maroon, c_red, c_orange);
	part_type_alpha3(_particle, 1, 1, 0);
	part_type_blend(_particle, true);
	part_type_speed(_particle, 0, 5, -0.1, 0);
	part_type_direction(_particle, 0, 360, 0, 0);
	part_type_orientation(_particle, 0, 360, 0, 0, true);
	part_type_life(_particle, global.__frame * 0.5, global.__frame * 2.5);


#endregion

room_goto(ROM_Main);