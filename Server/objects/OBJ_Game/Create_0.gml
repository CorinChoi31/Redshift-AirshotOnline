server = noone;


stage = GAME_STAGE.GAME_READY;
time = -1;


user_list = [];

player_list = [];

projectile_list = [];
projectile_id = 0;


MakeSnapshot = function() {
    var _users = user_list;
    var _players = [];
    var _projectiles = [];
    
    var _i = 0;
    
    _i = 0;
    repeat(array_length(player_list)) {
        if(player_list[_i] != undefined) {
            array_push(_players, player_list[_i].unit);
        }
        _i += 1;
    }
    
    _i = 0;
    repeat(array_length(projectile_list)) {
        array_push(_projectiles, projectile_list[_i].projectile);
        _i += 1;
    }
    
    return new Snapshot(
        new Game(
            stage,
            time, 
            _users,
            _players, 
            _projectiles
        )
    );
}