function Client(_client_id="", _client_ip="", _user_id="") constructor {
    client_id = _client_id;
    client_ip = _client_ip;
    user_id = _user_id;
    
    update = -1;
}

#region 
function Game(
        _instance
    ) constructor {
    game = _instance;
    
    stage = GAME_STAGE.GAME_CREATE;
    time = 0;
    world = new GameWorld(5000, 36, 0);
    
    users = [];
    
    planes = [];
    projectiles = [];
    
    projectiles_index = 0;
    
    static Pack = function(_force_update=false) {
        var _planes = [];
        var _projectiles = [];
        var _i = 0;
        repeat(array_length(planes)) {
            if(!instance_exists(planes[_i])) {
                array_delete(planes, _i, 1);
                _i -= 1;
            }
            else {
                if(_force_update or planes[_i].update > 0) {
                    array_push(_planes, planes[_i].plane.Pack());
                }
            }
            _i += 1;
        }
        _i = 0;
        repeat(array_length(projectiles)) {
            if(!instance_exists(projectiles[_i])) {
                array_delete(projectiles, _i, 1);
                _i -= 1;
            }
            else {
                if(_force_update or projectiles[_i].update > 0) {
                    array_push(_projectiles, projectiles[_i].projectile.Pack());
                }
            }
            _i += 1;
        }
        return [
            string_format(stage, 0, 0), 
            string_format(time, 0, 2), 
            world.Pack(),
            array_map(users, function(element, index) { return element.Pack() }), 
            _planes, 
            _projectiles
        ];
    }
    
    static Unpack = function(_packet) {
        stage = real(_packet[0]);
        time = real(_packet[1]);
        world.Unpack(_packet[2]);
        
        var _u = _packet[3];
        var _pl = _packet[4];
        var _pj = _packet[5];
        
        var _instance = noone;
        var _i = 0;
        var _j = 0;
        
        _i = 0;
        repeat(max(array_length(users), array_length(_u))) {
            if(_i >= array_length(users)) {
                array_push(users, new User(""));
            }
            users[_i].Unpack(_u[_i]);
            _i += 1;
        }
        
        var _planes = [];
        array_copy(_planes, 0, _pl, 0, array_length(_pl));
        _instance = noone;
        _i = 0;
        _j = 0;
        repeat(array_length(planes)) {
            repeat(array_length(_planes)) {
                if(planes[_i].plane.player_index == real(_planes[_j][0])) {
                    planes[_i].plane.Unpack(_planes[_j]);
                    array_delete(_planes, _j, 1);
                    break;
                }
                _j += 1;
            }
            _i += 1;
        }
        repeat(array_length(_planes)) {
            var _plane = global.__plane[users[_i].status.plane_index].plane;
            var _sensor = _plane.weapon.projectile.sensor;
            if(_sensor != undefined) {
                _sensor = new PlaneWeaponProjectileSensor(_plane.weapon.projectile.sensor.trace_able, _plane.weapon.projectile.sensor.find_distance, _plane.weapon.projectile.sensor.find_angle, _plane.weapon.projectile.sensor.target_limit);
            }
            _instance = instance_create_layer(_planes[0][1], _planes[0][2], "Game", OBJ_Plane);
                _instance.game = game;
                
                _instance.plane_init = json_parse(json_stringify(_plane));
                
                _instance.plane_init.passive = new PlanePassive(users[_i].status.passive_index);
                _instance.plane_init.active = new PlaneActive(users[_i].status.active_index, global.__active[users[_i].status.active_index].cool);
                
                _instance.plane.passive = new PlanePassive(users[_i].status.passive_index);
                _instance.plane.active = new PlaneActive(users[_i].status.active_index, global.__active[users[_i].status.active_index].cool);
                
                _instance.plane.Unpack(_planes[0]);
            array_delete(_planes, 0, 1);
            array_push(planes, _instance);
            _i += 1;
        }
        
        var _projectiles = [];
        array_copy(_projectiles, 0, _pj, 0, array_length(_pj));
        _instance = noone;
        _i = 0;
        _j = 0;
        repeat(array_length(projectiles)) {
            if(!instance_exists(projectiles[_i])) {
                array_delete(projectiles, _i, 1);
                _i -= 1;
            }
            else {
                _j = 0;
                repeat(array_length(_projectiles)) {
                    if(projectiles[_i].projectile.projectile_index == real(_projectiles[_j][1])) {
                        projectiles[_i].projectile.Unpack(_projectiles[_j]);
                        array_delete(_projectiles, _j, 1);
                        break;
                    }
                    _j += 1;
                }
            }
            _i += 1;
        }
        repeat(array_length(_projectiles)) {
            _instance = instance_create_layer(_projectiles[0][3], _projectiles[0][4], "Game", global.__projectile[_projectiles[0][2]]);
                _instance.game = game;
                _instance.projectile.Unpack(_projectiles[0]);
            array_delete(_projectiles, 0, 1);
            array_push(projectiles, _instance);
        }
    }
}

