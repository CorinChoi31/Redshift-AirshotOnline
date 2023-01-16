var _type = async_load[? "type"];
var _id = async_load[? "id"];
var _ip = async_load[? "ip"];

var _i = 0;
var _j = 0;

switch(_type) {
    default:
        break;
    case network_type_connect:
        
        break;
    case network_type_non_blocking_connect:
        if(async_load[? "succeeded"]) {
            server_connecting = 2;
            
            buffer_seek(client_packet, buffer_seek_start, 0);
            buffer_write(client_packet, buffer_u8, NET_EVENT.CONNECT);
            buffer_write(client_packet, buffer_string, user_id);
            network_send_packet(server, client_packet, buffer_tell(client_packet));
        }
        else {
            server_connecting = 0;
            server = -1;
        }
        break;
    case network_type_disconnect:
        
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
                player = buffer_read(_buffer, buffer_u8);
                break;
            case NET_EVENT.GAME_STAGE:
                
                break;
            case NET_EVENT.GAME_SNAPSHOT:
                var _snapshot = buffer_read(_buffer, buffer_string);
                _snapshot = json_parse(_snapshot);
                
                time = _snapshot.time;
                
                var _copylist = [];
                var _player, _instance;
                array_copy(_copylist, 0, player_list, 0 , array_length(player_list))
                
                _i = 0;
                repeat(array_length(_snapshot.players)) {
                    _player = _snapshot.players[_i];
                    _j = 0;
                    repeat(array_length(_copylist)) {
                        if(!instance_exists(_copylist[_j])) {
                            array_delete(_copylist, _j, 1);
                            continue;
                        }
                        if(_copylist[_j].unit.player == _player.player) {
                            _copylist[_j].unit = _player;
                            array_delete(_copylist, _j, 1);
                            array_delete(_snapshot.players, _i, 1);
                            _j -= 1;
                            _i -= 1;
                            break;
                        }
                        _j += 1;
                    }
                    _i += 1;
                }
                _i = 0;
                repeat(array_length(_snapshot.players)) {
                    _player = _snapshot.players[_i];
                    _instance = instance_create_layer(_player.x, _player.y, "Game", OBJ_Player);
                        _instance.game = self.id;
                        _instance.unit = _player;
                    array_push(player_list, _instance);
                    _i += 1;
                }
                
                
                _copylist = []
                var _projectile;
                array_copy(_copylist, 0, projectile_list, 0 , array_length(projectile_list));
                
                _i = 0;
                repeat(array_length(_snapshot.projectiles)) {
                    _projectile = _snapshot.projectiles[_i];
                    _j = 0;
                    repeat(array_length(_copylist)) {
                        if(!instance_exists(_copylist[_j])) {
                            array_delete(_copylist, _j, 1);
                            continue;
                        }
                        if(_copylist[_j].projectile.player == _projectile.player) {
                            _copylist[_j].projectile = _projectile;
                            array_delete(_copylist, _j, 1);
                            array_delete(_snapshot.projectiles, _i, 1);
                            _j -= 1;
                            _i -= 1;
                            break;
                        }
                        _j += 1;
                    }
                    _i += 1;
                }
                _i = 0;
                repeat(array_length(_snapshot.projectiles)) {
                    _projectile = _snapshot.projectiles[_i];
                    _instance = instance_create_layer(_projectile.x, _projectile.y, "Game", asset_get_index(_projectile.object));
                        _instance.game = self.id;
                        _instance.projectile = _projectile;
                    array_push(projectile_list, _instance);
                    _i += 1;
                }
                break;
        }
        break;
}