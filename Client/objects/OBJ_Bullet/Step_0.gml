var _delta_time = global.__time;

if(projectile.collided) {
    if(!collided) {
        collided = true;
        part_emitter_region(global.particle_system, particle_emitter, 
            projectile.x - projectile.collide_size_max, projectile.x + projectile.collide_size_max, 
            projectile.y - projectile.collide_size_max, projectile.y + projectile.collide_size_max, 
            ps_shape_ellipse, ps_distr_linear
        );
        if(projectile.player_index == game.client.player) {
            part_emitter_burst(global.particle_system, particle_emitter, 
                global.particle[? "Projectile.Bullet.Hit.Self"], projectile.collide_size_max * 2);
        }
        else {
            part_emitter_burst(global.particle_system, particle_emitter, 
                global.particle[? "Projectile.Bullet.Hit.Enemy"], projectile.collide_size_max * 2);
        }
    }
}
else {
    if(projectile.force.duration > 0) {
        var _i = 0;

        var _pdis = point_distance(x_previous, y_previous, phy_position_x, phy_position_y);
        var _pdir = point_direction(x_previous, y_previous, phy_position_x, phy_position_y);
        var _x = 0;
        var _y = 0;
        var _length = 4;
        var _size = max(round(_pdis/_length)*_length, 1);

        for(var i = 0; i < _size; i += _length) {
            _x = x_previous + lengthdir_x(i, _pdir);
        	_y = y_previous + lengthdir_y(i, _pdir);
        
            part_emitter_region(global.particle_system, particle_emitter, _x, _x, _y, _y, ps_shape_ellipse, ps_distr_linear);
            if(projectile.player_index == game.client.player) {
                part_emitter_burst(global.particle_system, particle_emitter, 
                    global.particle[? "Projectile.Bullet.Trail.Self"], 1);
            }
            else {
                part_emitter_burst(global.particle_system, particle_emitter, 
                    global.particle[? "Projectile.Bullet.Trail.Enemy"], 1);
            }
        }
        x_previous = phy_position_x;
        y_previous = phy_position_y;
        
        phy_position_x = lerp(phy_position_x, projectile.x, 0.9);
        phy_position_y = lerp(phy_position_y, projectile.y, 0.9);
        
        projectile.x += lengthdir_x(projectile.force.linear_speed, projectile.force.angular_direction);
        projectile.y += lengthdir_y(projectile.force.linear_speed, projectile.force.angular_direction);
    }
}