menu = noone;
game = instance_create_layer(0, 0, "Game", OBJ_Game);
game.server = self.id;


server_type = network_socket_tcp;
server_port = 17540;
server_max_clients = 8;
server_max_players = 4;

server_log = array_create(0);
server_packet = buffer_create(1024, buffer_grow, 1);

server = network_create_server(server_type, server_port, server_max_clients);

server_client_list = array_create(0, undefined);


