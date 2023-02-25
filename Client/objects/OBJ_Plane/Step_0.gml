var _delta_time = global.__time;
var _i = 0;

#region
plane.frame.durability_draw = lerp(plane.frame.durability_draw, plane.frame.durability, 0.1);
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
        phy_position_x = lerp(phy_position_x, plane.x, 0.9);
        phy_position_y = lerp(phy_position_y, plane.y, 0.9);
        
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

