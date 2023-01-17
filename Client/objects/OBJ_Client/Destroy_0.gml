menu.client = noone;

buffer_seek(client_packet, buffer_seek_start, 0);
buffer_write(client_packet, buffer_u8, NET_EVENT.DISCONNECT);
buffer_write(client_packet, buffer_string, user_id);
network_send_packet(server, client_packet, buffer_tell(client_packet));