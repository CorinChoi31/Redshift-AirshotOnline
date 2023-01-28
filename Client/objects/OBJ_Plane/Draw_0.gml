if(plane.player_index == game.client.player) {
    var _x = camera_get_view_x(global.__camera);
    var _y = camera_get_view_y(global.__camera);

    _x += (10000 - phy_position_x) * 0.01;
    _y += (10000 - phy_position_y) * 0.01;

    draw_rectangle_vertex(_x - 5000, _y - 5000, _x + 5000, _y + 5000, c_orange, c_purple, c_lime, c_blue, 0.25, 0.25, 0.25, 0.25);
}

draw_sprite_ext(sprite_index, image_index, plane.x, plane.y, 1, 1, plane.engine.angular_direction, c_white, 1);