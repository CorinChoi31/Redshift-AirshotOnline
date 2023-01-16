#region
global.__frame = 60;
game_set_speed(global.__frame, gamespeed_fps);

global.__tick = 1;
global.__time = global.__tick/global.__frame;

global.tick = 0;
global.time = 0;
#endregion

#region
global.__unit = [];
    
global.__unit[0] = new Unit(
    "A",
    new Frame(100),
    new Engine(3, 5, 180),
    new Weapon(
        0.2, 2, 3, 0.1, 2,
        new Projectile(OBJ_Bullet, 10, 2, 10),
        new Magazine(10, 2)
    )
);
#endregion

global.__font = font_add_sprite_ext(SPR_Font, "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{:}~", true, 4);