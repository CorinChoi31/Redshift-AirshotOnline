if(target != noone) {
    if(instance_exists(target)) {
        target_x = target.x;
        target_y = target.y;
        
        if(target_mouse) {
            target_x += (mouse_x - target_x) * 0.125;
            target_y += (mouse_y - target_y) * 0.125;
        }
        
        target_x -= width/2;
        target_y -= height/2;
    }
    else {
        target = noone;
    }
}

if(width != target_width) {
    width = lerp(width, target_width, velocity_size);
}

if(height != target_height) {
    height = lerp(height, target_height, velocity_size);
}

if(x != target_x) {
    x = lerp(x, target_x, velocity_pos);
}

if(y != target_y) {
    y = lerp(y, target_y, velocity_pos);
}


camera_set_view_pos(view_camera[0], x, y);
camera_set_view_size(view_camera[0], width, height);