function GameWorld(
        _range,
        _angle,
        _rotate
    ) constructor {
    range = _range;
    angle = _angle;
    rotate = _rotate;
    
    static Pack = function() {
        return [
            string_format(range, 0, 0),
            string_format(angle, 0, 0),
            string_format(rotate, 0, 0)
        ];
    }
    
    static Unpack = function(_packet) {
        range = real(_packet[0]);
        angle = real(_packet[1]);
        rotate = real(_packet[2]);
    }
}

function User(
        _name,
        _input=new UserInput(0, 0, false, false, false, false, false, false, false),
        _status=new UserStatus()
    ) constructor {
    name = _name;
    
    input = _input;
    status = _status;
    
    static Pack = function() {
        return [
            name, 
            input.Pack(), 
            status.Pack()
        ];
    }
    
    static Unpack = function(_packet) {
        name = _packet[0];
        
        input.Unpack(_packet[1]);
        status.Unpack(_packet[2]);
    }
}

function UserInput(
        _mouse_x=0,
        _mouse_y=0,
        _up=false,
        _left=false,
        _down=false,
        _right=false,
        _fire=false,
        _reload=false,
        _skill=false
    ) constructor {
    update = 0;
    
    x = _mouse_x;
    y = _mouse_y;
    
    up = _up;
    left = _left;
    down = _down;
    right = _right;
    
    fire = _fire;
    reload = _reload;
    skill = _skill;
    
    static Pack = function() {
        return [
            string_format(x, 0, 0),
            string_format(y, 0, 0),
            string_format(up, 0, 0),
            string_format(left, 0, 0),
            string_format(down, 0, 0),
            string_format(right, 0, 0),
            string_format(fire, 0, 0),
            string_format(reload, 0, 0),
            string_format(skill, 0, 0)
        ];
    }
    
    
    static Unpack = function(_packet) {
        update = 1;
        
        x = real(_packet[0]);
        y = real(_packet[1]);
    
        up = bool(_packet[2]);
        left = bool(_packet[3]);
        down = bool(_packet[4]);
        right = bool(_packet[5]);
    
        fire = bool(_packet[6]);
        reload = bool(_packet[7]);
        skill = bool(_packet[8]);
    }
}

function UserStatus(
    ) constructor {
    ready = false;
    
    plane_index = 0;
    passive_index = 0;
    active_index = 0;
    
    kill = 0;
    death = 0;
    
    static Pack = function() {
        return [
            string_format(ready, 0, 0),
            string_format(plane_index, 0, 0),
            string_format(passive_index, 0, 0),
            string_format(active_index, 0, 0),
            string_format(kill, 0, 0),
            string_format(death, 0, 0)
        ];
    }
    
    static Unpack = function(_packet) {
        ready = bool(_packet[0]);
        
        plane_index = real(_packet[1]);
        passive_index = real(_packet[2]);
        active_index = real(_packet[3]);
    
        kill = real(_packet[4]);
        death = real(_packet[5]);
    }
}

