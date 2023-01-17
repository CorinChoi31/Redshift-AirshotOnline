switch(phase) {
    default:
        break;
    
    case gui_system.MENU_MAIN:
        gui_MenuMain.Draw();
        break;
        
    case gui_system.MENU_SINGLEPLAYER:
        break;
        
    case gui_system.MENU_MULTIPLAYER:
        gui_MenuMultiplayer.Draw();
        break;
}