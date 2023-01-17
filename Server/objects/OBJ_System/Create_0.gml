randomize();

network_set_config(network_config_connect_timeout, 5000);
network_set_config(network_config_use_non_blocking_socket, true);

room_goto(ROM_Main);