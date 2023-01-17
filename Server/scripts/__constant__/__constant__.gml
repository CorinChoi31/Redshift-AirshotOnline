enum NET_EVENT {
    CONNECT = 0,
    DISCONNECT = 1,
    GAME_SNAPSHOT = 2,
    GAME_INPUT = 3,
}

enum GAME_STAGE {
    GAME_CREATE = -1,
    GAME_READY = 0,
    GAME_START = 1,
    GAME_END = 2,
}