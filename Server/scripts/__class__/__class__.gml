function Client(_client_id="", _client_ip="", _user_id="") constructor {
    client_id = _client_id;
    client_ip = _client_ip;
    user_id = _user_id;
}

#region Packed Packet
function PacketGame(
        _stage,
        _time,
        _packet_world,
        _users=[],
        _planes=[],
        _projectiles=[]
    ) constructor {
    
    s = string_format(_stage, 0, 0);
    t = string_format(_time, 0, 2);
    _w = _packet_world;
    
    ur = _users;
    
    pl = _planes;
    pj = _projectiles;
}

function PacketGameWorld(
        _range,
        _angle,
        _rotate
    ) constructor {
    r = string_format(_range, 0, 0);
    a = string_format(_angle, 0, 0);
    rt = string_format(_rotate, 0, 0);
}

function PacketUser(
        _name,
        _packet_input,
        _packet_status
    ) constructor {
    n = _name;
    
    _i = _packet_input;
    _s = _packet_status;
}

function PacketUserInput(
        _mouse_x,
        _mouse_y,
        _move_up,
        _move_left,
        _move_down,
        _move_right,
        _fire,
        _reload,
        _skill
    ) constructor {
    x = string_format(_mouse_x, 0, 0);
    y = string_format(_mouse_y, 0, 0);
    
    up = string_format(_move_up, 0, 0);
    lt = string_format(_move_left, 0, 0);
    dw = string_format(_move_down, 0, 0);
    rt = string_format(_move_right, 0, 0);
    
    fr = string_format(_fire, 0, 0);
    rd = string_format(_reload, 0, 0);
    sk = string_format(_skill, 0, 0);
}

function PacketUserStatus(
        _ready,
        _plane_index,
        _passive_index,
        _active_index,
        _kill,
        _death
    ) constructor {
    r = string_format(_ready, 0, 0);
    p = string_format(_plane_index, 0, 0);
    pk = string_format(_passive_index, 0, 0);
    ak = string_format(_active_index, 0, 0);
    k = string_format(_kill, 0, 0);
    d = string_format(_death, 0, 0);
}

function PacketPlane(
        _player_index,
        _x,
        _y,
        _destroyed,
        _packet_frame,
        _packet_engine,
        _packet_weapon,
        _packet_passive,
        _packet_active,
        _effects
    ) constructor {
    i = string_format(_player_index, 0, 0);
    
    x = string_format(_x, 0, 0);
    y = string_format(_y, 0, 0);
    
    d = string_format(_destroyed, 0, 0);
    
    _f = _packet_frame;
    _e = _packet_engine;
    _w = _packet_weapon;
    
    _pk = _packet_passive;
    _ak = _packet_active;
    
    e = _effects;
}

function PacketPlaneFrame(
        _collide_able,
        _collide_size,
        _damage_able,
        _damage_ratio,
        _durability,
        _durability_max,
        _durability_recover,
        _durability_loss,
        _durability_fix
    ) constructor {
    ca = string_format(_collide_able, 0, 0);
    cs = string_format(_collide_size, 0, 0);
    
    da = string_format(_damage_able, 0, 0);
    dr = string_format(_damage_ratio, 0, 2);
    
    d = string_format(_durability, 0, 2);
    dx = string_format(_durability_max, 0, 2);
    dr = string_format(_durability_recover, 0, 2);
    dl = string_format(_durability_loss, 0, 1);
    df = string_format(_durability_fix, 0, 1);
}

function PacketPlaneEngine(
        _move_able,
        _linear_speed,
        _linear_speed_max,
        _linear_speed_accel,
        _angular_direction,
        _angular_speed_ratio,
        _angular_speed_limit
    ) constructor {
    ma = string_format(_move_able, 0, 0);
    
    l = string_format(_linear_speed, 0, 2);
    lx = string_format(_linear_speed_max, 0, 2);
    la = string_format(_linear_speed_accel, 0, 2);
    
    a = string_format(_angular_direction, 0, 2);
    ar = string_format(_angular_speed_ratio, 0, 2);
    al = string_format(_angular_speed_limit, 0, 0);
}

function PacketPlaneWeapon(
        _fire_able,
        _damage_ratio,
        _cool,
        _cool_max,
        _amount,
        _period,
        _period_max,
        _interval,
        _interval_max,
        _dispersion_linear,
        _dispersion_angular,
        _packet_projectile,
        _packet_magazine
    ) constructor {
    fa = _fire_able;
    
    dr = _damage_ratio;
    
    c = string_format(_cool, 0, 2);
    cx = string_format(_cool_max, 0, 2);
    a = string_format(_amount, 0, 0);
    p = string_format(_period, 0, 0);
    px = string_format(_period_max, 0, 0);
    i = string_format(_interval, 0, 2);
    ix = string_format(_interval_max, 0, 2);
    dl = string_format(_dispersion_linear, 0, 0);
    da = string_format(_dispersion_angular, 0, 2);
    
    _p = _packet_projectile;
    _m = _packet_magazine;
}


