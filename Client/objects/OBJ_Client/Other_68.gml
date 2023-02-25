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
            server_connecting = NET_STATE.CONNECTED_SOCKET;
            
            buffer_seek(client_packet, buffer_seek_start, 0);
            buffer_write(client_packet, buffer_u8, NET_EVENT.CONNECT);
            buffer_write(client_packet, buffer_string, user_id);
            network_send_packet(server, client_packet, buffer_tell(client_packet));
        }
        else {
            server_connecting = NET_STATE.NOT_CONNECTED;
            server = -1;
            
            show_message("연결 실패.");
        }
        break;
    case network_type_disconnect:
        server_connecting = NET_STATE.NOT_CONNECTED;
        server = -1;
        
        show_message("연결이 종료되었습니다.");
        menu.phase_goto(gui_system.MENU_MULTIPLAYER);
        
        instance_destroy(self);
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
                player = buffer_read(_buffer, buffer_s8);
                if(player >= 0) {
                    server_connecting = NET_STATE.CONNECTED_PLAYER;
                    menu.phase_goto(gui_system.MENU_MULTIPLAYER_GAME);
                }
                else {
                    server_connecting = NET_STATE.NOT_CONNECTED;
                    server = -1;
                    
                    switch(player) {
                        default:
                            show_message("알 수 없는 이유로 접속할 수 없습니다.");
                            break;
                        case -2:
                            show_message("동일한 이름을 사용하는 사용자가 있습니다.");
                            break;
                        case -3:
                            show_message("이미 게임이 진행 중입니다.");
                            break;
                    }
                    
                    menu.phase_goto(gui_system.MENU_MULTIPLAYER);
                    
                    instance_destroy(self);
                }
                break;
            case NET_EVENT.DISCONNECT:
                var _player = buffer_read(_buffer, buffer_u8);
                if(player > _player) {
                    player -= 1;
                }
                break;
            case NET_EVENT.GAME_SNAPSHOT:
                var _snapshot = buffer_read(_buffer, buffer_string);
                _snapshot = json_parse(_snapshot);
                
                //show_debug_message(string_length(_snapshot));
                //show_debug_message(_snapshot._);
                
                if(room == ROM_Game) {
                    game.game.Unpack(_snapshot._);
                }
                break;
        }
        break;
}