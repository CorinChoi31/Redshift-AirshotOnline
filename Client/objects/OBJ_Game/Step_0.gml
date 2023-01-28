var _i = 0;

switch(game.stage) {
    default:
        break; 
    case GAME_STAGE.GAME_READY:
        if(window_get_cursor() != cr_default) {
            window_set_cursor(cr_default);
        }
        break;
    case GAME_STAGE.GAME_START:
        if(window_get_cursor() != cr_none) {
            window_set_cursor(cr_none);
        }
        _i = 0;
        repeat(array_length(game.planes)) {
            if(_i == client.player) {
                //interface.player = game.planes[_i];
                if(game.planes[_i].plane.destroyed) {
                    //game.planes[_i].plane.user_input = new UserInput();
                }
                else {
                    camera.target = game.planes[_i];
                }
                game.planes[_i].sprite_index = SPR_Plane_Self;
                game.planes[_i].image_index = global.__plane[game.users[_i].status.plane_index].subimg;
            }
            else {
                game.planes[_i].sprite_index = SPR_Plane_Enemy;
                game.planes[_i].image_index = global.__plane[game.users[_i].status.plane_index].subimg;
            }
            _i += 1;
        }
        break;
    case GAME_STAGE.GAME_END:
        if(window_get_cursor() != cr_default) {
            window_set_cursor(cr_default);
        }
        break;
}

game.time += global.__time;