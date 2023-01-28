game = noone;

projectile = new Projectile(-1, -1, -1, 0, 0, 2, 
    new ProjectileOnhit(0),
    new ProjectileForce(0, 0, 0, 0, 0, 0, 0),
    undefined
);

phy_bullet = true;
phy_fixed_rotation = true;