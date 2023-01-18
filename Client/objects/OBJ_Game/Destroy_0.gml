instance_destroy(interface);
instance_destroy(camera);

with(OBJ_Player) {
    instance_destroy(self);
}

with(OBJ_Projectile) {
    instance_destroy(self);
}