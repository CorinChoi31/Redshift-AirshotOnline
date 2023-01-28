enum NET_EVENT {
    CONNECT = 0,
    DISCONNECT = 1,
    GAME_SNAPSHOT = 2,
    GAME_INPUT = 3,
}

enum NET_STATE {
    NOT_CONNECTED = 0,
    CONNECTING = 1,
    CONNECTED_SOCKET = 2,
    CONNECTED_PLAYER = 3,
}

enum GAME_STAGE {
    GAME_CREATE = -1,
    GAME_READY = 0,
    GAME_START = 1,
    GAME_END = 2,
}

enum GAME_PROJECTILE {
    BULLET = 0,
    SHELL = 1,
    MISSILE = 1,
}

enum GAME_DAMAGE {
    TRUE = 0,
    PHYSICAL = 1,
}

enum GAME_EFFECT {
    NONE = -1,
    REPAIR_AUTO = 0,
    REPAIR_INSTANT,
    
}