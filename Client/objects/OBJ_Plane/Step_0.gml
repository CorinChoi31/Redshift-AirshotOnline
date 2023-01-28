var _delta_time = global.__time;
var _i = 0;

#region Effect
plane_effect.Clear();

_i = 0;
var _effect;
repeat(array_length(plane.effects)) {
    _effect = plane.effects[_i];
    
    if(!_effect.infinite) {
        if(_effect.duration < 0) {
            _effect.index = GAME_EFFECT.NONE;
        }
    }
    _effect.duration -= _delta_time;
    
    switch(_effect.index) {
        default:
        case GAME_EFFECT.NONE:
            array_delete(plane.effects, _i, 1);
            _i -= 1;
            break;
        case GAME_EFFECT.REPAIR_AUTO:
            if(_effect.duration < 0) {
                _effect.duration += _effect.duration_init;
                
                plane.frame.durability += _effect.amount;
            }
            break;
    }
    _i += 1;
}

    #region
    plane.frame.collide_able = plane_init.frame.collide_able && plane_effect.frame.collide_able;
    plane.frame.collide_size = max(plane_init.frame.collide_size + plane_effect.frame.collide_size, 4);

    plane.frame.damage_able = plane_init.frame.damage_able + plane_effect.frame.damage_able;
    plane.frame.damage_ratio = max(plane_init.frame.damage_ratio + plane_effect.frame.damage_ratio, 0);

    plane.frame.durability_max = max(plane_init.frame.durability_max + plane_effect.frame.durability_max, 1);
    plane.frame.durability_loss = max(plane_init.frame.durability_loss + plane_effect.frame.durability_loss, 0);
    plane.frame.durability_fix = max(plane_init.frame.durability_fix + plane_effect.frame.durability_fix, 0);
    #endregion

    #region
    plane.engine.move_able = plane_init.engine.move_able && plane_effect.engine.move_able;
    
    plane.engine.linear_speed_max = max(plane_init.engine.linear_speed_max + plane_effect.engine.linear_speed_max, 0);
    plane.engine.linear_speed_accel = max(plane_init.engine.linear_speed_accel + plane_effect.engine.linear_speed_accel, 0);
    
    plane.engine.angular_speed_ratio = plane_init.engine.angular_speed_ratio + plane_effect.engine.angular_speed_ratio;
    plane.engine.angular_speed_limit = plane_init.engine.angular_speed_limit + plane_effect.engine.angular_speed_limit;
    #endregion
    
    #region
    plane.weapon.fire_able = plane_init.weapon.fire_able && plane_effect.weapon.fire_able;
    
    plane.weapon.damage_ratio = max(plane_init.weapon.damage_ratio + plane_effect.weapon.damage_ratio, 0);
    
    plane.weapon.cool_max = max(plane_init.weapon.cool_max + plane_effect.weapon.cool_max, 0);
    plane.weapon.amount = max(plane_init.weapon.amount + plane_effect.weapon.amount, 1);
    plane.weapon.period_max = max(plane_init.weapon.period_max + plane_effect.weapon.period_max, 1);
    plane.weapon.interval_max = plane_init.weapon.interval_max + plane_effect.weapon.interval_max;
    plane.weapon.dispersion_linear = min(12, plane_init.weapon.dispersion_linear + plane_effect.weapon.dispersion_linear);
    plane.weapon.dispersion_angular = plane_init.weapon.dispersion_angular + plane_effect.weapon.dispersion_angular;
        
        #region
        plane.weapon.projectile.collide_size = plane_init.weapon.projectile.collide_size + plane_effect.weapon.projectile.collide_size;
        plane.weapon.projectile.collide_size_max = plane_init.weapon.projectile.collide_size_max + plane_effect.weapon.projectile.collide_size_max;
            #region
            plane.weapon.projectile.onhit.damage = plane_init.weapon.projectile.onhit.damage + plane_effect.weapon.projectile.onhit.damage;
            #endregion
            
            #region
            plane.weapon.projectile.force.duration_max = plane_init.weapon.projectile.force.duration_max + plane_effect.weapon.projectile.force.duration_max;
            
            plane.weapon.projectile.force.linear_speed = max(plane_init.weapon.projectile.force.linear_speed + plane_effect.weapon.projectile.force.linear_speed, 0);
            plane.weapon.projectile.force.linear_speed_max = max(plane_init.weapon.projectile.force.linear_speed_max + plane_effect.weapon.projectile.force.linear_speed_max, 0);
            plane.weapon.projectile.force.linear_speed_accel = max(plane_init.weapon.projectile.force.linear_speed_accel + plane_effect.weapon.projectile.force.linear_speed_accel, 0);
            
            plane.weapon.projectile.force.angular_speed_ratio = plane_init.weapon.projectile.force.angular_speed_ratio + plane_effect.weapon.projectile.force.angular_speed_ratio;
            plane.weapon.projectile.force.angular_speed_limit = plane_init.weapon.projectile.force.angular_speed_limit + plane_effect.weapon.projectile.force.angular_speed_limit;
            #endregion
        #endregion
        
        #region
        plane.weapon.magazine.amount_max = max(plane_init.weapon.magazine.amount_max + plane_effect.weapon.magazine.amount_max, 1);
            #region
            plane.weapon.magazine.reload.reload_able = plane_init.weapon.magazine.reload.reload_able && plane_effect.weapon.magazine.reload.reload_able;
            
            if(plane_init.weapon.magazine.reload.amount == -1) {
                plane.weapon.magazine.reload.amount = -1;
            }
            else {
                plane.weapon.magazine.reload.amount = plane_init.weapon.magazine.reload.amount + plane_effect.weapon.magazine.reload.amount;
            }
            plane.weapon.magazine.reload.cool_max = max(plane_init.weapon.magazine.reload.cool_max + plane_effect.weapon.magazine.reload.cool_max, 0);
            #endregion
        #endregion
    #endregion
    
    #region
    plane.passive.use_able = plane_init.passive.use_able && plane_effect.passive.use_able;
    #endregion
    
    #region
    plane.active.use_able = plane_init.active.use_able && plane_effect.active.use_able;
    
    plane.active.cool_max = max(plane_init.active.cool_max + plane_effect.active.cool_max, 0);
    #endregion
