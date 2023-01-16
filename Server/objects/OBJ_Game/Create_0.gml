time = 0;
players = [];
projectiles = [];

MakeSnapshot = function() {
    var _players = [];
    var _projectiles = [];
    
    var _i = 0;
    repeat(array_length(players)) {
        array_push(_players, players[_i].unit);
        _i += 1;
    }
    
    _i = 0;
    repeat(array_length(projectiles)) {
        array_push(_projectiles, 
            new Projectiles(
                object_get_name(projectiles[_i]),
                projectiles[_i].player
            )
        );
        _i += 1;
    }
    
    return new Snapshot(time, players, projectiles);
}

MakeSnapshot();