function PacketPlaneWeaponProjectile(
        _object,
        _collide_size,
        _collide_size_max,
        _packet_onhit,
        _packet_force,
        _packet_sensor
    ) constructor {
    o = string_format(_object, 0, 0);
    
    cs = string_format(_collide_size, 0, 2);
    cx = string_format(_collide_size_max, 0, 2);
    
    _o = _packet_onhit;
    _f = _packet_force;
    _s = _packet_sensor;
}

function PacketPlaneWeaponProjectileOnhit(
        _damage
    ) constructor {
    d = string_format(_damage, 0, 2);
}

function PacketPlaneWeaponProjectileForce(
        _duration_max,
        _linear_speed,
        _linear_speed_max,
        _linear_speed_accel,
        _angular_speed_ratio,
        _angular_speed_limit
    ) constructor {
    dx = string_format(_duration_max, 0, 2);
    
    l = string_format(_linear_speed, 0, 2);
    lx = string_format(_linear_speed_max, 0, 2);
    la = string_format(_linear_speed_accel, 0, 2);
    
    ar = string_format(_angular_speed_ratio, 0, 2);
    al = string_format(_angular_speed_limit, 0, 0);
}

function PacketPlaneWeaponProjectileSensor(
        _trace_able,
        _find_distance,
        _find_angle,
        _target_limit
    ) constructor {
    ta = string_format(_trace_able, 0, 0);
    
    fd = string_format(_find_distance, 0, 0);
    fa = string_format(_find_angle, 0, 0);
    
    tl = string_format(_target_limit, 0, 0);
}

function PacketPlaneWeaponMagazine(
        _amount,
        _amount_max,
        _packet_reload
    ) constructor {
    a = string_format(_amount, 0, 0);
    ax = string_format(_amount_max, 0, 0);
    
    _r = _packet_reload;
}

function PacketPlaneWeaponMagazineReload(
        _reload_able,
        _reload_ing,
        _amount,
        _cool,
        _cool_max
    ) constructor {
    ra = string_format(_reload_able, 0, 0);
    rn = string_format(_reload_ing, 0, 0);
    
    a = string_format(_amount, 0, 0);
    
    c = string_format(_cool, 0, 2);
    cx = string_format(_cool_max, 0, 2);
}

function PacketProjectile(
        _player_index,
        _projectile_index,
        _object,
        _x,
        _y,
        _collided,
        _collide_size,
        _collide_size_max,
        //_packet_onhit,
        _packet_force
        //_packet_sensor
    ) constructor {
    i = string_format(_player_index, 0, 0)
    p = string_format(_projectile_index, 0, 0);
    
    o = string_format(_object, 0, 0);
    x = string_format(_x, 0, 0);
    y = string_format(_y, 0, 0);
    
    c = string_format(_collided, 0, 0);
    cs = string_format(_collide_size, 0, 0);
    cx = string_format(_collide_size_max, 0, 0);
    
    //_o = _packet_onhit;
    _f = _packet_force;
    //_s = _packet_sensor;
}

function PacketProjectileOnhit(
        _damage
    ) constructor {
    d = string_format(_damage, 0, 0);
}

function PacketProjectileForce(
        _duration,
        _duration_max,
        _linear_speed,
        _linear_speed_max,
        _linear_speed_accel,
        _angular_direction,
        _angular_speed_ratio,
        _angular_speed_limit
    ) constructor {
    d = string_format(_duration, 0, 1);
    dx = string_format(_duration_max, 0, 1);
    
    l = string_format(_linear_speed, 0, 1);
    lx = string_format(_linear_speed_max, 0, 1);
    la = string_format(_linear_speed_accel, 0, 1);
    
    a = string_format(_angular_direction, 0, 1);
    ar = string_format(_angular_speed_ratio, 0, 1);
    al = string_format(_angular_speed_limit, 0, 0);
}

function PacketProjectileSensor(
        _trace_able,
        _trace_ing,
        _find_distance,
        _find_angle,
        _target_x,
        _target_y,
        _target_limit
    ) constructor {
    ta = string_format(_trace_able, 0, 0);
    tn = string_format(_trace_ing, 0, 0);
    
    fd = string_format(_find_distance, 0, 0);
    fa = string_format(_find_angle, 0, 0);
    
    tx = string_format(_target_x, 0, 0);
    ty = string_format(_target_y, 0, 0);
    tl = string_format(_target_limit, 0, 0);
}

