var _delta_time = global.__time;

if(projectile.duration < 0) {
    instance_destroy(self);
}

projectile.duration -= _delta_time;
