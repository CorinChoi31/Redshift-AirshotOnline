var _type = async_load[? "type"];
var _id = async_load[? "id"];
var _ip = async_load[? "ip"];

var _socket = undefined;

var _i = 0;
var _find = -1;

switch(_type) {
    default:
        break;
    case network_type_connect:
        _socket = async_load[? "socket"];
        break;
    case network_type_disconnect:
        _socket = async_load[? "socket"];
        if(game.game.stage == GAME_STAGE.GAME_READY) {
            _find = -1;
            repeat(array_length(server_client_list)) {
                if(_socket == server_client_list[_i].client_id) {
                    _find = _i;
                    break;
                }
                _i += 1;
            }
            if(_find != -1) {
                network_destroy(server_client_list[_find].client_id);
                array_delete(server_client_list, _i, 1);
                array_delete(game.game.users, _i, 1);
            }
        }
        else {
            _find = -1;
            repeat(array_length(server_client_list)) {
                if(_socket == server_client_list[_i].client_id) {
                    _find = _i;
                    break;
                }
                _i += 1;
            }
            if(_find != -1) {
                network_destroy(server_client_list[_find].client_id);
                server_client_list[_find].client_id = undefined;
            }
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
                        if(server_client_list[_i].client_id == undefined) {
                            _find = _i;
                        }
                        else {
                            _find = -2;
                        }
                        break;
                    }
                    _i += 1;
                }
                
                if(_find == -2) {
                    
                }
                else if(_find == -1) {
                    if(game.game.stage == GAME_STAGE.GAME_READY) {
                        array_push(server_client_list, new Client(_id, _ip, _user_id));
                        array_push(game.game.users, new User(_user_id));
                        _find = array_length(server_client_list)-1;
                    }
                    else {
                        _find = -3;
                    }
                }
                else {
                    server_client_list[_find].client_id = _id;
                    server_client_list[_find].client_ip = _ip;
                }
                
                show_debug_message(string_ext("Connected Player<{0}>: {1}", [_find, _user_id]));
                
                buffer_seek(server_packet, buffer_seek_start, 0);
                buffer_write(server_packet, buffer_u8, NET_EVENT.CONNECT);
                buffer_write(server_packet, buffer_s8, _find);
                network_send_packet(_id, server_packet, buffer_tell(server_packet));
                break;
            case NET_EVENT.DISCONNECT:
                if(game.game.stage == GAME_STAGE.GAME_READY) {
                    _find = -1;
                    _i = 0;
                    repeat(array_length(server_client_list)) {
                        if(_user_id == server_client_list[_i].user_id) {
                            _find = _i;
                            network_destroy(server_client_list[_i].client_id);
                            array_delete(server_client_list, _i, 1);
                            break;
                        }
                        _i += 1;
                    }
                    if(_find != -1) {
                        array_delete(game.game.users, _find, 1);
                    
                        buffer_seek(server_packet, buffer_seek_start, 0);
                        buffer_write(server_packet, buffer_u8, NET_EVENT.DISCONNECT);
                        buffer_write(server_packet, buffer_u8, _find);
                        _i = 0;
                        repeat(array_length(server_client_list)) {
                            if(server_client_list[_i].client_id != undefined) {
                                network_send_packet(server_client_list[_i].client_id, server_packet, buffer_tell(server_packet));
                            }
                            _i += 1;
                        }
                    }
                }
                break;
            case NET_EVENT.GAME_INPUT:
                var _player_index = buffer_read(_buffer, buffer_u8);
                var _input = buffer_read(_buffer, buffer_string);
                
                if(_player_index >= 0) {
                    game.game.users[_player_index].input.Unpack(json_parse(_input));
                }
                break;
        }
        break;
}