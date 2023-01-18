client = noone;

interface = instance_create_layer(0, 0, "Menu", OBJ_Interface);
interface.game = self.id;

camera = instance_create_layer(0, 0, "Menu", OBJ_Camera);


stage = GAME_STAGE.GAME_CREATE;
time = 0;

range = 0;


user_list = [];

player_list = [];

projectile_list = [];
projectile_id = 0;