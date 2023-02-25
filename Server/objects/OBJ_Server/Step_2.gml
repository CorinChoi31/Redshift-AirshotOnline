var _i = 0;

var _snapshot = json_stringify({ _: game.game.Pack(false) });
_snapshot = string_replace_all(_snapshot, " ", "");


var _buffer = buffer_create(1024, buffer_grow, 1);
buffer_seek(_buffer, buffer_seek_start, 0);
buffer_write(_buffer, buffer_u8, NET_EVENT.GAME_SNAPSHOT);
buffer_write(_buffer, buffer_string, _snapshot);

//show_debug_message(buffer_tell(_buffer));

var _client = undefined;
_i = 0;
repeat(array_length(server_client_list)) {
    _client = server_client_list[_i];
    if(_client.client_id != undefined) {
        if(_client.update == -1) {
            _client.update = 0;
            
            var __snapshot = json_stringify({ _: game.game.Pack(true) });
            _snapshot = string_replace_all(__snapshot, " ", "");
            
            var __buffer = buffer_create(1024, buffer_grow, 1);
            buffer_seek(__buffer, buffer_seek_start, 0);
            buffer_write(__buffer, buffer_u8, NET_EVENT.GAME_SNAPSHOT);
            buffer_write(__buffer, buffer_string, __snapshot);
            
            network_send_packet(_client.client_id, __buffer, buffer_tell(__buffer));
        }
        else {
            network_send_packet(_client.client_id, _buffer, buffer_tell(_buffer));
        }
    }
    _i += 1;
}

buffer_delete(_buffer);