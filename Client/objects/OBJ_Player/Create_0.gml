game = noone;

unit = json_parse(json_stringify(global.__unit[0]));
input = new Input();


particle_emitter = part_emitter_create(global.particle_system);

image_speed = 0;


draw_velocity = 0.1;
unit_durability_draw = 0;


alarm[0] = 5;