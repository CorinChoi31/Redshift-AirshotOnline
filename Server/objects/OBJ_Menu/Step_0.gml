var _console_input = "";
var _console_input_split;
var _console_output = "";

if(console_work == undefined) {
    if(keyboard_check_pressed(vk_enter)) {
        _console_input = keyboard_string;
        keyboard_string = "";

        _console_input_split = string_split(_console_input, " ");
        switch(string_lower(_console_input_split[0])) {
            default:
                _console_output = "Unknown Command.";
                break;
            case "server":
                if(array_length(_console_input_split) <= 1) {
                    _console_input_split[1] = "";
                }
                switch(string_lower(_console_input_split[1])) {
                    default:
                        _console_output = string_ext("{0} {1}", [
                            _console_input_split[1], "is unknown option"
                        ]);
                        break;
                    case "start":
                        if(server != noone) {
                            _console_output = string_ext("{0}", [
                                "Server is already running!"
                            ]);
                        }
                        else {
                            server = instance_create_layer(0, 0, "Menu", OBJ_Server);
                            server.menu = self.id;
                            _console_output = string_ext("{0}", [
                                "Start Server..."
                            ]);
                        }
                        break;
                    case "stop":
                        if(server != noone) {
                            instance_destroy(server);
                            server = noone;
                            _console_output = string_ext("{0}", [
                                "Server Stopped."
                            ]);
                        }
                        else {
                            _console_output = string_ext("{0}", [
                                "There's no Server."
                            ]);
                        }
                        break;
                }
                break;
        }
        array_push(console_history, _console_input);
        array_push(console_log, "| " + _console_input);
        array_push(console_log, _console_output);
        console_index = array_length(console_history);
    }
    else {
        if(keyboard_check_pressed(vk_up)) {
            console_index -= 1;
            if(console_index >= 0) {
                keyboard_string = console_history[console_index];
            }
            else {
                console_index = 0;
            }
        }
        else if(keyboard_check_pressed(vk_down)) {
            console_index += 1;
            if(console_index < array_length(console_history)) {
                keyboard_string = console_history[console_index];
            }
            else {
                console_index = array_length(console_history);
                keyboard_string = "";
            }
        }
    }
}
else {
    
}