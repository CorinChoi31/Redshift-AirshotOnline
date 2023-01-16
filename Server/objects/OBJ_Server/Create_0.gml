network_set_config(network_config_connect_timeout, 5000);
network_set_config(network_config_use_non_blocking_socket, true);


server_type = network_socket_tcp;
server_port = 17540;
server_max_clients = 8;
server_max_players = 4;

server_log = array_create(0);
server_packet = buffer_create(1024, buffer_grow, 1);

server = undefined;

server_client_list = array_create(0, undefined);


console_work = undefined;
console_index = -1;
console_log = array_create(0);
console_history = array_create(0);


global.game = instance_create_layer(0, 0, "GameForeground", OBJ_Game);
game = global.game;

keyboard_string = "server start";