function Plane(
        _frame,
        _engine,
        _weapon
    ) constructor {
    player_index = -1;
    
    x = 0;
    y = 0;
    
    destroyed = false;
    
    frame = _frame;
    engine = _engine;
    weapon = _weapon;
    
    passive = new PlanePassive(0);
    active = new PlaneActive(0, 0);
    
    effects = [];
    damages = [];
    
    static Pack = function() {
        return [
            string_format(player_index, 0, 0),
            string_format(x, 0, 0),
            string_format(y, 0, 0),
            string_format(destroyed, 0, 0),
            frame.Pack(), 
            engine.Pack(), 
            weapon.Pack(),
            passive.Pack(), 
            active.Pack(),
            array_map(effects, function(element, index) { return element.Pack() })
        ];
    }
    
    static Unpack = function(_packet) {
        player_index = real(_packet[0]);
        
        x = real(_packet[1]);
        y = real(_packet[2]);
        
        destroyed = bool(_packet[3]);
        
        frame.Unpack(_packet[4]);
        engine.Unpack(_packet[5]);
        weapon.Unpack(_packet[6]);
        
        passive.Unpack(_packet[7]);
        active.Unpack(_packet[8]);
    
        effects = array_create_ext(array_length(_packet[9]), function(index) { return new Effect() });
        var _i = 0;
        repeat(array_length(_packet[9])) {
            effects[_i].Unpack(_packet[9][_i]);
            _i += 1;
        }
    }
}
function PlaneEffect() constructor {
    frame = new PlaneFrame_Effect();
    engine = new PlaneEngine_Effect();
    weapon = new PlaneWeapon_Effect();
    
    passive = new PlanePassive_Effect();
    active = new PlaneActive_Effect();
    
    static Clear = function() {
        frame.Clear();
        engine.Clear();
        engine.Clear();
        
        passive.Clear();
        active.Clear();
    }
}

function PlaneFrame(
        _durability_max,
        _durability_loss=2,
        _durability_fix=2
    ) constructor {
    collide_able = true;
    collide_size = 12;
    
    damage_able = true;
    damage_ratio = 1;
    
    durability = _durability_max;
    durability_max = _durability_max;
    durability_prev = _durability_max;
    durability_draw = _durability_max;
    durability_recover = _durability_max;
    durability_loss = _durability_loss;
    durability_fix = _durability_fix;
    
    static Pack = function() {
        return [
            string_format(collide_able, 0, 0),
            string_format(collide_size, 0, 0),
            string_format(damage_able, 0, 0),
            string_format(damage_ratio, 0, 2),
            string_format(durability, 0, 1),
            string_format(durability_max, 0, 1),
            string_format(durability_recover, 0, 1),
            string_format(durability_loss, 0, 1),
            string_format(durability_fix, 0, 1)
        ];
    }
    
    static Unpack = function(_packet) {
        collide_able = bool(_packet[0]);
        collide_size = real(_packet[1]);
    
        damage_able = bool(_packet[2]);
        damage_ratio = real(_packet[3]);
    
        durability = real(_packet[4]);
        durability_max = real(_packet[5]);
        durability_recover = real(_packet[6]);
        durability_loss = real(_packet[7]);
        durability_fix = real(_packet[8]);
    }
}
function PlaneFrame_Effect() constructor {
    collide_able = true;
    collide_size = 0;
    
    damage_able = true;
    damage_ratio = 0;
    
    durability_max = 0;
    durability_loss = 0;
    durability_fix = 0;
    
    static Clear = function() {
        collide_able = true;
        collide_size = 0;
    
        damage_able = true;
        damage_ratio = 0;
    
        durability_max = 0;
        durability_loss = 0;
        durability_fix = 0;
    }
}

function PlaneEngine(
        _linear_speed_max,
        _linear_speed_accel,
        _angular_speed_ratio,
        _angular_speed_limit
    ) constructor {
    move_able = true;
    
    linear_speed = 0;
    linear_speed_max = _linear_speed_max;
    linear_speed_accel = _linear_speed_accel;
    
    angular_direction = 0;
    angular_speed_ratio = _angular_speed_ratio;
    angular_speed_limit = _angular_speed_limit;
    
    static Pack = function() {
        return [
            string_format(move_able, 0, 0),
            string_format(linear_speed, 0, 0),
            string_format(linear_speed_max, 0, 0),
            string_format(linear_speed_accel, 0, 0),
            string_format(angular_direction, 0, 1),
            string_format(angular_speed_ratio, 0, 2),
            string_format(angular_speed_limit, 0, 0)
        ];
    }
    
    static Unpack = function(_packet) {
        move_able = bool(_packet[0]);
    
        linear_speed = real(_packet[1]);
        linear_speed_max = real(_packet[2]);
        linear_speed_accel = real(_packet[3]);
    
        angular_direction = real(_packet[4]);
        angular_speed_ratio = real(_packet[5]);
        angular_speed_limit = real(_packet[6]);
    }
}
function PlaneEngine_Effect() constructor {
    move_able = true;
    
    linear_speed_max = 0;
    linear_speed_accel = 0;
    
    angular_speed_ratio = 0;
    angular_speed_limit = 0;
    
    static Clear = function() {
        move_able = true;
    
        linear_speed_max = 0;
        linear_speed_accel = 0;
    
        angular_speed_ratio = 0;
        angular_speed_limit = 0;
    }
}

