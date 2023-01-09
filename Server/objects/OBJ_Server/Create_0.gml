Client = function(_client_id="", _client_ip="") constructor {
    client_id = _client_id;
    client_ip = _client_ip;
}

server_type = network_socket_tcp;
server_port = 17540;
server_max_clients = 4;

server_log = array_create(0);
server_packet = buffer_create(1024, buffer_grow, 1);

server = undefined;

server_client_list = array_create(server_max_clients, undefined);




console_work = undefined;
console_index = -1;
console_log = array_create(0);
console_history = array_create(0);