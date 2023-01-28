client = noone;

interface = instance_create_layer(0, 0, "Menu", OBJ_Interface);
interface.game = self.id;

camera = instance_create_layer(0, 0, "Menu", OBJ_Camera);

game = new Game(id);
world = noone;