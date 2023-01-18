var _i = 0;
var _player = noone;

var _mouse_x = device_mouse_x_to_gui(0);
var _mouse_y = device_mouse_y_to_gui(0);

var _x = 0;
var _y = 0;
var _x1 = 0;
var _y1 = 0;
var _x2 = 0;
var _y2 = 0;
var _width = 0;
var _height = 0;
var _color = c_white;
var _alpha = 1;
var _value = 0;
var _space = 0;

draw_set_color(c_white);
draw_set_alpha(1);
draw_set_valign(fa_top);
draw_set_halign(fa_center);

if(gpu_get_blendmode() != bm_normal) {
    gpu_set_blendmode(bm_normal);
}

switch(game.stage) {
    default:
        break;
    case GAME_STAGE.GAME_READY:
        //camera_assign(0, undefined);
        
        _x = 0//camera_get_view_x(global.__camera);
        _y = 0//camera_get_view_y(global.__camera);
        
        draw_set_color(c_black);
        draw_set_alpha(0.75);
        draw_rectangle(_x, _y, _x + 1280, _y + 720, true);
        
        draw_set_color(c_white);
        draw_set_alpha(1);
        draw_set_valign(fa_top);
        draw_set_halign(fa_left);
        
        _x1 = _x + global.screen_width * 0.05;
        _y1 = _y + global.screen_height * 0.05;
        draw_text_transformed(_x1, _y1, "Press \"Left Mouse Button\" to Change Your Unit", 0.75, 0.75, 0);
        _y1 = global.screen_height * 0.1;
        draw_text_transformed(_x1, _y1, "Press \"R\" to Ready", 0.75, 0.75, 0);
        
        _x1 = _x + global.screen_width * 0.1;
        _y1 = _y + global.screen_height * 0.25;
        
        var _unit_index = game.user_list[game.client.player].unit;
        var _unit_data = global.__unit[_unit_index];
        draw_sprite_ext(SPR_Unit_Self, _unit_data.subimg, _x1, _y1, 2, 2, 45, c_white, 1);
        
        _x1 = _x + global.screen_width * 0.2;
        _y1 = _y + global.screen_height * 0.2;
        draw_text(_x1, _y1, _unit_data.name);
        _y1 = _y + global.screen_height * 0.275;
        draw_set_font(FNT_NBG24R);
        draw_text_transformed(_x1, _y1, _unit_data.description, 0.5, 0.5, 0);
        
        draw_set_font(global.__font);
        //
        draw_set_valign(fa_top);
        _x1 = _x + global.screen_width * 0.1;
        _y1 = _y + global.screen_height * 0.85;
        draw_text_transformed(_x1, _y1, string_ext("Players: {0}", [array_length(game.user_list)]), 0.75, 0.75, 0);
        _y1 = _y + global.screen_height * 0.9;
        
        var _ready = 0;
        _i = 0;
        repeat(array_length(game.user_list)) {
            if(game.user_list[_i].ready) {
                _ready += 1;
            }
            _i += 1;
        }
        draw_text_transformed(_x1, _y1, string_ext("Readys: {0}", [_ready]), 0.75, 0.75, 0);
        
        if(game.user_list[game.client.player].ready) {
            _x1 = _x + global.screen_width * 0.9;
            _y1 = _y + global.screen_height * 0.9;
            
            draw_set_valign(fa_bottom);
            draw_set_halign(fa_right);
            
            draw_text(_x1, _y1, "Ready!");
        }
        break;
    case GAME_STAGE.GAME_START:
        if(array_length(game.player_list) > 0) {
            _player = game.player_list[game.client.player];
            
            draw_set_font(global.__font);
            
            camera_assign(0, camera3d_left);
            
            draw_set_valign(fa_top);
            draw_set_halign(fa_left);
            
            _x = global.screen_width * 0.1;
            _y = global.screen_height * 0.15;
            draw_text_transformed_color(_x, _y, 
                "Being the first to get 10 kills wins!", 
                0.375, 0.375, 0,
                c_white, c_white, c_white, c_white, _alpha
            );
            
            _y = global.screen_height * 0.2;
            draw_text_transformed_color(_x, _y, 
                string_ext("{0}: {1}", ["Kill", floor(game.user_list[game.client.player].kill)]), 
                0.5, 0.5, 0,
                c_white, c_white, c_white, c_white, _alpha
            );
            
            _y = global.screen_height * 0.225;
            draw_text_transformed_color(_x, _y, 
                string_ext("{0}: {1}", ["Death", floor(game.user_list[game.client.player].death)]), 
                0.5, 0.5, 0,
                c_white, c_white, c_white, c_white, _alpha
            );
            
            _x = global.screen_width * 0.125;
            _y = global.screen_height * 0.75;
            _width = global.screen_width * 0.15;
            _height = global.screen_height * 0.05;

            _x1 = _x;
            _y1 = _y;
            _x2 = _x + _width;
            _y2 = _y + _height;
            _alpha = 0.75;
            _value = median(0, _player.unit_durability_draw/_player.unit.frame.durability_max, 1);
            
            draw_rectangle_line_vertex(_x1, _y1, _x2, _y2, 4, c_aqua, c_aqua, c_blue, c_blue, _alpha, _alpha, _alpha * 0.5, _alpha * 0.5);
            draw_rectangle_vertex(_x1, _y1, _x + _width * _value, _y2, c_aqua, c_aqua, c_blue, c_blue, _alpha, _alpha, _alpha, _alpha, false);
            
            draw_set_valign(fa_bottom);
            draw_set_halign(fa_left);
            draw_text_transformed_color(_x1, _y1 - 4, 
                game.user_list[game.client.player].name, 
                0.625, 0.625, 0,
                c_white, c_white, c_white, c_white, _alpha * 1.5
            );
            draw_set_halign(fa_right);
            draw_text_transformed_color(_x + _width * _value - 4, _y2 - 4, 
                round(_player.unit_durability_draw), 
                0.5, 0.5, 0,
                c_white, c_white, c_white, c_white, _alpha * 1.5
            );
            draw_set_valign(fa_top);
            draw_text_transformed_color(_x2 - 4, _y2 + 4, 
                round(_player.unit.frame.durability_max), 
                0.5, 0.5, 0,
                c_aqua, c_aqua, c_blue, c_blue, _alpha
            );
            draw_set_halign(fa_left);
            draw_text_transformed_color(_x1 + 4, _y2 + 4, 
                global.__unit[game.user_list[game.client.player].unit].name, 
                0.4, 0.4, 0,
                c_white, c_white, c_white, c_white, _alpha
            );
            
            camera_assign(0, camera3d_right);
            
            _x = global.screen_width * 0.875;
            _y = global.screen_height * 0.75;
            _width = global.screen_width * 0.005;
            _height = global.screen_height * 0.05;
            
            _x1 = _x - _width;
            _y1 = _y;
            _x2 = _x;
            _y2 = _y + _height;
            _space = global.screen_width * 0.002;
            _alpha = 0.75;
            _value = median(0, _player.unit_durability_draw/_player.unit.frame.durability_max, 1);
            
            _i = 0;
            repeat(_player.unit.weapon.magazine.amount_max) {
                draw_rectangle_line_vertex(_x1, _y1, _x2, _y2, 1, c_white, c_white, c_gray, c_gray, _alpha, _alpha, _alpha, _alpha);
                if(_i < _player.unit.weapon.magazine.amount) {
                    draw_rectangle_vertex(_x1, _y1, _x2, _y2, c_white, c_white, c_gray, c_gray, _alpha, _alpha, _alpha, _alpha, false);
                }
                if(_i < _player.unit.weapon.magazine.amount_max - 1) {
                    _x2 = _x2 - (_space + _width);
                    _x1 = _x2 - _width;
                }
                _i += 1;
            }
            
            _width = _x - _x1;
            _height = global.screen_height * 0.01;
            _space = global.screen_width * 0.002;
            
            _y1 = _y2 + 8;
            _y2 = _y1 + _height;
            if(_player.unit.weapon.magazine.reload) {
                _value = median(0, 1 - _player.unit.weapon.magazine.reload_time/_player.unit.weapon.magazine.reload_time_max, 1);
                _x1 = _x - _width;
                _x2 = _x;
                
                draw_rectangle_line_vertex(_x1, _y1, _x2, _y2, 1, c_white, c_white, c_gray, c_gray, _alpha, _alpha, _alpha, _alpha);
                draw_rectangle_vertex(_x2 - _width * _value, _y1, _x2, _y2, c_white, c_white, c_gray, c_gray, _alpha, _alpha, _alpha, _alpha, false);
            }
            else {
                _x1 = _x - _width;
                _x2 = _x;
                if(_player.unit.weapon.cool == 0 or _player.unit.weapon.period > 0) {
                    var __width = (_width - _space * (_player.unit.weapon.period_max - 1))/_player.unit.weapon.period_max;
                    var __x1 = _x - __width;
                    var __x2 = _x;
                    
                    _value = median(0, 1 - _player.unit.weapon.interval/_player.unit.weapon.interval_max, 1);
                    
                    _i = 0;
                    repeat(_player.unit.weapon.period_max) {
                        draw_rectangle_line_vertex(__x1, _y1, __x2, _y2, 1, c_white, c_white, c_gray, c_gray, _alpha, _alpha, _alpha, _alpha);
                        if(_player.unit.weapon.period > 0) {
                            if(_i < _player.unit.weapon.period) {
                                if(_i == _player.unit.weapon.period - 1) {
                                    draw_rectangle_vertex(__x1 + __width * _value, _y1, __x2, _y2, c_white, c_white, c_gray, c_gray, _alpha, _alpha, _alpha, _alpha, false);
                                }
                                else {
                                    draw_rectangle_vertex(__x1, _y1, __x2, _y2, c_white, c_white, c_gray, c_gray, _alpha, _alpha, _alpha, _alpha, false);
                                }
                            }
                        }
                        else {
                            draw_rectangle_vertex(__x1, _y1, __x2, _y2, c_white, c_white, c_gray, c_gray, _alpha, _alpha, _alpha, _alpha, false);
                        }
                        
                        __x2 = __x2 - __width - _space;
                        __x1 = __x2 - __width;
                        _i += 1;
                    }
                }
                else {
                    _value = median(0, _player.unit.weapon.cool/_player.unit.weapon.cool_max, 1);
                    
                    draw_rectangle_line_vertex(_x1, _y1, _x2, _y2, 1, c_white, c_white, c_gray, c_gray, _alpha, _alpha, _alpha, _alpha);
                    draw_rectangle_vertex(_x1 + _width * _value, _y1, _x2, _y2, c_white, c_white, c_gray, c_gray, _alpha, _alpha, _alpha, _alpha, false);
                }
            }
            
            _x1 = _x;
            _y1 = _y2;
            draw_set_valign(fa_top);
            draw_set_halign(fa_right);
            draw_text_transformed_color(_x1, _y1 + 4, 
                string_ext("{0}/{1}", [_player.unit.weapon.magazine.amount, _player.unit.weapon.magazine.amount_max]), 
                0.5, 0.5, 0,
                c_white, c_white, c_white, c_white, _alpha * 1.5
            );
            
            
            camera_assign(0, undefined);
            
            _x = camera_get_view_x(global.__camera);
            _y = camera_get_view_y(global.__camera);
            
            _value = max(0, -cursor_range + 32);
            draw_ring_vertex(_x + cursor_x, _y + cursor_y, 360, 4, cursor_range, cursor_range*1.2, c_white, c_white, 0.75, 0.75, 0, false);
            draw_ring_vertex(_x + cursor_x, _y + cursor_y, 360, 4, 0, _value, c_white, c_white, 1, 1, 0, false);
            draw_set_halign(fa_center);
            draw_set_valign(fa_bottom);
            if(_player.unit.dead) {
                cursor_range_target = 128;
                draw_text_transformed(_x + cursor_x, _y + cursor_y, "DEAD", 0.75, 0.75, 0);
                draw_set_valign(fa_top);
                draw_text_transformed(_x + cursor_x, _y + cursor_y + 4, string_format(_player.unit.respawn, 0, 1) + " sec", 0.5, 0.5, 0);
            }
            else {
                if(_player.unit.weapon.magazine.amount > 0) {
                    if(mouse_check_button(mb_left)) {
                        cursor_range_target = 24
                    }
                    else {
                        cursor_range_target = 48;
                    }
                    draw_set_valign(fa_top);
                    draw_text_transformed(_x + cursor_x, _y + cursor_y + cursor_range, floor(_player.unit.weapon.magazine.amount), 0.5, 0.5, 0);
                }
                else {
                    cursor_range_target = 48;
                    draw_text_transformed(_x + cursor_x, _y + cursor_y, "RELOAD", 0.75, 0.75, 0);
                    draw_set_valign(fa_top);
                    draw_text_transformed(_x + cursor_x, _y + cursor_y + 4, string_format(_player.unit.weapon.magazine.reload_time, 0, 1) + " sec", 0.5, 0.5, 0);
                }
            }
            
            _i = 0;
            repeat(array_length(game.player_list)) {
                var __player = game.player_list[_i];
                if(__player.unit.player != game.client.player) {
                    var _distance = point_distance(_player.x, _player.y, __player.x, __player.y);
                    var _direction = point_direction(_player.x, _player.y, __player.x, __player.y);
                    if(_distance > 720) {
                        _x1 = lengthdir_x(270, _direction);
                        _y1 = lengthdir_y(270, _direction);
                        draw_ring_vertex(_x + global.screen_width * 0.5 + _x1, _y + global.screen_height * 0.5 + _y1, 180, 2, 16, 20, c_orange, c_red, 0.5, 0.5, _direction - 90, false)
                    }
                    
                }
                _i += 1;
            }
        }
        break;
    case GAME_STAGE.GAME_END:
        //camera_assign(0, undefined);
        
        _x = 0//camera_get_view_x(global.__camera);
        _y = 0//camera_get_view_y(global.__camera);
        
        draw_set_color(c_black);
        draw_set_alpha(0.75);
        draw_rectangle(_x, _y, _x + 1280, _y + 720, true);
        
        draw_set_color(c_white);
        draw_set_alpha(1);
        draw_set_valign(fa_top);
        draw_set_halign(fa_left);
        
        var _user = undefined;
        var _kill = 0;
        _i = 0;
        repeat(array_length(game.user_list)) {
            var _k = game.user_list[_i].kill;
            if(_k > _kill) {
                _kill = _k;
                _user = game.user_list[_i].name;
            }
            _i += 1;
        }
        
        _x1 = 0//_x + global.screen_width * 0.05;
        _y1 = 0//_y + global.screen_height * 0.05;
        draw_text_transformed(_x1, _y1, string_ext("{0} Wins!", [_user]), 1, 1, 0);
        break;
}
camera_assign(0, undefined);