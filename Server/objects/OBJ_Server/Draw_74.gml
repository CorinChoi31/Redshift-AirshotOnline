var _i = 0;

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(16, 16, fps_real);
draw_text(16, 32, fps);

for(_i = 0; _i < array_length(console_log); _i++) {
    draw_text(16, 64 + 16 * _i, console_log[_i]);
}
if(console_work == undefined) {
    draw_text(16, 64 + 16 * _i, "> " + keyboard_string);
}
else {
    draw_text(16, 64 + 16 * _i, "< >");
}
