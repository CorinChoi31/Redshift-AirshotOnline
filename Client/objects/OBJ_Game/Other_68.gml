var _type = async_load[? "type"];
var _id = async_load[? "id"];
var _ip = async_load[? "ip"];

var _i = 0;

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
                show_debug_message(buffer_read(_buffer, buffer_u8));
                break;
        }
        break;
}