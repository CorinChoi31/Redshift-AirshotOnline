if(projectile.collied) {
    part_emitter_region(global.particle_system, particle_emitter, x - 4, x + 4, y - 4, y + 4, ps_shape_ellipse, ps_distr_linear);
    if(game.client.player == projectile.player) {
        part_emitter_burst(global.particle_system, particle_emitter, 
            global.particle[? "Projectile.Bullet.Hit.Self"], 24);
    }
    else {
        part_emitter_burst(global.particle_system, particle_emitter, 
            global.particle[? "Projectile.Bullet.Hit.Enemy"], 24);
    }
}

part_emitter_destroy(global.particle_system, particle_emitter);