if(server_connecting == 2) {
    if(
        mouse_x != mouse_x_previous or 
        mouse_y != mouse_y_previous or
        mouse_check_button_pressed(mb_left) or mouse_check_button_released(mb_left) or
        keyboard_check_pressed(ord("W")) or keyboard_check_released(ord("W")) or
        keyboard_check_pressed(ord("A")) or keyboard_check_released(ord("A")) or
        keyboard_check_pressed(ord("S")) or keyboard_check_released(ord("S")) or
        keyboard_check_pressed(ord("D")) or keyboard_check_released(ord("D")) or
        keyboard_check_pressed(ord("R")) or keyboard_check_released(ord("R"))
    ) {
        var _input = new Input(
            mouse_x, mouse_y,
            keyboard_check(ord("W")), keyboard_check(ord("A")), keyboard_check(ord("S")), keyboard_check(ord("D")),
            mouse_check_button(mb_left),
            keyboard_check(ord("R"))
        );
        show_debug_message(player)
        buffer_seek(client_packet, buffer_seek_start, 0);
        buffer_write(client_packet, buffer_u8, NET_EVENT.GAME_INPUT);
        buffer_write(client_packet, buffer_u8, player);
        buffer_write(client_packet, buffer_string, json_stringify(_input));
        network_send_packet(server, client_packet, buffer_tell(client_packet));
    }
}

mouse_x_previous = mouse_x;
mouse_y_previous = mouse_y;