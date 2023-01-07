Client = function(_client_ip="", _client_id="") constructor {
    client_ip = _client_ip;
    client_id = _client_id;
}

server_port = 17540;
server_max_players = 4;

server_log = array_create(0);

server = undefined;
server_input = "";

server_client_list = array_create(server_max_players, undefined);