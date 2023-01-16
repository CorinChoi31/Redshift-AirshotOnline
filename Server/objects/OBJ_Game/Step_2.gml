var _i = 0;
repeat(array_length(player_list)) {
    if(player_list[_i] != undefined && !instance_exists(player_list[_i])) {
        player_list[_i] = undefined;
    }
    _i += 1;
}
    
_i = 0;
repeat(array_length(projectile_list)) {
    if(!instance_exists(projectile_list[_i])) {
        array_delete(projectile_list, _i, 1);
        _i -= 1;
    }
    _i += 1;
}