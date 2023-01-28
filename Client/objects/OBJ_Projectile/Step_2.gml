var _delta_time = global.__time;

if(projectile.force.duration < 0) {
    instance_destroy(self);
}

projectile.force.duration -= _delta_time;