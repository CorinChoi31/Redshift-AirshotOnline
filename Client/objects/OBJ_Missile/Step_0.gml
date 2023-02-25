var _delta_time = global.__time;

if(projectile.collided) {
    if(!collided) {
        collided = true;
        part_emitter_region(global.particle_system, particle_emitter, 
            projectile.x - projectile.collide_size_max, projectile.x + projectile.collide_size_max, 
            projectile.y - projectile.collide_size_max, projectile.y + projectile.collide_size_max, 
            ps_shape_ellipse, ps_distr_invgaussian
        );
        if(projectile.player_index == game.client.player) {
            part_emitter_burst(global.particle_system, particle_emitter, 
                global.particle[? "Projectile.Missile.Hit.Self"], projectile.collide_size_max * 2);
        }
        else {
            part_emitter_burst(global.particle_system, particle_emitter, 
                global.particle[? "Projectile.Missile.Hit.Enemy"], projectile.collide_size_max * 2);
        }
    }
}
else {
    if(projectile.force.duration > 0) {
        var _i = 0;
    
        projectile.force.linear_speed = min(projectile.force.linear_speed + projectile.force.linear_speed_accel * _delta_time, projectile.force.linear_speed_max);
        
        phy_speed_x = lerp(phy_speed_x, lengthdir_x(projectile.force.linear_speed, projectile.force.angular_direction), 0.1);
        phy_speed_y = lerp(phy_speed_y, lengthdir_y(projectile.force.linear_speed, projectile.force.angular_direction), 0.1);
    
        phy_position_x = lerp(phy_position_x, projectile.x, 0.9);
        phy_position_y = lerp(phy_position_y, projectile.y, 0.9);
        
        part_emitter_region(global.particle_system, particle_emitter, 
            _x - projectile.collide_size, _x + projectile.collide_size, _y - projectile.collide_size, _y + projectile.collide_size, 
            ps_shape_ellipse, ps_distr_linear
        );
        if(projectile.player_index == game.client.player) {
            part_emitter_burst(global.particle_system, particle_emitter, 
                global.particle[? "Projectile.Missile.Trail.Self"], ceil(projectile.force.linear_speed/10));
        }
        else {
            part_emitter_burst(global.particle_system, particle_emitter, 
                global.particle[? "Projectile.Missile.Trail.Enemy"], ceil(projectile.force.linear_speed/10));
        }
    }
}