function PacketPlanePassive(
        _use_able,
        _index
    ) constructor {
    ua = string_format(_use_able, 0, 0);
    
    i = string_format(_index, 0, 0);
}

function PacketPlaneActive(
        _use_able,
        _index,
        _cool,
        _cool_max
    ) constructor {
    ua = string_format(_use_able, 0, 0);
    
    i = string_format(_index, 0, 0);
    
    c = string_format(_cool, 0, 2);
    cx = string_format(_cool_max, 0, 2);
}

function PacketEffect(
        _sender,
        _index,
        _enable,
        _amount,
        _amount_init,
        _duration,
        _duration_init,
        _infinite
    ) constructor {
    s = string_format(_sender, 0, 0);
    i = string_format(_index, 0, 0);
    e = string_format(_enable, 0, 0);
    a = string_format(_amount, 0, 1);
    ai = string_format(_amount_init, 0, 1);
    d = string_format(_duration, 0, 1);
    di = string_format(_duration_init, 0, 1);
    in = string_format(_infinite, 0, 0);
}

function PacketDamage(
        _sender,
        _type,
        _amount
    ) constructor {
    s = string_format(_sender, 0, 0);
    t = string_format(_type, 0, 0);
    a = string_format(_amount, 0, 1);
}
#endregion

#region Non Packet
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
    
    static Pack = function() {
        var _projectiles = [];
        var _i = 0;
        repeat(array_length(projectiles)) {
            if(!instance_exists(projectiles[_i])) {
                array_delete(projectiles, _i, 1);
                _i -= 1;
            }
            else {
                array_push(_projectiles, projectiles[_i].projectile.Pack());
            }
            _i += 1;
        }
        return new PacketGame(
            stage, time, world.Pack(),
            array_map(users, function(element, index) { return element.Pack() }), 
            array_map(planes, function(element, index) { return element.plane.Pack() }), 
            _projectiles
        );
    }
    
    static Unpack = function(_packet) {
        stage = real(_packet.s);
        time = real(_packet.t);
        world.Unpack(_packet._w);
        
        var _instance = noone;
        var _i = 0;
        var _j = 0;
        
        _i = 0;
        repeat(max(array_length(users), array_length(_packet.ur))) {
            if(_i >= array_length(users)) {
                array_push(users, new User(""));
            }
            users[_i].Unpack(_packet.ur[_i]);
            _i += 1;
        }
        
        var _planes = [];
        array_copy(_planes, 0, _packet.pl, 0, array_length(_packet.pl));
        _instance = noone;
        _i = 0;
        _j = 0;
        repeat(array_length(planes)) {
            repeat(array_length(_planes)) {
                if(planes[_i].plane.player_index == real(_planes[_j].i)) {
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
            _instance = instance_create_layer(_planes[0].x, _planes[0].y, "Game", OBJ_Plane);
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
        array_copy(_projectiles, 0, _packet.pj, 0, array_length(_packet.pj));
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
                    if(projectiles[_i].projectile.projectile_index == real(_projectiles[_j].p)) {
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
            _instance = instance_create_layer(_projectiles[0].x, _projectiles[0].y, "Game", global.__projectile[_projectiles[0].o]);
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
        return new PacketGameWorld(
            range, angle, rotate
        );
    }
    
    static Unpack = function(_packet) {
        range = real(_packet.r);
        angle = real(_packet.a);
        rotate = real(_packet.rt);
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
        return new PacketUser(
            name, 
            input.Pack(), status.Pack()
        );
    }
    
    static Unpack = function(_packet) {
        name = _packet.n;
        
        input.Unpack(_packet._i);
        status.Unpack(_packet._s);
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
        return new PacketUserInput(
            x, y,
            up, left, down, right,
            fire, reload, skill
        );
    }
    
    static Unpack = function(_packet) {
        x = real(_packet.x);
        y = real(_packet.y);
    
        up = bool(_packet.up);
        left = bool(_packet.lt);
        down = bool(_packet.dw);
        right = bool(_packet.rt);
    
        fire = bool(_packet.fr);
        reload = bool(_packet.rd);
        skill = bool(_packet.sk);
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
        return new PacketUserStatus(
            ready, 
            plane_index, passive_index, active_index,
            kill, death
        );
    }
    
    static Unpack = function(_packet) {
        ready = bool(_packet.r);
        plane_index = real(_packet.p);
    
        kill = real(_packet.k);
        death = real(_packet.d);
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
        return new PacketPlane(
            player_index, 
            x, y,
            destroyed, 
            frame.Pack(), engine.Pack(), weapon.Pack(),
            passive.Pack(), active.Pack(),
            array_map(effects, function(element, index) { return element.Pack() })
        );
    }
    
    static Unpack = function(_packet) {
        player_index = real(_packet.i);
        
        x = real(_packet.x);
        y = real(_packet.y);
        
        destroyed = bool(_packet.d);
        
        frame.Unpack(_packet._f);
        engine.Unpack(_packet._e);
        weapon.Unpack(_packet._w);
        
        passive.Unpack(_packet._pk);
        active.Unpack(_packet._ak);
    
        effects = array_create_ext(array_length(_packet.e), function(index) { return new Effect() });
        var _i = 0;
        repeat(array_length(_packet.e)) {
            effects[_i].Unpack(_packet.e[_i]);
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
    durability_recover = _durability_max;
    durability_loss = _durability_loss;
    durability_fix = _durability_fix;
    
    static Pack = function() {
        return new PacketPlaneFrame(
            collide_able, collide_size,
            damage_able, damage_ratio, 
            durability, durability_max, durability_recover, durability_loss, durability_fix
        );
    }
    
    static Unpack = function(_packet) {
        collide_able = bool(_packet.ca);
        collide_size = real(_packet.cs);
    
        damage_able = bool(_packet.da);
        damage_ratio = real(_packet.dr);
    
        durability = real(_packet.d);
        durability_max = real(_packet.dx);
        durability_recover = real(_packet.dr);
        durability_loss = real(_packet.dl);
        durability_fix = real(_packet.df);
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
        return new PacketPlaneEngine(
            move_able,
            linear_speed, linear_speed_max, linear_speed_accel,
            angular_direction, angular_speed_ratio, angular_speed_limit
        );
    }
    
    static Unpack = function(_packet) {
        move_able = bool(_packet.ma);
    
        linear_speed = real(_packet.l);
        linear_speed_max = real(_packet.lx);
        linear_speed_accel = real(_packet.la);
    
        angular_direction = real(_packet.a);
        angular_speed_ratio = real(_packet.ar);
        angular_speed_limit = real(_packet.al);
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
        return new PacketPlaneWeapon(
            fire_able,
            damage_ratio,
            cool, cool_max, amount, period, period_max, interval, interval_max, dispersion_linear, dispersion_angular,
            projectile.Pack(), magazine.Pack()
        );
    }
    
    static Unpack = function(_packet) {
        fire_able = bool(_packet.fa);
    
        damage_ratio = real(_packet.dr);
    
        cool = real(_packet.c);
        cool_max = real(_packet.cx);
        amount = real(_packet.a);
        period = real(_packet.p);
        period_max = real(_packet.px);
        interval = real(_packet.i);
        interval_max = real(_packet.ix);
        dispersion_linear = real(_packet.dl);
        dispersion_angular = real(_packet.da);
        
        projectile.Unpack(_packet._p);
        magazine.Unpack(_packet._m);
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
        return new PacketPlaneWeaponProjectile(
            object,
            collide_size, collide_size_max,
            onhit.Pack(), force.Pack(), _sensor
        );
    }
    
    static Unpack = function(_packet) {
        object = real(_packet.o);
        
        collide_size = real(_packet.cs);
        collide_size_max = real(_packet.cx);
        
        onhit.Unpack(_packet._o);
        force.Unpack(_packet._f);
        
        if(_packet._s == "") {
            sensor = undefined;
        }
        else {
            sensor = sensor ??  new PlaneWeaponProjectileSensor();
            sensor.Unpack(_packet._s);
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
        _damage
    ) constructor {
    damage = _damage;
    
    static Pack = function() {
        return new PacketPlaneWeaponProjectileOnhit(
            damage
        );
    }
    
    static Unpack = function(_packet) {
        damage = real(_packet.d);
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
        return new PacketPlaneWeaponProjectileForce(
            duration_max, 
            linear_speed, linear_speed_max, linear_speed_accel,
            angular_speed_ratio, angular_speed_limit
        );
    }
    
    static Unpack = function(_packet) {
        duration_max = real(_packet.dx);
        
        linear_speed = real(_packet.l);
        linear_speed_max = real(_packet.lx);
        linear_speed_accel = real(_packet.la);
        
        angular_speed_ratio = real(_packet.ar);
        angular_speed_limit = real(_packet.al);
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
        return new PacketPlaneWeaponProjectileSensor(
            trace_able, 
            find_distance, find_angle,
            target_limit
        );
    }
    
    static Unpack = function(_packet) {
        trace_able = bool(_packet.ta);
        
        find_distance = real(_packet.fd);
        find_angle = real(_packet.fa);
        
        target_limit = real(_packet.tl);
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
        return new PacketPlaneWeaponMagazine(
            amount, amount_max,
            reload.Pack()
        );
    }
    
    static Unpack = function(_packet) {
        amount = real(_packet.a);
        amount_max = real(_packet.ax);
        
        reload.Unpack(_packet._r);
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
        return new PacketPlaneWeaponMagazineReload(
            reload_able, reload_ing,
            amount,
            cool, cool_max
        );
    }
    
    static Unpack = function(_packet) {
        reload_able = bool(_packet.ra);
        reload_ing = real(_packet.rn);
        
        amount = real(_packet.a);
    
        cool = real(_packet.c);
        cool_max = real(_packet.cx);
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
        //var _sensor = sensor ?? "";
        //if(_sensor != "") {
        //    _sensor = sensor.Pack();
        //}
        return new PacketProjectile(
            player_index, projectile_index,
            object,
            x, y,
            collided,
            collide_size,
            collide_size_max,
            force.Pack()
            //onhit.Pack(), force.Pack(), _sensor
        );
    }
    
    static Unpack = function(_packet) {
        player_index = real(_packet.i);
        projectile_index = real(_packet.p);
    
        object = real(_packet.o);
    
        x = real(_packet.x);
        y = real(_packet.y);
    
        collided = bool(_packet.c);
        collide_size = real(_packet.cs);
        collide_size_max = real(_packet.cx);
        
        force.Unpack(_packet._f);
        /*
        onhit.Unpack(_packet._o);
        force.Unpack(_packet._f);
        if(_packet._s == "") {
            sensor = undefined;
        }
        else {
            sensor = sensor ?? new ProjectileSensor();
            sensor = sensor.Unpack(_packet._s);
        }
        */
    }
}

function ProjectileOnhit(
        _damage
    ) constructor {
    damage = _damage;
    
    static Pack = function() {
        return new PacketProjectileOnhit(
            damage
        );
    }
    
    static Unpack = function(_packet) {
        damage = real(_packet.d);
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
        return new PacketProjectileForce(
            duration, duration_max,
            linear_speed, linear_speed_max, linear_speed_accel,
            angular_direction, angular_speed_ratio, angular_speed_limit
        );
    }
    
    static Unpack = function(_packet) {
        duration = real(_packet.d);
        duration_max = real(_packet.dx);
    
        linear_speed = real(_packet.l);
        linear_speed_max = real(_packet.lx);
        linear_speed_accel = real(_packet.la);
    
        angular_direction = real(_packet.a);
        angular_speed_ratio = real(_packet.ar);
        angular_speed_limit = real(_packet.al);
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
        return new PacketProjectileSensor(
            trace_able, trace_ing,
            find_distance, find_angle,
            target_x, target_y, target_limit
        );
    }
    
    static Unpack = function(_packet) {
        trace_able = real(_packet.ta);
        trace_ing = real(_packet.tn);
    
        find_distance = real(_packet.fd);
        find_angle = real(_packet.fa);
        
        target_x = real(_packet.tx);
        target_y = real(_packet.ty);
        target_limit = real(_packet.tl);
    }
}

function PlanePassive(
        _index
    ) constructor {
    use_able = true;
    
    index = _index;
    effect_index = -1;
    
    static Pack = function() {
        return new PacketPlanePassive(
            use_able, index
        );
    }
    
    static Unpack = function(_packet) {
        use_able = bool(_packet.ua);
        
        index = bool(_packet.i);
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
        return new PacketPlaneActive(
            use_able, index, cool, cool_max
        );
    }
    
    static Unpack = function(_packet) {
        use_able = bool(_packet.ua);
        
        index = bool(_packet.i);
        
        cool = bool(_packet.c);
        cool_max = bool(_packet.cx);
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
        return new PacketEffect(
            sender, index, enable, amount, amount_init, duration, duration_init, infinite
        );
    }
    
    static Unpack = function(_packet) {
        sender = real(_packet.s);
        index = real(_packet.i);
        enable = bool(_packet.e);
        amount = real(_packet.a);
        amount_init = real(_packet.ai);
        duration = real(_packet.d);
        duration_init = real(_packet.di);
        infinite = bool(_packet.in);
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
        return new PacketDamage(
            sender, type, amount
        );
    }
    
    static Unpack = function(_packet) {
        sender = real(_packet.s);
        type = real(_packet.t);
        amount = real(_packet.a);
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