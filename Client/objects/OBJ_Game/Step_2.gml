var _i = 0;
repeat(array_length(game.projectiles)) {
    if(!instance_exists(game.projectiles[_i])) {
        array_delete(game.projectiles, _i, 1);
        _i -= 1;
    }
    _i += 1;
}