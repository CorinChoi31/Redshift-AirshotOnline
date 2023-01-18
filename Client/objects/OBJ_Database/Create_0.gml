#region
global.__frame = 60;
game_set_speed(global.__frame, gamespeed_fps);

global.__tick = 1;
global.__time = global.__tick/global.__frame;

global.tick = 0;
global.time = 0;

global.__screen_width = 1280;
global.__screen_height = 720;

global.screen_width = 1280;
global.screen_height = 720;

global.__camera = undefined;
global.__camera_index = 0;
#endregion

#region
global.__unit = [];

global.__unit[0] = new UnitData(
    "Patrol_24",
    "중화력 중거리 기동함선",
    "",
    1,
    new Unit(
        new Frame(180),
        new Engine(4, 5, 180),
        new Weapon(
            0.5, 1, 1, 0, 0,
            new Projectile(OBJ_Bullet, 5, 3, 20),
            new Magazine(10, 2)
        )
    )
);

global.__unit[1] = new UnitData(
    "PAPER",
    "중화력 장거리 구축함선",
    "",
    2,
    new Unit(
        new Frame(160),
        new Engine(2, 4.5, 90),
        new Weapon(
            0.8, 1, 1, 0, 0,
            new Projectile(OBJ_Bullet, 15, 2, 25),
            new Magazine(8, 2.5)
        )
    )
);

global.__unit[2] = new UnitData(
    "Marker",
    "저화력 장거리 기동함선",
    "",
    3,
    new Unit(
        new Frame(160),
        new Engine(8, 5.5, 180),
        new Weapon(
            1, 1, 2, 0.25, 0,
            new Projectile(OBJ_Bullet, 4, 5, 30),
            new Magazine(6, 0.5)
        )
    )
);

global.__unit[3] = new UnitData(
    "==Patriot==",
    "고화력 장거리 구축함선",
    "",
    4,
    new Unit(
        new Frame(100),
        new Engine(2, 4, 90),
        new Weapon(
            1.2, 1, 1, 0, 0,
            new Projectile(OBJ_Bullet, 40, 5, 30),
            new Magazine(4, 2)
        )
    )
);

global.__unit[4] = new UnitData(
    "BEARRER",
    "고화력 근거리 순항함선",
    "",
    5,
    new Unit(
        new Frame(240),
        new Engine(3, 3, 120),
        new Weapon(
            1, 8, 1, 0, 10,
            new Projectile(OBJ_Bullet, 8, 1.25, 20),
            new Magazine(24, 0.2, 1)
        )
    )
);

global.__unit[5] = new UnitData(
    "Observer#1",
    "저화력 근거리 정찰선",
    "",
    6,
    new Unit(
        new Frame(120),
        new Engine(6, 6, 240),
        new Weapon(
            0.25, 1, 3, 0.1, 1,
            new Projectile(OBJ_Bullet, 1, 1.5, 24),
            new Magazine(15, 0.5)
        )
    )
);
#endregion

global.__font = font_add_sprite_ext(SPR_Font, "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{:}~", true, 4);