var _delta_time = global.__time;

if(duration > 0) {
    alpha += -alpha/max(duration * global.__frame, 2);
    
    x = lerp(x, target_x, velocity);
    y = lerp(y, target_x, velocity);
}
else {
    duration -= _delta_time;
}