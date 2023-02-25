var _i = 0;

switch(game.stage) {
    default:
        game.stage = GAME_STAGE.GAME_READY;
        game.time = -1;
        break;
        
    case GAME_STAGE.GAME_READY:
        if(array_length(game.users) >= 1) {
            var _ready = 0;
            
            repeat(array_length(game.planes)) {
                instance_destroy(game.planes[0]);
                array_delete(game.planes, 0, 1);
            }
            
            repeat(array_length(game.projectiles)) {
                instance_destroy(game.projectiles[0]);
                array_delete(game.projectiles, 0, 1);
            }
            
            if(world != noone) {
                instance_destroy(world);
                world = noone;
            }
            
            _i = 0;
            repeat(array_length(game.users)) {
                if(game.users[_i].input.fire) {
                    game.users[_i].input.fire = 0;
                    game.users[_i].status.plane_index = (game.users[_i].status.plane_index + 1) % array_length(global.__plane);
                }
                if(game.users[_i].input.reload) {
                    game.users[_i].input.reload = 0;
                    game.users[_i].status.ready = !game.users[_i].status.ready;
                }
                _ready += game.users[_i].status.ready;
                _i += 1;
            }
            
            if(_ready == array_length(game.users)) {
                if(game.time > 3) {
                    game.stage = GAME_STAGE.GAME_START;
                    game.time = -1;
                    
                    game.world = new GameWorld(1200, 
                        choose(5, 6, 8, 10, 12, 15, 18, 20, 24, 30, 36, 45, 60),
                        irandom_range(0, 360)
                    );
                }
            }
            else {
                game.time = 0;
            }
        }
        break;
        
    case GAME_STAGE.GAME_START:
        if(game.time == 0) {
            _i = 0;
            var _angle = random_range(0, 360);
            var _x = 0;
            var _y = 0;
            var _players = array_length(game.users);
            
            repeat(_players) {
                _x = room_width * 0.5 + lengthdir_x(game.world.range * 0.8, _angle);
                _y = room_height * 0.5 + lengthdir_y(game.world.range * 0.8, _angle);
                var _plane = global.__plane[game.users[_i].status.plane_index].plane;
                var _sensor = _plane.weapon.projectile.sensor;
                if(_sensor != undefined) {
                    _sensor = new PlaneWeaponProjectileSensor(_plane.weapon.projectile.sensor.trace_able, _plane.weapon.projectile.sensor.find_distance, _plane.weapon.projectile.sensor.find_angle, _plane.weapon.projectile.sensor.target_limit);
                }
                var _instance = instance_create_layer(_x, _y, "Game", OBJ_Plane);
                    _instance.game = self.id;
                    _instance.plane_init = json_parse(json_stringify(_plane));
                    _instance.plane_init.passive = new PlanePassive(game.users[_i].status.passive_index);
                    _instance.plane_init.active = new PlaneActive(game.users[_i].status.active_index, global.__active[game.users[_i].status.active_index].cool);
                    _instance.plane = new Plane(
                        new PlaneFrame(_plane.frame.durability_max, _plane.frame.durability_loss, _plane.frame.durability_fix),
                        new PlaneEngine(_plane.engine.linear_speed_max, _plane.engine.linear_speed_accel, _plane.engine.angular_speed_ratio, _plane.engine.angular_speed_limit),
                        new PlaneWeapon(_plane.weapon.cool_max, _plane.weapon.amount, _plane.weapon.period_max, _plane.weapon.interval_max, _plane.weapon.dispersion_linear, _plane.weapon.dispersion_angular,
                            new PlaneWeaponProjectile(_plane.weapon.projectile.object, _plane.weapon.projectile.collide_size, _plane.weapon.projectile.collide_size_max,
                                new PlaneWeaponProjectileOnhit(_plane.weapon.projectile.onhit.type, _plane.weapon.projectile.onhit.damage), 
                                new PlaneWeaponProjectileForce(_plane.weapon.projectile.force.duration_max, _plane.weapon.projectile.force.linear_speed, _plane.weapon.projectile.force.linear_speed_max, _plane.weapon.projectile.force.linear_speed_accel, _plane.weapon.projectile.force.angular_speed_ratio, _plane.weapon.projectile.force.angular_speed_limit), 
                                _sensor
                            ),
                            new PlaneWeaponMagazine(_plane.weapon.magazine.amount, 
                                new PlaneWeaponMagazineReload(_plane.weapon.magazine.reload.amount, _plane.weapon.magazine.reload.cool_max)
                            )
                        )
                    );
                    _instance.plane.player_index = _i;
                    _instance.plane.x = _x;
                    _instance.plane.y = _y;
                    _instance.plane.passive = new PlanePassive(game.users[_i].status.passive_index);
                    _instance.plane.active = new PlaneActive(game.users[_i].status.active_index, global.__active[game.users[_i].status.active_index].cool);
                game.planes[_i] = _instance;
                _angle = _angle + 360/_players;
                _i += 1;
            }
            
            world = instance_create_layer(room_width * 0.5, room_height * 0.5, "Game", OBJ_World);
            world.CreateFixture(game.world.range, game.world.angle, game.world.rotate);
        }
        else {
            _i = 0;
            repeat(array_length(game.users)) {
                if(game.users[_i].input.update > 0) {
                    game.planes[_i].user_input.Unpack(game.users[_i].input.Pack());
                    
                    game.users[_i].input.update -= 1;
                }
                _i += 1;
            }
        }
        break;
    
    case GAME_STAGE.GAME_END:
        if(game.time == 0) {
            _i = 0;
            repeat(array_length(game.users)) {
                game.planes[_i].input = new UserInput();
            }
        }
        else {
            if(time > 10) {
                game.stage = GAME_STAGE.GAME_READY;
                game.time = -1;
                
                _i = 0;
                repeat(array_length(game.users)) {
                    game.users[_i].kill = 0;
                    game.users[_i].death = 0;
                    
                    game.users[_i].ready = 0;
                    _i += 1;
                }
            }
        }
        break;
}

if(game.time == -1) {
    game.time = 0;
}
else {
    game.time += global.__time;
}