function PlaneWeapon(
        _cool,
        _amount,
        _period,
        _interval,
        _dispersion_linear,
        _dispersion_angular,
        _projectile,
        _magazine
    ) constructor {
    fire_able = true;
    
    damage_ratio = 1;
    
    cool = 0; // 모든 공격 주기 종료 후 카운트
    cool_max = _cool;
    amount = _amount; // 동시 발사
    period = 0; // 공격 횟수
    period_max = _period;
    interval = 0; // 공격 간격
    interval_max = _interval;
    dispersion_index = 0;
    dispersion_linear = _dispersion_linear;
    dispersion_angular = _dispersion_angular;
    
    projectile = _projectile;
    magazine = _magazine;
    
    static Pack = function() {
        return [
            string_format(fire_able, 0, 0),
            string_format(damage_ratio, 0, 2),
            string_format(cool, 0, 2),
            string_format(cool_max, 0, 2),
            string_format(amount, 0, 0),
            string_format(period, 0, 0),
            string_format(period_max, 0, 0),
            string_format(interval, 0, 2),
            string_format(interval_max, 0, 2),
            string_format(dispersion_linear, 0, 0),
            string_format(dispersion_angular, 0, 1),
            projectile.Pack(),
            magazine.Pack()
        ];
    }
    
    static Unpack = function(_packet) {
        fire_able = bool(_packet[0]);
    
        damage_ratio = real(_packet[1]);
    
        cool = real(_packet[2]);
        cool_max = real(_packet[3]);
        amount = real(_packet[4]);
        period = real(_packet[5]);
        period_max = real(_packet[6]);
        interval = real(_packet[7]);
        interval_max = real(_packet[8]);
        dispersion_linear = real(_packet[9]);
        dispersion_angular = real(_packet[10]);
        
        projectile.Unpack(_packet[11]);
        magazine.Unpack(_packet[12]);
    }
}
function PlaneWeapon_Effect() constructor {
    fire_able = true;
    
    damage_ratio = 0;
    
    cool_max = 0;
    amount = 0;
    period_max = 0;
    interval_max = 0;
    dispersion_linear = 0;
    dispersion_angular = 0;
    
    projectile = new PlaneWeaponProjectile_Effect();
    magazine = new PlaneWeaponMagazine_Effect();
    
    static Clear = function() {
        fire_able = true;
    
        damage_ratio = 0;
    
        cool_max = 0;
        amount = 0;
        period_max = 0;
        interval_max = 0;
        dispersion_linear = 0;
        dispersion_angular = 0;
        
        projectile.Clear();
        magazine.Clear();
    }
}

function PlaneWeaponProjectile(
        _object,
        _collide_size,
        _collide_size_max,
        _onhit,
        _force,
        _sensor=undefined
    ) constructor {
    object = _object;
    
    collide_size = _collide_size;
    collide_size_max = _collide_size_max;
    
    onhit = _onhit;
    force = _force;
    sensor = _sensor;
    
    static Pack = function() {
        var _sensor = sensor ?? "";
        if(_sensor != "") {
            _sensor = sensor.Pack();
        }
        return [
            string_format(object, 0, 0),
            string_format(collide_size, 0, 0),
            string_format(collide_size_max, 0, 0),
            onhit.Pack(),
            force.Pack(),
            _sensor
        ];
    }
    
    static Unpack = function(_packet) {
        object = real(_packet[0]);
        
        collide_size = real(_packet[1]);
        collide_size_max = real(_packet[2]);
        
        onhit.Unpack(_packet[3]);
        force.Unpack(_packet[4]);
        
        if(_packet[5] == "") {
            sensor = undefined;
        }
        else {
            sensor = sensor ?? new PlaneWeaponProjectileSensor();
            sensor.Unpack(_packet[5]);
        }
    }
}
function PlaneWeaponProjectile_Effect() constructor {
    collide_size = 0;
    collide_size_max = 0;
    
    onhit = new PlaneWeaponProjectileOnhit_Effect();
    force = new PlaneWeaponProjectileForce_Effect();
    
    static Clear = function() {
        collide_size = 0;
        collide_size_max = 0;
        
        onhit.Clear();
        force.Clear();
    }
}

