game = noone;

plane_init = undefined;
plane_effect = new PlaneEffect();
plane = new Plane(
    new PlaneFrame(1, 0, 0),
    new PlaneEngine(0, 0, 0, 0),
    new PlaneWeapon(0, 0, 0, 0, 0, 0,
        new PlaneWeaponProjectile(0, 0, 0,
            new PlaneWeaponProjectileOnhit(0), 
            new PlaneWeaponProjectileForce(0, 0, 0), 
            undefined
        ),
        new PlaneWeaponMagazine(0, 
            new PlaneWeaponMagazineReload(-1, 0)
        )
    )
);

user_input = new UserInput();

particle_emitter = part_emitter_create(global.particle_system);


phy_fixed_rotation = true;

image_speed = 0;

alarm[0] = 5;