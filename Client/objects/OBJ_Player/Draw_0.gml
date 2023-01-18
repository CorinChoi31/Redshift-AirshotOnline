if(unit.player == game.client.player) {
    var _x = camera_get_view_x(global.__camera);
    var _y = camera_get_view_y(global.__camera);

    _x += (2500 - x) * 0.01;
    _y += (2500 - y) * 0.01;

    draw_rectangle_vertex(_x - 2500, _y - 2500, _x + 2500, _y + 2500, c_orange, c_purple, c_lime, c_blue, 0.25, 0.25, 0.25, 0.25);
}

draw_self();