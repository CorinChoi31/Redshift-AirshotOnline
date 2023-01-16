var _type = async_load[? "type"];
var _id = async_load[? "id"];
var _ip = async_load[? "ip"];

var _i = 0;

switch(_type) {
    default:
        break;
    case network_type_connect:
       
        break;
    case network_type_disconnect:
        var _find = -1;
        repeat(array_length(server_client_list)) {
            
            if(_id == server_client_list[_i].client_id) {
                _find = _i;
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
                _i = 0;
                var _find = -1;
                var _uid = buffer_read(_buffer, buffer_string);
                show_debug_message(_uid);
                repeat(array_length(server_client_list)) {
                    if(_uid == server_client_list[_i].user_id) {
                        _find = _i;
                    }
                    _i += 1;
                }
                if(_find == -1) {
                    array_push(server_client_list, new Client(_id, _ip, _uid));
                    _find = array_length(server_client_list)-1;
                }
                else {
                    server_client_list[_find].client_id = _id;
                    server_client_list[_find].client_ip = _ip;
                }
        
                buffer_seek(server_packet, buffer_seek_start, 0);
                buffer_write(server_packet, buffer_u8, NET_EVENT.CONNECT);
                buffer_write(server_packet, buffer_u8, _find);
                network_send_packet(_id, server_packet, buffer_tell(server_packet));
                break;
        }
        break;
}