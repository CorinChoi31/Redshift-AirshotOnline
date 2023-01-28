var _delta_time = global.__time;

if(projectile.force.duration > 0) {
    var _i = 0;

    var _pdis = point_distance(projectile.x, projectile.y, phy_position_x, phy_position_y);
    var _pdir = point_direction(projectile.x, projectile.y, phy_position_x, phy_position_y);
    var _x = 0;
    var _y = 0;
    var _length = 4;
    var _size = max(round(_pdis/_length)*_length, 1);

    var _collision = [];

    for(var i = 0; i < _size; i += _length) {
        _x = projectile.x + lengthdir_x(i, _pdir);
    	_y = projectile.y + lengthdir_y(i, _pdir);
        with(OBJ_Plane) {
            if(!plane.destroyed) {
                if(plane.frame.collide_able) {
                    if(plane.player_index != other.projectile.player_index) {
                        if(point_in_circle(plane.x, plane.y, _x, _y, plane.frame.collide_size + other.projectile.collide_size)) {
                            if(!array_any(_collision, function(_value, _index) {
                                    return _value == id;
                                })
                            ) {
                                array_push(_collision, id);
                                break;
                            }
                        }
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
        projectile.collided = true;
        projectile.force.duration = 0;
        
        phy_speed_x = 0;
        phy_speed_y = 0;
        
        _i = 0;
        repeat(_collied) {
            array_push(_collision[_i].plane.damages, new Damage(projectile.player_index, GAME_DAMAGE.PHYSICAL, -projectile.onhit.damage));
            _i += 1;
        }
    }

    projectile.x = phy_position_x;
    projectile.y = phy_position_y;
}