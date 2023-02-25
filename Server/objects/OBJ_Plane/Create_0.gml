game = noone;

plane_init = undefined;
plane_effect = new PlaneEffect();
plane = undefined;

user_input = new UserInput();

update = 1;

phy_fixed_rotation = true;


AddDamage = function(_damage) {
    update = 1;
    array_push(plane.damages, _damage);
}

AddEffect = function(_effect) {
    update = 1;
    array_push(plane.effects, _effect);
}