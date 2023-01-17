gui_System.Step();

switch(phase) {
    default:
    case gui_system.NONE:
        phase_goto(gui_system.MENU_MAIN);
        break;
    
    case gui_system.MENU_MAIN:
        if(phase_tick == 0) {
            gui_MenuMain.Open();
        }
        gui_MenuMain.Step();
        
        if(phase_next) {
            if(phase_next_event) {
                gui_MenuMain.Close();
            }
        }
        break;
        
    case gui_system.MENU_SINGLEPLAYER:
        if(keyboard_check_released(vk_escape)) {
            phase_goto(gui_system.MENU_MAIN);
        }
        
        if(phase_next) {
            if(phase_next_event) {
                gui_MenuMain.Close();
            }
        }
        break;
        
    case gui_system.MENU_MULTIPLAYER:
        if(phase_tick == 0) {
            gui_MenuMultiplayer.Open();
        }
        gui_MenuMultiplayer.Step();
        
        if(phase_next) {
            if(phase_next_event) {
                gui_MenuMultiplayer.Close();
            }
        }
        break;
    
    case gui_system.MENU_MULTIPLAYER_GAME:
        if(room != ROM_Game) {
            room_goto(ROM_Game);
        }
        if(keyboard_check(vk_shift)) {
            if(keyboard_check_released(vk_escape)) {
                instance_destroy(client);
            }
        }
        break;
}

phase_tick += 1;

if(phase_next) {
    if(phase_next_tick == -1) {
        phase_next_tick = phase_next_tick_max;
    }
    else {
        phase_next_tick -= 1;
        phase_next_event = false;
        if(phase_next_tick <= 0) {
            phase_next = false;
            phase_next_tick = -1;
            
            phase = phase_next_target;
            phase_tick = 0;
        }
    }
}