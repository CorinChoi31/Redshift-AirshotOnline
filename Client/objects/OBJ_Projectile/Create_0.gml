game = noone;

projectile = new Projectile(-1, -1, 0, 0, 0, 0, 0, 
    new ProjectileOnhit(0),
    new ProjectileForce(0, 0, 0, 0, 0, 0, 0),
    undefined
);
collided = false;

particle_emitter = part_emitter_create(global.particle_system);


x_previous = phy_position_x;
y_previous = phy_position_y;

phy_bullet = true;
phy_fixed_rotation = true;

image_alpha = 0;