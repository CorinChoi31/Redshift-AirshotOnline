var _delta_time = global.__time;

if(projectile.force.duration > 0) {
    var _i = 0;

    var _pdis = point_distance(projectile.x, projectile.y, phy_position_x, phy_position_y);
    var _pdir = point_direction(projectile.x, projectile.y, phy_position_x, phy_position_y);
    var _x = 0;
    var _y = 0;
    var _length = 4;
    var _size = max(round(_pdis/_length)*_length, 1);
    
    projectile.force.linear_speed = min(projectile.force.linear_speed + projectile.force.linear_speed_accel * _delta_time, projectile.force.linear_speed_max);
    if(projectile.sensor != undefined) {
        if(projectile.sensor.trace_able) {
            var _target = -1;
            var _target_distance = projectile.sensor.find_distance;
            var _distance = 0;
            
            with(OBJ_Plane) {
                if(!plane.destroyed) {
                    if(plane.player_index != other.projectile.player_index) {
                        if(point_in_circle(phy_position_x, phy_position_y, other.phy_position_x, other.phy_position_y, other.projectile.sensor.find_distance)) {
                            if(abs(angle_difference(point_distance(phy_position_x, phy_position_y, other.phy_position_x, other.phy_position_y), other.projectile.force.angular_direction)) <= other.projectile.sensor.find_angle) {
                                _distance = point_distance(phy_position_x, phy_position_y, other.phy_position_x, other.phy_position_y);
                                if(_distance <= _target_distance) {
                                    _target = id;
                                    _target_distance = _distance;
                                }
                            }
                        }
                    }
                }
            }
            
            if(_target != -1) {
                projectile.sensor.trace_able = false;
                projectile.sensor.trace_ing = true;
                
                projectile.sensor.target_index = _target;
            }
        }
        
        if(projectile.sensor.trace_ing) {
            if(projectile.sensor.target_index != -1) {
                if(!projectile.sensor.target_index.plane.destroyed) {
                    projectile.sensor.target_x = projectile.sensor.target_index.plane.x;
                    projectile.sensor.target_y = projectile.sensor.target_index.plane.y;
            
                    var _move_direction = point_direction(projectile.x, projectile.y, projectile.sensor.target_x, projectile.sensor.target_y);
                    var _difference = angle_difference(_move_direction, projectile.force.angular_direction);
                    var _difference_sign = sign(_difference);
                
                    projectile.force.angular_direction += median(0, abs(_difference) * projectile.force.angular_speed_ratio, projectile.force.angular_speed_limit * _delta_time) * _difference_sign;
                
                    if(abs(_difference) > projectile.sensor.target_limit) {
                        projectile.sensor.trace_ing = false;
                    }
                }
                else {
                    projectile.sensor.trace_ing = false;
                }
            }
        }
    }
    
    phy_speed_x = lerp(phy_speed_x, lengthdir_x(projectile.force.linear_speed, projectile.force.angular_direction), 0.1);
    phy_speed_y = lerp(phy_speed_y, lengthdir_y(projectile.force.linear_speed, projectile.force.angular_direction), 0.1);
    
    projectile.x = phy_position_x;
    projectile.y = phy_position_y;
    
    with(OBJ_Plane) {
        if(!plane.destroyed) {
            if(plane.frame.collide_able) {
                if(plane.player_index != other.projectile.player_index) {
                    if(point_in_circle(plane.x, plane.y, other.projectile.x, other.projectile.y, plane.frame.collide_size + other.projectile.collide_size)) {
                        other.projectile.collided = true;
                        break;
                    }
                }
            }
        }
    }
    
    if(projectile.collided) {
        projectile.force.duration = 0;
        
        phy_speed_x = 0;
        phy_speed_y = 0;
        
        update = 1;
        
        var _collision = [];
        with(OBJ_Plane) {
            if(!plane.destroyed) {
                if(plane.frame.collide_able) {
                    if(plane.player_index != other.projectile.player_index) {
                        if(point_in_circle(plane.x, plane.y, other.projectile.x, other.projectile.y, plane.frame.collide_size + other.projectile.collide_size_max)) {
                            array_push(plane.damages, new Damage(other.projectile.player_index, projectile.onhit.type, -other.projectile.onhit.damage));
                        }
                    }
                }
            }
        }
    }
}
else {
    
}