var _type = async_load[? "type"];
var _id = async_load[? "id"];
var _ip = async_load[? "ip"];

var _i = 0;
var _find = -1;

switch(_type) {
    default:
        break;
    case network_type_connect:
       
        break;
    case network_type_disconnect:
        _find = -1;
        repeat(array_length(server_client_list)) {
            if(_id == server_client_list[_i].client_id) {
                _find = _i;
                break;
            }
            _i += 1;
        }
        if(_find != -1) {
            server_client_list[_find].client_id = undefined;
        }
        break;
    case network_type_data:
        var _buffer = async_load[? "buffer"];
        var _size = async_load[? "size"];
        
        buffer_seek(_buffer, buffer_seek_start, 0);
        
        var _event = buffer_read(_buffer, buffer_u8);
        switch(_event) {
            default:
                break;
            case NET_EVENT.CONNECT:
                var _user_id = buffer_read(_buffer, buffer_string);
                var _instance = noone;
                
                _find = -1;
                _i = 0;
                repeat(array_length(server_client_list)) {
                    if(_user_id == server_client_list[_i].user_id) {
                        _find = _i;
                        break;
                    }
                    _i += 1;
                }
                if(_find == -1) {
                    array_push(server_client_list, new Client(_id, _ip, _user_id));
                    _find = array_length(server_client_list)-1;
                    
                    _instance = instance_create_layer(360, 360, "Game", OBJ_Player);
                        _instance.unit = json_parse(json_stringify(global.__unit[0]));
                        _instance.unit.x = 360;
                        _instance.unit.y = 360;
                        _instance.unit.player = _find;
                }
                else {
                    server_client_list[_find].client_id = _id;
                    server_client_list[_find].client_ip = _ip;
                }
                
                show_debug_message(string_ext("Connected Player<{0}>: {1}", [_find, _user_id]));
                
                buffer_seek(server_packet, buffer_seek_start, 0);
                buffer_write(server_packet, buffer_u8, NET_EVENT.CONNECT);
                buffer_write(server_packet, buffer_u8, _find);
                network_send_packet(_id, server_packet, buffer_tell(server_packet));
                break;
            case NET_EVENT.GAME_INPUT:
                var _player_index = buffer_read(_buffer, buffer_u8);
                var _input = buffer_read(_buffer, buffer_string);
                
                _find = -1;
                _i = 0;
                repeat(array_length(game.player_list)) {
                    if(game.player_list[_i].unit.player == _player_index) {
                        _find = _i;
                        break;
                    }
                    _i += 1;
                }
                
                if(_find != -1) {
                    game.player_list[_find].unit.input = json_parse(_input);
                }
                break;
        }
        break;
}