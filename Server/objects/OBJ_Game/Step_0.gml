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
            repeat(array_length(user_list)){
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
            repeat(array_length(user_list)) {
                _x = 2500 + lengthdir_x(160, _angle);
                _y = 2500 + lengthdir_y(160, _angle);
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
        }
        else {
            _i = 0;
            repeat(array_length(user_list)) {
                player_list[_i].input = user_list[_i].input;
                _i += 1;
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