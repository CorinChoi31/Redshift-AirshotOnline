var _i = 0;
var _player = noone;

draw_set_color(c_white);
draw_set_alpha(1);
draw_set_valign(fa_top);
draw_set_halign(fa_center);

if(game.stage == GAME_STAGE.GAME_READY) {
    draw_text(mouse_x, mouse_y + 32, string_ext("ready: {0}", [game.user_list[game.client.player].ready]));
    draw_text(mouse_x, mouse_y + 64, string_ext("unit: {0}", [game.user_list[game.client.player].unit]));
}

if(game.stage == GAME_STAGE.GAME_START) {
    _i = 0;
    repeat(array_length(game.player_list)) {
        _player = game.player_list[_i];
        
        if(_i != game.client.player) {
            draw_set_valign(fa_bottom);
            draw_text_transformed(_player.x, _player.y - 24, string_ext("{0}", [game.user_list[_i].name]), 0.5, 0.5, 0);
        }
        
        draw_set_valign(fa_top);
        if(_player.unit.dead) {
            draw_text_transformed(_player.x, _player.y + 32, string_ext("{0}", [_player.unit.respawn]), 0.5, 0.5, 0);
        }
        else {
            draw_text_transformed(_player.x, _player.y + 32, string_ext("{0}/{1}", [_player.unit.frame.durability, _player.unit.frame.durability_max]), 0.5, 0.5, 0);
            draw_text_transformed(_player.x, _player.y + 48, string_ext("{0}", [_player.unit.engine.linear_speed]), 0.5, 0.5, 0);
            draw_text_transformed(_player.x, _player.y + 64, string_ext("{0}", [_player.id]), 0.5, 0.5, 0);
            
        }
        
    
        if(_i == game.client.player) {
            if(_player.unit.weapon.magazine.amount > 0) {
                draw_text_transformed(mouse_x, mouse_y + 32, string_ext("{0}/{1}", [_player.unit.weapon.magazine.amount, _player.unit.weapon.magazine.amount_max]), 0.5, 0.5, 0);
            }
            else {
                draw_text_transformed(mouse_x, mouse_y + 32, string_ext("{0}", [_player.unit.weapon.magazine.reload_time]), 0.5, 0.5, 0);
            }
        }
    
        _i += 1;
    }
}