function PlaneWeaponProjectileOnhit(
        _type,
        _damage
    ) constructor {
    type = _type;
    damage = _damage;
    
    static Pack = function() {
        return [
            string_format(type, 0, 0),
            string_format(damage, 0, 1)
        ];
    }
    
    static Unpack = function(_packet) {
        type = real(_packet[0]);
        damage = real(_packet[1]);
    }
}
function PlaneWeaponProjectileOnhit_Effect() constructor {
    damage = 0;
    
    static Clear = function() {
        damage = 0;
    }
}

function PlaneWeaponProjectileForce(
        _duration,
        _linear_speed,
        _linear_speed_max,
        _linear_speed_accel=0,
        _angular_speed_ratio=0.1,
        _angular_speed_limit=90
    ) constructor {
    duration_max = _duration;
    
    linear_speed = _linear_speed;
    linear_speed_max = _linear_speed_max;
    linear_speed_accel = _linear_speed_accel;
    
    angular_speed_ratio = _angular_speed_ratio;
    angular_speed_limit = _angular_speed_limit;
    
    static Pack = function() {
        return [
            string_format(duration_max, 0, 2),
            string_format(linear_speed, 0, 1),
            string_format(linear_speed_max, 0, 1),
            string_format(linear_speed_accel, 0, 1),
            string_format(angular_speed_ratio, 0, 2),
            string_format(angular_speed_limit, 0, 0)
        ];
    }
    
    static Unpack = function(_packet) {
        duration_max = real(_packet[0]);
        
        linear_speed = real(_packet[1]);
        linear_speed_max = real(_packet[2]);
        linear_speed_accel = real(_packet[3]);
        
        angular_speed_ratio = real(_packet[4]);
        angular_speed_limit = real(_packet[5]);
    }
}
function PlaneWeaponProjectileForce_Effect() constructor {
    duration_max = 0;
    
    linear_speed = 0;
    linear_speed_max = 0;
    linear_speed_accel = 0;
    
    angular_speed_ratio = 0;
    angular_speed_limit = 0;
    
    static Clear = function() {
        duration_max = 0;
    
        linear_speed = 0;
        linear_speed_max = 0;
        linear_speed_accel = 0;
    
        angular_speed_ratio = 0;
        angular_speed_limit = 0;
    }
}

function PlaneWeaponProjectileSensor(
        _trace_able,
        _find_distance,
        _find_angle,
        _target_limit
    ) constructor {
    trace_able = _trace_able;
    
    find_distance = _find_distance;
    find_angle = _find_angle;
    
    target_limit = _target_limit;
    
    static Pack = function() {
        return [
            string_format(trace_able, 0, 0),
            string_format(find_distance, 0, 0),
            string_format(find_angle, 0, 0),
            string_format(target_limit, 0, 0)
        ];
    }
    
    static Unpack = function(_packet) {
        trace_able = bool(_packet[0]);
        
        find_distance = real(_packet[1]);
        find_angle = real(_packet[2]);
        
        target_limit = real(_packet[3]);
    }
}

function PlaneWeaponMagazine(
        _amount,
        _reload
    ) constructor {
    amount = _amount;
    amount_max = _amount;
    
    reload = _reload;
    
    static Pack = function() {
        return [
            string_format(amount, 0, 0),
            string_format(amount_max, 0, 0),
            reload.Pack()
        ];
    }
    
    static Unpack = function(_packet) {
        amount = real(_packet[0]);
        amount_max = real(_packet[1]);
        
        reload.Unpack(_packet[2]);
    }
}
function PlaneWeaponMagazine_Effect() constructor {
    amount_max = 0;
    
    reload = new PlaneWeaponMagazineReload_Effect();
    
    static Clear = function() {
        amount_max = 0;
    
        reload.Clear();
    }
}

