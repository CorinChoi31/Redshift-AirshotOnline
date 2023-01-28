#region
global.__frame = 60;
game_set_speed(global.__frame, gamespeed_fps);

global.__tick = 1;
global.__time = global.__tick/global.__frame;

global.tick = 0;
global.time = 0;
#endregion

#region
global.__passive = [];
global.__passive[0] = new InformationPassive("", "", -1);
#endregion

#region
global.__active = [];
global.__active[0] = new InformationActive("", "", -1, 1);
#endregion

#region
global.__projectile = [];
global.__projectile[0] = OBJ_Bullet;
global.__projectile[1] = OBJ_Missile;
#endregion

#region
global.__plane = [];
global.__plane[0] = new InformationPlane(
    "Patrol_24",
    "중화력 중거리 기동함선",
    "",
    1,
    new Plane(
        new PlaneFrame(180, 2, 3),
        new PlaneEngine(4.5, 6, 0.175, 360),
        new PlaneWeapon(0.3, 1, 1, 0, 0, 1,
            new PlaneWeaponProjectile(GAME_PROJECTILE.BULLET, 4, 4,
                new PlaneWeaponProjectileOnhit(8), 
                new PlaneWeaponProjectileForce(3, 25, 25, 0, 0, 0), 
                undefined
            ),
            new PlaneWeaponMagazine(10, 
                new PlaneWeaponMagazineReload(-1, 1.5)
            )
        )
    )
);

global.__plane[1] = new InformationPlane(
    "PAPER",
    "중화력 장거리 구축함선",
    "",
    2,
    new Plane(
        new PlaneFrame(140, 1, 2),
        new PlaneEngine(4, 4.5, 0.1, 270),
        new PlaneWeapon(0.4, 1, 1, 0, 0, 0,
            new PlaneWeaponProjectile(GAME_PROJECTILE.BULLET, 4, 4,
                new PlaneWeaponProjectileOnhit(12), 
                new PlaneWeaponProjectileForce(5, 35, 35, 0, 0, 0), 
                undefined
            ),
            new PlaneWeaponMagazine(8, 
                new PlaneWeaponMagazineReload(-1, 2)
            )
        )
    )
);

global.__plane[2] = new InformationPlane(
    "Marker",
    "저화력 장거리 기동함선",
    "",
    3,
    new Plane(
        new PlaneFrame(160, 1, 4),
        new PlaneEngine(8, 8, 0.2, 360),
        new PlaneWeapon(0.2, 2, 1, 0, 6, 0,
            new PlaneWeaponProjectile(GAME_PROJECTILE.BULLET, 4, 4,
                new PlaneWeaponProjectileOnhit(5), 
                new PlaneWeaponProjectileForce(3, 30, 30, 0, 0, 0), 
                undefined
            ),
            new PlaneWeaponMagazine(6, 
                new PlaneWeaponMagazineReload(-1, 0.5)
            )
        )
    )
);

global.__plane[3] = new InformationPlane(
    "==Patriot==",
    "고화력 장거리 구축함선",
    "",
    4,
    new Plane(
        new PlaneFrame(120, 1, 1),
        new PlaneEngine(4, 4, 0.125, 180),
        new PlaneWeapon(0.75, 1, 1, 0, 0, 0,
            new PlaneWeaponProjectile(GAME_PROJECTILE.BULLET, 4, 4,
                new PlaneWeaponProjectileOnhit(30), 
                new PlaneWeaponProjectileForce(4, 40, 40, 0, 0, 0), 
                undefined
            ),
            new PlaneWeaponMagazine(4, 
                new PlaneWeaponMagazineReload(-1, 2)
            )
        )
    )
);

global.__plane[4] = new InformationPlane(
    "BEARRER",
    "고화력 근거리 순항함선",
    "",
    5,
    new Plane(
        new PlaneFrame(200, 3, 6),
        new PlaneEngine(4.5, 1.5, 0.1, 240),
        new PlaneWeapon(0.8, 6, 2, 0.1, 0, 12,
            new PlaneWeaponProjectile(GAME_PROJECTILE.BULLET, 8, 8,
                new PlaneWeaponProjectileOnhit(5), 
                new PlaneWeaponProjectileForce(0.75, 20, 20, 0, 0, 0), 
                undefined
            ),
            new PlaneWeaponMagazine(24, 
                new PlaneWeaponMagazineReload(6, 0.5)
            )
        )
    )
);

global.__plane[5] = new InformationPlane(
    "Observer#1",
    "저화력 근거리 정찰선",
    "",
    6,
    new Plane(
        new PlaneFrame(150, 2, 8),
        new PlaneEngine(6, 6, 0.2, 480),
        new PlaneWeapon(0.1, 3, 1, 0, 12, 0,
            new PlaneWeaponProjectile(GAME_PROJECTILE.BULLET, 4, 4,
                new PlaneWeaponProjectileOnhit(2), 
                new PlaneWeaponProjectileForce(1, 35, 35, 0, 0, 0), 
                undefined
            ),
            new PlaneWeaponMagazine(15, 
                new PlaneWeaponMagazineReload(-1, 0.8)
            )
        )
    )
);

global.__plane[6] = new InformationPlane(
    "Observer#1",
    "저화력 근거리 정찰선",
    "",
    6,
    new Plane(
        new PlaneFrame(150, 2, 8),
        new PlaneEngine(6, 6, 0.2, 480),
        new PlaneWeapon(0.1, 3, 1, 0, 12, 0,
            new PlaneWeaponProjectile(GAME_PROJECTILE.MISSILE, 8, 64,
                new PlaneWeaponProjectileOnhit(2), 
                new PlaneWeaponProjectileForce(2, 5, 35, 20, 0.25, 720), 
                new PlaneWeaponProjectileSensor(true, 640, 60, 90)
            ),
            new PlaneWeaponMagazine(15, 
                new PlaneWeaponMagazineReload(-1, 0.8)
            )
        )
    )
);
#endregion