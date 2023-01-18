var _i = 0;

switch(stage) {
    default:
        stage = GAME_STAGE.GAME_READY;
        time = -1;
        break;
        
    case GAME_STAGE.GAME_READY:
        if(array_length(user_list) >= 1) {
            var _ready = 0;
            
            _i = 0;
            repeat(array_length(user_list)) {
                if(user_list[_i].input.fire) {
                    user_list[_i].input.fire = 0;
                    user_list[_i].unit = (user_list[_i].unit + 1)%array_length(global.__unit);
                }
                if(user_list[_i].input.reload) {
                    user_list[_i].input.reload = 0;
                    user_list[_i].ready = !user_list[_i].ready;
                }
                _ready += user_list[_i].ready;
                _i += 1;
            }
            
            if(_ready == array_length(user_list)) {
                if(time > 3) {
                    stage = GAME_STAGE.GAME_START;
                    time = -1;
                }
            }
            else {
                time = 0;
            }
        }
        break;
        
    case GAME_STAGE.GAME_START:
        if(time == 0) {
            _i = 0;
            var _angle = random_range(0, 360);
            var _x = 0;
            var _y = 0;
            var _players = array_length(user_list);
            repeat(array_length(player_list)) {
                instance_destroy(player_list[0]);
                array_delete(player_list, 0, 1);
            }
            repeat(array_length(user_list)) {
                _x = 2500 + lengthdir_x(range * 0.8, _angle);
                _y = 2500 + lengthdir_y(range * 0.8, _angle);
                var _instance = instance_create_layer(_x, _y, "Game", OBJ_Player);
                    _instance.game = self.id;
                    _instance.unit = json_parse(json_stringify(global.__unit[user_list[_i].unit].unit));
                    _instance.unit.x = _x;
                    _instance.unit.y = _y;
                    _instance.unit.player = _i;
                player_list[_i] = _instance;
                _angle = _angle + 360/_players;
                _i += 1;
            }
            range = 3000;
        }
        else {
            var _kill = 0;
            
            _i = 0;
            repeat(array_length(user_list)) {
                player_list[_i].input = user_list[_i].input;
                
                var _distance = point_distance(2500, 2500, player_list[_i].x, player_list[_i].y);
                if(_distance > range + 12) {
                    player_list[_i].unit.frame.durability -= sqrt(time/60) * global.__time + (_distance - range)/1000;
                }
                
                _kill = max(_kill, user_list[_i].kill);
                _i += 1;
            }
            
            if(time >= 10) {
                range = max(range - time/150, range_min);
            }
            
            if(_kill >= 10) {
                stage = GAME_STAGE.GAME_END;
                time = -1;
                
                with(OBJ_Projectile) {
                    projectile.duration = 0;
                }
            }
        }
        break;
    
    case GAME_STAGE.GAME_END:
        if(time == 0) {
            
        }
        else {
            if(time > 10) {
                stage = GAME_STAGE.GAME_READY;
                time = -1;
                
                _i = 0;
                repeat(array_length(user_list)) {
                    user_list[_i].kill = 0;
                    user_list[_i].death = 0;
                    user_list[_i].ready = 0;
                    _i += 1;
                }
            }
        }
        break;
}

if(time == -1) {
    time = 0;
}
else {
    time += global.__time;
}