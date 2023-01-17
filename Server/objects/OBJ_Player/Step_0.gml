var _delta_time = global.__time;

if(unit.player == -1) {
    input = new Input(
        mouse_x, mouse_y,
        keyboard_check(ord("W")), keyboard_check(ord("A")), keyboard_check(ord("S")), keyboard_check(ord("D")),
        mouse_check_button(mb_left),
        keyboard_check(ord("R"))
    );
}

var _input = input;

var _move_vectical = - _input.move_up + _input.move_down;
var _move_horizental = - _input.move_left + _input.move_right;
var _move = !((_move_vectical == 0) && (_move_horizental == 0));

var _mouse_x = _input.mo_x;
var _mouse_y = _input.mo_y;

var _fire = _input.fire;
var _fire_direction = point_direction(x, y, _mouse_x, _mouse_y);

var _reload = _input.reload;


if(unit.dead) {
    if(unit.frame.durability < 0) {
        unit.frame.durability = 0;
    }
    
    unit.engine.moveable = false;
    unit.weapon.fireable = false;
    
    if(unit.respawn > 0) {
        unit.respawn -= _delta_time;
    }
    else {
        unit.frame.durability = unit.frame.durability_max;
        
        unit.engine.moveable = true;
        unit.weapon.fireable = true;
        unit.dead = false;
    }
}
else {
    if(unit.frame.durability <= 0) {
        unit.frame.durability = 0;
        
        unit.dead = true;
        unit.respawn = 4;
    }
}

if(unit.weapon.magazine.reload) {
    if(unit.weapon.magazine.reload_time <= 0) {
        if(unit.weapon.magazine.reload_amount != -1) {
            unit.weapon.magazine.amount += min(unit.weapon.magazine.amount_max, unit.weapon.magazine.amount + unit.weapon.magazine.reload_amount);
            if(unit.weapon.magazine.amount == unit.weapon.magazine.amount_max) {
                unit.weapon.magazine.reload = false;
            }
        }
        else {
            unit.weapon.magazine.amount = min(unit.weapon.magazine.amount_max, unit.weapon.magazine.amount + unit.weapon.magazine.amount_max);
            unit.weapon.magazine.reload = false;
        }
        unit.weapon.magazine.reload_time += unit.weapon.magazine.reload_time_max;
    }
    else {
        unit.weapon.magazine.reload_time -= _delta_time;
    }
}
else {
    if(unit.weapon.magazine.amount <= 0) {
        unit.weapon.magazine.reload = true;
        unit.weapon.magazine.reload_time = unit.weapon.magazine.reload_time_max;
    }
}


if(_move != 0 && unit.engine.moveable) {
    unit.engine.linear_speed = min(unit.engine.linear_speed + unit.engine.linear_accel * _delta_time, unit.engine.linear_speed_max);
            
    var _move_direction = point_direction(0, 0, _move_horizental, _move_vectical);
    var _difference = angle_difference(_move_direction, unit.engine.angular_direction);
    var _difference_sign = sign(_difference);
    
    unit.engine.angular_direction += median(0, abs(_difference) * 0.1, unit.engine.angular_speed_max) * _difference_sign;
}
else {
    unit.engine.linear_speed = max(0, unit.engine.linear_speed - unit.engine.linear_accel * _delta_time);
}

unit.x += lengthdir_x(unit.engine.linear_speed, unit.engine.angular_direction);
unit.y += lengthdir_y(unit.engine.linear_speed, unit.engine.angular_direction);

x = unit.x;
y = unit.y;

if(unit.weapon.fireable) {
    if(_reload) {
        if(unit.weapon.magazine.amount < unit.weapon.magazine.amount_max) {
            unit.weapon.magazine.reload = true;
        }
    }
    
    if(_fire) {
        if(unit.weapon.magazine.reload) {
            if(unit.weapon.magazine.amount > 0) {
                unit.weapon.magazine.reload = false;
                unit.weapon.magazine.reload_time = 0;
            }
        }
        else {
            if(unit.weapon.cool <= 0) {
                unit.weapon.cool += unit.weapon.cool_max;
                unit.weapon.period = unit.weapon.period_max;
            }
        }
    }
    
    if(unit.weapon.period > 0) {
        if(unit.weapon.interval <= 0) {
            unit.weapon.interval += unit.weapon.interval_max;
            unit.weapon.period -= 1;
            repeat(min(unit.weapon.amount)) {
                
                var _instance = instance_create_layer(x, y, "Game", unit.weapon.projectile.object);
                    _instance.game = game;
                    _instance.projectile = new Projectiles(
                        object_get_name(unit.weapon.projectile.object),
                        unit.player,
                        game.projectile_id++,
                        x, y,
                        unit.weapon.projectile.damage,
                        unit.weapon.projectile.duration,
                        unit.weapon.projectile.duration,
                        unit.weapon.projectile.linear_speed,
                        point_direction(x, y, _mouse_x, _mouse_y) + random_range(-unit.weapon.angle, unit.weapon.angle) * 0.5,
                        unit.weapon.projectile.particle
                    );
                    array_push(game.projectile_list, _instance);
                
                unit.weapon.magazine.amount -= 1;
                if(unit.weapon.magazine.amount <= 0) {
                    unit.weapon.period = 0;
                    unit.weapon.interval = 0;
                    break;
                }
            }
        }
        else {
            unit.weapon.interval -= _delta_time;
        }
    }
    else {
        if(unit.weapon.cool > 0) {
            unit.weapon.cool -= _delta_time;
        }
    }
}