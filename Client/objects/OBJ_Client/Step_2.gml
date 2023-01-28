if(server_connecting == NET_STATE.CONNECTED_PLAYER) {
    if(window_has_focus()) {
        switch(game.game.stage) {
            case GAME_STAGE.GAME_READY:
                if(
                    mouse_check_button_pressed(mb_left) or mouse_check_button_released(mb_left) or
                    keyboard_check_pressed(ord("W")) or keyboard_check_released(ord("W")) or
                    keyboard_check_pressed(ord("A")) or keyboard_check_released(ord("A")) or
                    keyboard_check_pressed(ord("S")) or keyboard_check_released(ord("S")) or
                    keyboard_check_pressed(ord("D")) or keyboard_check_released(ord("D")) or
                    keyboard_check_pressed(ord("R")) or keyboard_check_released(ord("R")) or
                    keyboard_check_pressed(vk_space) or keyboard_check_released(vk_space)
                ) {
                    var _input = new UserInput(
                        mouse_x, mouse_y,
                        keyboard_check(ord("W")), keyboard_check(ord("A")), keyboard_check(ord("S")), keyboard_check(ord("D")),
                        mouse_check_button(mb_left),
                        keyboard_check(ord("R")),
                        keyboard_check(vk_space)
                    );
                    buffer_seek(client_packet, buffer_seek_start, 0);
                    buffer_write(client_packet, buffer_u8, NET_EVENT.GAME_INPUT);
                    buffer_write(client_packet, buffer_u8, player);
                    buffer_write(client_packet, buffer_string, json_stringify(_input.Pack()));
                    network_send_packet(server, client_packet, buffer_tell(client_packet));
                }
                break;
    
            case GAME_STAGE.GAME_START:
                if(
                    mouse_x != mouse_x_previous or 
                    mouse_y != mouse_y_previous or
                    mouse_check_button_pressed(mb_left) or mouse_check_button_released(mb_left) or
                    keyboard_check_pressed(ord("W")) or keyboard_check_released(ord("W")) or
                    keyboard_check_pressed(ord("A")) or keyboard_check_released(ord("A")) or
                    keyboard_check_pressed(ord("S")) or keyboard_check_released(ord("S")) or
                    keyboard_check_pressed(ord("D")) or keyboard_check_released(ord("D")) or
                    keyboard_check_pressed(ord("R")) or keyboard_check_released(ord("R")) or
                    keyboard_check_pressed(vk_space) or keyboard_check_released(vk_space)
                ) {
                    var _input = new UserInput(
                        mouse_x, mouse_y,
                        keyboard_check(ord("W")), keyboard_check(ord("A")), keyboard_check(ord("S")), keyboard_check(ord("D")),
                        mouse_check_button(mb_left),
                        keyboard_check(ord("R")),
                        keyboard_check(vk_space)
                    );
                    buffer_seek(client_packet, buffer_seek_start, 0);
                    buffer_write(client_packet, buffer_u8, NET_EVENT.GAME_INPUT);
                    buffer_write(client_packet, buffer_u8, player);
                    buffer_write(client_packet, buffer_string, json_stringify(_input.Pack()));
                    network_send_packet(server, client_packet, buffer_tell(client_packet));
                    
                    //if(array_length(game.game.users) > player) {
                        //game.game.users[player].input = _input;
                    //}
                }
                break;
        }
    }
}

mouse_x_previous = mouse_x;
mouse_y_previous = mouse_y;