function PlaneWeaponMagazineReload(
        _amount,
        _cool
    ) constructor {
    reload_able = true;
    reload_ing = false;
    
    amount = _amount;
    
    cool = 0;
    cool_max = _cool;
    
    static Pack = function() {
        return[
            string_format(reload_able, 0, 0),
            string_format(reload_ing, 0, 0),
            string_format(amount, 0, 0),
            string_format(cool, 0, 2),
            string_format(cool_max, 0, 2)
        ];
    }
    
    static Unpack = function(_packet) {
        reload_able = bool(_packet[0]);
        reload_ing = real(_packet[1]);
        
        amount = real(_packet[2]);
    
        cool = real(_packet[3]);
        cool_max = real(_packet[4]);
    }
}
function PlaneWeaponMagazineReload_Effect() constructor {
    reload_able = true;
    
    amount = 0;
    
    cool_max = 0;
    
    static Clear = function() {
        reload_able = true;
    
        amount = 0;
    
        cool_max = 0;
    }
}

function Projectile(
        _player_index,
        _projectile_index,
        _object,
        _x,
        _y,
        _collide_size,
        _collide_size_max,
        _onhit,
        _force,
        _sensor=undefined
    ) constructor {
    
    player_index = _player_index;
    projectile_index = _projectile_index;
    
    object = _object;
    
    x = _x;
    y = _y;
    
    collided = false;
    collide_size = _collide_size;
    collide_size_max = _collide_size_max;
    
    onhit = _onhit;
    force = _force;
    sensor = _sensor;
    
    static Pack = function() {
        var _sensor = sensor ?? "";
        if(_sensor != "") {
            _sensor = sensor.Pack();
        }
        return [
            string_format(player_index, 0, 0),
            string_format(projectile_index, 0, 0),
            string_format(object, 0, 0),
            string_format(x, 0, 0),
            string_format(y, 0, 0),
            string_format(collided, 0, 0),
            string_format(collide_size, 0, 0),
            string_format(collide_size_max, 0, 0),
            onhit.Pack(),
            force.Pack(),
            _sensor
        ];
    }
    
    static Unpack = function(_packet) {
        player_index = real(_packet[0]);
        projectile_index = real(_packet[1]);
    
        object = real(_packet[2]);
    
        x = real(_packet[3]);
        y = real(_packet[4]);
    
        collided = bool(_packet[5]);
        collide_size = real(_packet[6]);
        collide_size_max = real(_packet[7]);
        
        onhit.Unpack(_packet[8]);
        force.Unpack(_packet[9]);
        
        if(_packet[10] == "") {
            sensor = undefined;
        }
        else {
            sensor = sensor ?? new ProjectileSensor();
            sensor.Unpack(_packet[10]);
        }
    }
}

function ProjectileOnhit(
        _type,
        _damage
    ) constructor {
    type = _type;
    damage = _damage;
    
    static Pack = function() {
        return [
            string_format(type, 0, 0),
            string_format(damage, 0, 0)
        ];
    }
    
    static Unpack = function(_packet) {
        type = real(_packet[0]);
        damage = real(_packet[1]);
    }
}

function ProjectileForce(
        _duration_max,
        _linear_speed,
        _linear_speed_max,
        _linear_speed_accel,
        _angular_direction,
        _angular_speed_ratio,
        _angular_speed_limit
    ) constructor {
    duration = _duration_max;
    duration_max = _duration_max;
    
    linear_speed = _linear_speed;
    linear_speed_max = _linear_speed_max;
    linear_speed_accel = _linear_speed_accel;
    
    angular_direction = _angular_direction;
    angular_speed_ratio = _angular_speed_ratio;
    angular_speed_limit = _angular_speed_limit;
    
    static Pack = function() {
        return [
            string_format(duration, 0, 2),
            string_format(duration_max, 0, 2),
            string_format(linear_speed, 0, 1),
            string_format(linear_speed_max, 0, 1),
            string_format(linear_speed_accel, 0, 1),
            string_format(angular_direction, 0, 1),
            string_format(angular_speed_ratio, 0, 2),
            string_format(angular_speed_limit, 0, 0)
        ];
    }
    
    static Unpack = function(_packet) {
        duration = real(_packet[0]);
        duration_max = real(_packet[1]);
    
        linear_speed = real(_packet[2]);
        linear_speed_max = real(_packet[3]);
        linear_speed_accel = real(_packet[4]);
    
        angular_direction = real(_packet[5]);
        angular_speed_ratio = real(_packet[6]);
        angular_speed_limit = real(_packet[7]);
    }
}

