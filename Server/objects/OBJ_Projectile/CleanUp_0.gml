if(game != noone) {
    var _index = array_find_index(game.game.projectiles, function(element, index) { return element.id == self.id })
    if(_index != -1) {
        array_delete(game.game.projectiles, _index, 1);
    }
}