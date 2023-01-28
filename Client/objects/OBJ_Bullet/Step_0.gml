var _delta_time = global.__time;

if(projectile.collided) {
    if(!collided) {
        collided = true;
        part_emitter_region(global.particle_system, particle_emitter, 
            phy_position_x - projectile.collide_size_max, phy_position_x + projectile.collide_size_max, 
            phy_position_y - projectile.collide_size_max, phy_position_y + projectile.collide_size_max, 
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

        var _pdis = point_distance(phy_position_x, phy_position_y, projectile.x, projectile.y);
        var _pdir = point_direction(phy_position_x, phy_position_y, projectile.x, projectile.y);
        var _x = 0;
        var _y = 0;
        var _length = 4;
        var _size = max(round(_pdis/_length)*_length, 1);

        for(var i = 0; i < _size; i += _length) {
            _x = projectile.x + lengthdir_x(i, _pdir);
        	_y = projectile.y + lengthdir_y(i, _pdir);
        
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
        phy_position_x = projectile.x;
        phy_position_y = projectile.y;
    }
}