#endregion

#region Damage
var _damage;
repeat(array_length(plane.damages)) {
    _damage = plane.damages[0];
    
    switch(_damage.index) {
        default:
            break;
        case GAME_DAMAGE.TRUE:
            if(plane.frame.damage_able) {
                plane.frame.durability += _damage.amount;
            }
            break;
        case GAME_DAMAGE.PHYSICAL:
            if(plane.frame.damage_able) {
                plane.frame.durability += _damage.amount * plane.frame.damage_ratio;
            }
            break;
    }
    array_delete(plane.damages, 0, 1);
}

plane.frame.durability = median(0, plane.frame.durability, plane.frame.durability_max);
#endregion

#region Stat
if(plane.destroyed) {
    
}
else {
    if(plane.frame.durability <= 0) {
        plane.destroyed = true;
        
        repeat(array_length(plane.effects)) {
            array_delete(plane.effects, 0, 1);
        }
        repeat(array_length(plane.damages)) {
            array_delete(plane.damages, 0, 1);
        }
        
        part_emitter_region(global.particle_system, particle_emitter, x, x, y, y, ps_shape_ellipse, ps_distr_invgaussian);
        if(plane.player_index == game.client.player) {
            part_emitter_burst(global.particle_system, particle_emitter, 
                global.particle[? "Plane.Move.Dead.Self"], 200
            );
        }
        else {
            part_emitter_burst(global.particle_system, particle_emitter, 
                global.particle[? "Plane.Move.Dead.Enemy"], 200
            );
        }
    }
    else {
        #region Auto Repair
        _i = (plane.frame.durability - plane.frame.durability_recover);
        if(_i >= 0) {
            plane.frame.durability_recover = plane.frame.durability;
        }
        else {
            plane.frame.durability_recover += -min(abs(_i) * 0.1, plane.frame.durability_loss * _delta_time);
        }
        
        if(plane.frame.durability_recover != plane.frame.durability) {
            array_push(
                plane.effects,
                new Effect(plane.player_index, GAME_EFFECT.REPAIR_INSTANT, plane.frame.durability_fix * _delta_time, 0, false)
            );
        }
        #endregion
        #region Reload
        if(plane.weapon.magazine.reload.reload_able) {
            if(plane.weapon.magazine.reload.reload_ing) {
                if(plane.weapon.magazine.reload.cool <= 0) {
                    if(plane.weapon.magazine.reload.amount != -1) {
                        plane.weapon.magazine.amount = plane.weapon.magazine.amount + plane.weapon.magazine.reload.amount;
                        if(plane.weapon.magazine.amount >= plane.weapon.magazine.amount_max) {
                            plane.weapon.magazine.reload.reload_ing = false;
                            plane.weapon.magazine.amount = plane.weapon.magazine.amount_max;
                        }
                        else {
                            plane.weapon.magazine.reload.cool += plane.weapon.magazine.reload.cool_max;
                        }
                    }
                    else {
                        plane.weapon.magazine.amount = plane.weapon.magazine.amount_max;
                        plane.weapon.magazine.reload.reload_ing = false;
                    }
                }
                else {
                    plane.weapon.magazine.reload.cool -= _delta_time;
                }
            }
            else {
                if(plane.weapon.magazine.amount <= 0) {
                    plane.weapon.magazine.reload.reload_ing = true;
                    plane.weapon.magazine.reload.cool = plane.weapon.magazine.reload.cool_max;
                }
            }
        }
        else {
            plane.weapon.magazine.reload.reload_ing = false;
            plane.weapon.magazine.reload.cool = 0;
        }
        #endregion
        #region User Input
        if(plane.player_index == -1) {
            user_input = new UserInput(
                mouse_x, mouse_y,
                keyboard_check(ord("W")), keyboard_check(ord("A")), keyboard_check(ord("S")), keyboard_check(ord("D")),
                mouse_check_button(mb_left),
                keyboard_check(ord("R")), keyboard_check(vk_space)
            );
        }
        
        var _input = user_input;

        var _move_vectical = - _input.up + _input.down;
        var _move_horizental = - _input.left + _input.right;
        var _move = !((_move_vectical == 0) && (_move_horizental == 0));

        var _mouse_x = _input.x;
        var _mouse_y = _input.y;

        var _fire = _input.fire;
        var _fire_direction = point_direction(x, y, _mouse_x, _mouse_y);

        var _reload = _input.reload;
        
        var _skill = _input.skill;
        
        // Move
        if(_move != 0 && plane.engine.move_able) {
            var _move_direction = point_direction(0, 0, _move_horizental, _move_vectical);
            var _difference = angle_difference(_move_direction, plane.engine.angular_direction);
            var _difference_sign = sign(_difference);
            
            plane.engine.linear_speed = min(plane.engine.linear_speed + plane.engine.linear_speed_accel * _delta_time, plane.engine.linear_speed_max);
            plane.engine.angular_direction += median(0, abs(_difference) * plane.engine.angular_speed_ratio, plane.engine.angular_speed_limit * _delta_time) * _difference_sign;
            
            phy_speed_x = lerp(phy_speed_x, lengthdir_x(plane.engine.linear_speed, plane.engine.angular_direction), 0.1);
            phy_speed_y = lerp(phy_speed_y, lengthdir_y(plane.engine.linear_speed, plane.engine.angular_direction), 0.1);
            
            plane.x += phy_speed_x;
            plane.y += phy_speed_y;
        }
        else {
            plane.engine.linear_speed = max(0, plane.engine.linear_speed - plane.engine.linear_speed_accel * _delta_time);
        }
        phy_position_x = plane.x;
        phy_position_y = plane.y;
        
        if(plane.engine.linear_speed > 0) {
            
            part_emitter_region(global.particle_system, particle_emitter, 
                plane.x - plane.frame.collide_size, plane.x + plane.frame.collide_size, 
                plane.y - plane.frame.collide_size, plane.y + plane.frame.collide_size,
                ps_shape_ellipse, ps_distr_linear
            );
            if(plane.player_index == game.client.player) {
                part_emitter_burst(global.particle_system, particle_emitter, 
                    global.particle[? "Plane.Move.Trail.Self"], ceil(plane.engine.linear_speed));
            }
            else {
                part_emitter_burst(global.particle_system, particle_emitter, 
                    global.particle[? "Plane.Move.Trail.Enemy"], ceil(plane.engine.linear_speed));
            }
        }
        
        // Fire
        if(plane.weapon.fire_able) {
            if(_reload) {
                if(plane.weapon.magazine.amount < plane.weapon.magazine.amount_max) {
                    if(plane.weapon.magazine.reload.reload_able) {
                        if(!plane.weapon.magazine.reload.reload_ing) {
                            plane.weapon.magazine.reload.reload_ing = true;
                            plane.weapon.magazine.reload.cool = plane.weapon.magazine.reload.cool_max;
                        }
                    }
                }
            }
            if(_fire) {
                if(plane.weapon.magazine.reload.reload_ing) {
                    if(plane.weapon.magazine.amount > 0) {
                        if(plane.weapon.magazine.reload.amount != -1) {
                            plane.weapon.magazine.reload.reload_ing = false;
                            plane.weapon.magazine.reload.cool = 0;
                        }
                    }
                }
                else {
                    if(plane.weapon.cool <= 0) {
                        plane.weapon.cool += plane.weapon.cool_max;
                        plane.weapon.period = plane.weapon.period_max;
                    }
                }
            }
    
            if(plane.weapon.period > 0) {
                if(plane.weapon.interval <= 0) {
                    plane.weapon.interval += plane.weapon.interval_max;
                    plane.weapon.period -= 1;
                    
                    repeat(min(plane.weapon.amount)) {
                        plane.weapon.dispersion_index = (plane.weapon.dispersion_index + 1) % plane.weapon.amount;
                        plane.weapon.magazine.amount -= 1;
                        if(plane.weapon.magazine.amount <= 0) {
                            plane.weapon.period = 0;
                            plane.weapon.interval = 0;
                            break;
                        }
                    }
                }
                else {
                    plane.weapon.interval -= _delta_time;
                }
            }
            else {
                if(plane.weapon.cool > 0) {
                    plane.weapon.cool -= _delta_time;
                }
            }
        }
        else {
            plane.weapon.period = 0;
            plane.weapon.interval = 0;
            
            if(plane.weapon.cool > 0) {
                plane.weapon.cool -= _delta_time;
            }
        }
        #endregion
    }
}
#endregion

