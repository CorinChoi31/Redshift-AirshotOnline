var _type = async_load[? "type"];
var _id = async_load[? "id"];
var _ip = async_load[? "ip"];

switch(_async_type) {
    default:
        break;
    case network_type_connect:
        array_push(server_client_list, new Client(_id, _ip));
        break;
    case network_type_disconnect:
        break;
    case network_type_data:
        var _buffer = async_load[? "buffer"];
        var _size = async_load[? "size"];
        
        break;
}