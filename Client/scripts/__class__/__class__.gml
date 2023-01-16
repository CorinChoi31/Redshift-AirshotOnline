function Input(
    _input_mouse_x=0,
    _input_mouse_y=0,
    _input_move_up=false,
    _input_move_left=false,
    _input_move_down=false,
    _input_move_right=false,
    _input_fire=false,
    _input_reload=false
    ) constructor {
    
    mo_x = _input_mouse_x;
    mo_y = _input_mouse_y;
    move_up = _input_move_up;
    move_left = _input_move_left;
    move_down = _input_move_down;
    move_right = _input_move_right;
    fire = _input_fire;
    reload = _input_reload;
}

function Unit(
        _name,
        _frame,
        _engine,
        _weapon
    ) constructor {
    
    player = -1;
    input = new Input();
    
    x = 0;
    y = 0;
    
    frame = _frame;
    engine = _engine;
    weapon = _weapon;
    
    dead = false;
}

function Frame(
        _durability_max
    ) constructor {
    
    durability_max = _durability_max;
    durability = _durability_max;
    durability_prev = _durability_max;
    
    draw_durability_max = durability_max;
    draw_durability = durability;
    draw_durability_prev = durability_prev;
}

function Engine(
        _linear_accel,
        _linear_speed_max,
        _angular_speed_max
    ) constructor {
    
    moveable = true;
    
    linear_speed = 0;
    linear_speed_max = _linear_speed_max;
    linear_accel = _linear_accel;
    
    angular_direction = 0;
    angular_speed_max = _angular_speed_max;
}

function Weapon(
        _cool,
        _amount,
        _period,
        _interval,
        _angle,
        _projectile,
        _magazine
    ) constructor {
    
    fireable = true;
    
    cool = 0; // 모든 공격 주기 종료 후 카운트
    cool_max = _cool;
    amount = _amount; // 동시 발사
    period = 0; // 공격 횟수
    period_max = _period;
    interval = 0; // 공격 간격
    interval_max = _interval;
    angle = _angle;
    
    projectile = _projectile;
    magazine = _magazine;
}

function Projectile(
        _object,
        _damage,
        _duration,
        _linear_speed,
        _particle=undefined,
    ) constructor {
    
    object = _object;
    damage = _damage;
    duration = _duration;
    linear_speed = _linear_speed;
    particle = _particle;
}

function Magazine(
        _amount_max,
        _reload_time,
        _reload_amount=-1
    ) constructor {
    
    amount = _amount_max;
    amount_max = _amount_max;
    
    reload = false;
    reload_time = _reload_time;
    reload_time_max = _reload_time;
    reload_amount = _reload_amount;
}

function Projectiles(_object, _player, _id, _x, _y, _damage, _duration, _duration_max, _speed, _direction, _particle) constructor {
    object = _object;
    player = _player;
    
    id = _id;
    
    x = _x;
    y = _y;
    
    damage = _damage;

    duration = _duration;
    duration_max = _duration_max;

    speed = _speed;
    direction = _direction;

    particle = _particle;
}