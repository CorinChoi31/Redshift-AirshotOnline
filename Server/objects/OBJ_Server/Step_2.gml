var _i = 0;

if(console_work == undefined) {
    if(instance_exists(global.game)) {
        var _buffer = buffer_create(1024, buffer_grow, 1);
        buffer_seek(_buffer, buffer_seek_start, 0);
        buffer_write(_buffer, buffer_u8, NET_EVENT.GAME_SNAPSHOT);
        buffer_write(_buffer, buffer_string, json_stringify(global.game.MakeSnapshot()));
        
        _i = 0;
        repeat(array_length(server_client_list)) {
            if(server_client_list[_i].client_id != undefined) {
                network_send_packet(server_client_list[_i].client_id, _buffer, buffer_tell(_buffer));
            }
            _i += 1;
        }
    }
}