var _i = 0;

network_destroy(server);
repeat(array_length(server_client_list)) {
    if(server_client_list[_i].client_id != undefined) {
        network_destroy(server_client_list[_i].client_id);
    }
    array_delete(server_client_list, 0, 1);
}