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
        with(OBJ_Player) {
            if(unit.player != other.projectile.player and point_in_circle(x, y, other.x, other.y, 24)) {
                if(!array_any(_collision, function(_value, _index) {
                        return _value == self.id;
                    })
                ) {
                    array_push(_collision, self.id);
                    break;
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
        
        _i = 0;
        repeat(_collied) {
            _collision[_i].unit.frame.durability -= projectile.damage;
            _i += 1;
        }
    }

    x = projectile.x;
    y = projectile.y;
}