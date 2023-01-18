if(projectile.duration > 0) {
    var _i = 0;
    
    projectile.x += lengthdir_x(projectile.speed, projectile.direction);
    projectile.y += lengthdir_y(projectile.speed, projectile.direction);

    var _pdis = point_distance(x, y, projectile.x, projectile.y);
    var _pdir = point_direction(x, y, projectile.x, projectile.y);
    var _x = 0;
    var _y = 0;
    var _length = 4;
    var _size = max(round(_pdis/_length)*_length, 1);

    var _collision = [];

    for(var i = 0; i < _size; i += _length) {
        _x = x + lengthdir_x(i, _pdir);
    	_y = y + lengthdir_y(i, _pdir);
        
        part_emitter_region(global.particle_system, particle_emitter, _x, _x, _y, _y, ps_shape_ellipse, ps_distr_linear);
        if(game.client.player == other.projectile.player) {
            part_emitter_burst(global.particle_system, particle_emitter, 
                global.particle[? "Projectile.Bullet.Trail.Self"], 1);
        }
        else {
            part_emitter_burst(global.particle_system, particle_emitter, 
                global.particle[? "Projectile.Bullet.Trail.Enemy"], 1);
        }
        
        with(OBJ_Player) {
            if(unit.player != other.projectile.player and !unit.dead) {
                if(point_in_circle(x, y, other.x, other.y, 32)) {
                    if(!array_any(_collision, function(_value, _index) {
                            return _value == self.id;
                        })
                    ) {
                        array_push(_collision, self.id);
                        break;
                    }
                }
            }
        }
        if(array_length(_collision) > 0) {
            break;
        }
    }
    
    var _collied = array_length(_collision);
    if(_collied > 0) {
        projectile.duration = 0;
        projectile.collied = true;
    }

    x = projectile.x;
    y = projectile.y;
}