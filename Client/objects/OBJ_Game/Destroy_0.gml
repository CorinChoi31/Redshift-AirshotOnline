//instance_destroy(interface);
instance_destroy(camera);

with(OBJ_World) {
    instance_destroy(world);
}

with(OBJ_Plane) {
    instance_destroy(self);
}

with(OBJ_Projectile) {
    instance_destroy(self);
}