function ProjectileSensor(
        _find_distance,
        _find_angle,
        _target_limit
    ) constructor {
    trace_able = true;
    trace_ing = false;
    
    find_distance = _find_distance;
    find_angle = _find_angle;
    
    target_index = -1;
    target_x = 0;
    target_y = 0;
    target_limit = _target_limit;
    
    static Pack = function() {
        return [
            string_format(trace_ing, 0, 0),
            string_format(target_id, 0, 0),
            string_format(target_x, 0, 0),
            string_format(target_y, 0, 0),
            string_format(target_limit, 0, 0)
        ];
    }
    
    static Unpack = function(_packet) {
        trace_ing = real(_packet[0]);
        target_id = real(_packet[1]);
        target_x = real(_packet[2]);
        target_y = real(_packet[3]);
        target_limit = real(_packet[4]);
    }
}

function PlanePassive(
        _index
    ) constructor {
    use_able = true;
    
    index = _index;
    effect_index = -1;
    
    static Pack = function() {
        return [
            string_format(use_able, 0, 0),
            string_format(index, 0, 0)
        ];
    }
    
    static Unpack = function(_packet) {
        use_able = bool(_packet[0]);

        index = real(_packet[1]);
    }
}
function PlanePassive_Effect() constructor {
    use_able = true;
    
    static Clear = function() {
        use_able = true;
    }
}

function PlaneActive(
        _index,
        _cool
    ) constructor {
    use_able = true;
    
    index = _index;
    effect_index = -1;
    
    cool = _cool;
    cool_max = _cool;
    
    static Pack = function() {
        return [
            string_format(use_able, 0, 0),
            string_format(index, 0, 0),
            string_format(cool, 0, 2),
            string_format(cool_max, 0, 2)
        ];
    }
    
    static Unpack = function(_packet) {
        use_able = bool(_packet[0]);
        
        index = bool(_packet[1]);
        
        cool = bool(_packet[2]);
        cool_max = bool(_packet[3]);
    }
}
function PlaneActive_Effect() constructor {
    use_able = true;
    
    cool_max = 0;
    
    static Clear = function() {
        use_able = true;
        
        cool_max = 0;
    }
}


function Effect(
        _sender,
        _index,
        _amount,
        _duration,
        _infinite=false
    ) constructor {
    sender = _sender;
    index = _index;
    enable = false;
    amount = _amount;
    amount_init = _amount;
    duration = _duration;
    duration_init = _duration;
    infinite = _infinite;
    static Pack = function() {
        return [
            string_format(sender, 0, 0),
            string_format(index, 0, 0),
            string_format(enable, 0, 0),
            string_format(amount, 0, 1),
            string_format(amount_init, 0, 1)
        ];
    }
    
    static Unpack = function(_packet) {
        sender = real(_packet[0]);
        index = real(_packet[1]);
        enable = bool(_packet[2]);
        amount = real(_packet[3]);
        amount_init = real(_packet[4]);
    }
}

function Damage(
        _sender, 
        _type, 
        _amount
    ) constructor {
    sender = _sender;
    type = _type;
    amount = _amount;
    
    static Pack = function() {
        return [
            string_format(sender, 0, 0),
            string_format(type, 0, 0),
            string_format(amount, 0, 1)
        ];
    }
    
    static Unpack = function(_packet) {
        sender = real(_packet[0]);
        type = real(_packet[1]);
        amount = real(_packet[2]);
    }
}
#endregion

#region Information
function InformationPlane(
        _name,
        _description,
        _novel,
        _subimg,
        _plane
    ) constructor {
    
    name = _name;
    description = _description;
    novel = _novel;
    
    subimg = _subimg;
    
    plane = _plane;
}

function InformationPassive(
        _name,
        _description,
        _subimg
    ) constructor {
    name = _name;
    description = _description;
    
    subimg = _subimg;
}

function InformationActive(
        _name,
        _description,
        _subimg,
        _cool
    ) constructor {
    name = _name;
    description = _description;
    
    subimg = _subimg;
    
    cool = _cool;
}
#endregion