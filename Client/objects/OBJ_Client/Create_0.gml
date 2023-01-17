menu = noone;
game = instance_create_layer(0, 0, "Game", OBJ_Game);
game.client = self.id;


client_socket = network_create_socket(network_socket_tcp);
client_ip = "127.0.0.1";
client_port = 17540;

client_packet = buffer_create(1024, buffer_grow, 1);

server_connecting = 0;
server = -1;

user_id = "";


player = -1;