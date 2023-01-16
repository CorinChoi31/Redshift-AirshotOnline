#region
    phase = 0;
    phase_tick = 0;
    
    phase_next = false;
    phase_next_event = false;
    phase_next_target = 0;
    phase_next_tick = -1;
    phase_next_tick_max = room_speed;
    
    phase_goto = function(_phase, _time=-1) {
        if(phase_next == false) {
            phase_next = true;
            phase_next_event = true;
            phase_next_target = _phase;
            phase_next_tick = phase_next_tick_max;
        
            if(_time > -1) {
                phase_next_tick = _time;
            }
        }
    }
#endregion

#region UI
    #region Variables
    enum gui_system {
        NONE = -4,
        MENU_MAIN = 0,
            MENU_OPTION = 10,
            MENU_SINGLEPLAYER = 20,
                MENU_SINGLEPLAYER_GAME = 21,
            MENU_MULTIPLAYER = 30,
                MENU_MULTIPLAYER_CREATE = 31,
                MENU_MULTIPLAYER_JOIN = 32,
                MENU_MULTIPLAYER_GAME = 33,
    }
        gui_System = ggui_get_system();
        
        global.__GGUI_PROPERTY[? "motion-default"] = new GAMotion(ggTYPE.MOTION_SMOOTH, 1, 0.375, 0.25, 0.0001);
        
        var _gui_width = display_get_gui_width();
        var _gui_height = display_get_gui_height();

        var _gui_divide_width = 128;
        var _gui_divide_height = 128;

        var _gui_w = _gui_width/_gui_divide_width;
        var _gui_h = _gui_height/_gui_divide_height;

        var _x = 0;
        var _y = 0;
        var _w = 0;
        var _h = 0;

        var _panel = undefined;
        var _subpanel_1 = undefined;
        var _subpanel_2 = undefined;
        var _button = undefined;
        var _label = undefined;
        var _content = undefined;
    #endregion
        
    #region Functions
        
    #endregion
    
    #region Panel
        #region Menu Test: -10
            gui_MenuTest = new GCPanel(
                false,
                new GAPosition(0, 0),
                new GASize(_gui_width, _gui_height),
                new GAScale(1, 1),
                new GARotation(0),
                new GAColor(c_white, ggTYPE.COLOR_RGB),
                new GAAlpha(0),
                new GAColor(c_white, ggTYPE.COLOR_RGB),
                new GAAlpha(0),
                new GAThickness(0),
                new GAColor(c_white, ggTYPE.COLOR_RGB),
                new GAAlpha(1),
                new GAAlpha(0),
                bm_normal,
                fa_top, fa_left
            );
            _panel = gui_MenuTest;
            with(_panel) {
                alpha.smooth = 0.1;
                
                EventOpen = function() {
                    alpha.SetTarget(1);
                }
                EventClose = function() {
                    alpha.SetTarget(0);
                }
            }
            #region Button: Connect
                _x = _gui_w * 120;
                _y = _gui_h * 73;
                _w = _gui_w * 32;
                _h = _gui_h * 10;
                _button = new GCButton(
                    new GAPosition(_x, _y),
                    new GASize(_w, _h),
                    new GAScale(1, 1),
                    new GARotation(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAThickness(2),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(1),
                    new GAAlpha(1),
                    bm_normal,
                    fa_middle, fa_right
                );
                with(_button) {
                    parent = _panel;
                
                    position_x.smooth = 0.05;
                    position_y.smooth = 0.05;
                    
                    size_width.smooth = 0.05;
                    size_height.smooth = 0.05;
                    
                    scale_x.smooth = 0.25;
                    scale_y.smooth = 0.25;
                
                    SetLabel(new GCLabel(), fa_middle, fa_right, 0, -16);
                    label.SetContent(new GCCString("Connect"));
                    label.SetAlign(fa_middle, fa_right);
                    label.SetFont(global.__font);
                    label.SetScale(0.75, 0.75, true);
                
                    EventMouseOver = function() {
                        SetScale(1.125, 1.125);
                        SetBackfieldAlpha(0.5);
                    }
                    EventMouseReleased = function() {
                        SetScale(1.25, 1.25);
                        
                        if(other.server_connecting == 0) {
                            other.server = network_connect_async(other.client_socket, other.client_ip, other.client_port);
                            other.server_connecting = 1;
                        }
                    }
                    EventMouseDone = function() {
                        SetScale(1, 1);
                        SetBackfieldAlpha(0);
                    }
                    
                    CustomStep = function(_delta_tick=1) {
                        if(other.server_connecting == 0) {
                            SetBackfieldAlpha(0);
                        }
                        else {
                            SetBackfieldAlpha(0.25);
                        }
                    }
                
                    EventOpen = function() {
                        size_width.value = 0;
                        size_width.SetTarget(size_width.origin);
                        
                        SetScale(1, 1, true);
                        
                        clickable = true;
                    }
                    EventClose = function() {
                        if(!mouse_input_event_released) {
                            size_width.SetTarget(0);
                        }
                        clickable = false;
                    }
                }
                array_push(_panel.contents, _button);
            #endregion
            #region Button: IP
                _x = _gui_w * 120;
                _y = _gui_h * 85;
                _w = _gui_w * 32;
                _h = _gui_h * 10;
                _button = new GCButton(
                    new GAPosition(_x, _y),
                    new GASize(_w, _h),
                    new GAScale(1, 1),
                    new GARotation(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAThickness(2),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(1),
                    new GAAlpha(1),
                    bm_normal,
                    fa_middle, fa_right
                );
                with(_button) {
                    parent = _panel;
                
                    position_x.smooth = 0.05;
                    position_y.smooth = 0.05;
                    
                    size_width.smooth = 0.05;
                    size_height.smooth = 0.05;
                    
                    scale_x.smooth = 0.25;
                    scale_y.smooth = 0.25;
                
                    SetLabel(new GCLabel(), fa_middle, fa_right, 0, -16);
                    label.SetContent(new GCCString("127.0.0.1"));
                    label.SetAlign(fa_middle, fa_right);
                    label.SetFont(global.__font);
                    label.SetScale(0.75, 0.75, true);
                
                    EventMouseOver = function() {
                        SetScale(1.125, 1.125);
                        SetBackfieldAlpha(0.5);
                    }
                    EventMouseReleased = function() {
                        SetScale(1.25, 1.25);
                    }
                    EventMouseDone = function() {
                        SetScale(1, 1);
                        SetBackfieldAlpha(0);
                    }
                    
                    CustomStep = function(_delta_tick=1) {
                        other.client_ip = keyboard_string;
                    }
                
                    EventOpen = function() {
                        keyboard_string = "127.0.0.1";
                        
                        size_width.value = 0;
                        size_width.SetTarget(size_width.origin);
                        
                        SetScale(1, 1, true);
                        
                        clickable = true;
                    }
                    EventClose = function() {
                        if(!mouse_input_event_released) {
                            size_width.SetTarget(0);
                        }
                        clickable = false;
                    }
                }
                array_push(_panel.contents, _button);
            #endregion
        #endregion
        #region Menu Main: 00
            gui_MenuMain = new GCPanel(
                false,
                new GAPosition(0, 0),
                new GASize(_gui_width, _gui_height),
                new GAScale(1, 1),
                new GARotation(0),
                new GAColor(c_white, ggTYPE.COLOR_RGB),
                new GAAlpha(0),
                new GAColor(c_white, ggTYPE.COLOR_RGB),
                new GAAlpha(0),
                new GAThickness(0),
                new GAColor(c_white, ggTYPE.COLOR_RGB),
                new GAAlpha(1),
                new GAAlpha(0),
                bm_normal,
                fa_top, fa_left
            );
            _panel = gui_MenuMain;
            with(_panel) {
                alpha.smooth = 0.1;
                
                EventOpen = function() {
                    alpha.SetTarget(1);
                }
                EventClose = function() {
                    alpha.SetTarget(0);
                }
            }
            
            #region Button: Singleplayer
                _x = _gui_w * 120;
                _y = _gui_h * 73;
                _w = _gui_w * 32;
                _h = _gui_h * 10;
                _button = new GCButton(
                    new GAPosition(_x, _y),
                    new GASize(_w, _h),
                    new GAScale(1, 1),
                    new GARotation(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAThickness(2),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(1),
                    new GAAlpha(1),
                    bm_normal,
                    fa_middle, fa_right
                );
                with(_button) {
                    parent = _panel;
                
                    position_x.smooth = 0.05;
                    position_y.smooth = 0.05;
                    
                    size_width.smooth = 0.05;
                    size_height.smooth = 0.05;
                    
                    scale_x.smooth = 0.25;
                    scale_y.smooth = 0.25;
                
                    SetLabel(new GCLabel(), fa_middle, fa_right, 0, -16);
                    label.SetContent(new GCCString("Singleplayer"));
                    label.SetAlign(fa_middle, fa_right);
                    label.SetFont(global.__font);
                    label.SetScale(0.75, 0.75, true);
                
                    EventMouseOver = function() {
                        SetScale(1.125, 1.125);
                        SetBackfieldAlpha(0.5);
                    }
                    EventMouseReleased = function() {
                        SetScale(1.25, 1.25);
                    
                        other.phase_goto(gui_system.MENU_SINGLEPLAYER);
                    }
                    EventMouseDone = function() {
                        if(!mouse_input_event_released) {
                            SetScale(1, 1);
                        }
                        SetBackfieldAlpha(0);
                    }
                
                    EventOpen = function() {
                        size_width.value = 0;
                        size_width.SetTarget(size_width.origin);
                        
                        SetScale(1, 1, true);
                        
                        clickable = true;
                    }
                    EventClose = function() {
                        if(!mouse_input_event_released) {
                            size_width.SetTarget(0);
                        }
                        clickable = false;
                    }
                }
                array_push(_panel.contents, _button);
            #endregion
            
            #region Button: Multiplayer
                _x = _gui_w * 120;
                _y = _gui_h * 85;
                _w = _gui_w * 32;
                _h = _gui_h * 10;
                _button = new GCButton(
                    new GAPosition(_x, _y),
                    new GASize(_w, _h),
                    new GAScale(1, 1),
                    new GARotation(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAThickness(2),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(1),
                    new GAAlpha(1),
                    bm_normal,
                    fa_middle, fa_right
                );
                with(_button) {
                    parent = _panel;
                
                    position_x.smooth = 0.05;
                    position_y.smooth = 0.05;
                    
                    size_width.smooth = 0.05;
                    size_height.smooth = 0.05;
                    
                    scale_x.smooth = 0.25;
                    scale_y.smooth = 0.25;
                
                    SetLabel(new GCLabel(), fa_middle, fa_right, 0, -16);
                    label.SetContent(new GCCString("Multiplayer"));
                    label.SetAlign(fa_middle, fa_right);
                    label.SetFont(global.__font);
                    label.SetScale(0.75, 0.75, true);
                
                    EventMouseOver = function() {
                        SetScale(1.125, 1.125);
                        SetBackfieldAlpha(0.5);
                    }
                    EventMouseReleased = function() {
                        SetScale(1.25, 1.25);
                    
                        other.phase_goto(gui_system.MENU_MULTIPLAYER);
                    }
                    EventMouseDone = function() {
                        if(!mouse_input_event_released) {
                            SetScale(1, 1);
                        }
                        SetBackfieldAlpha(0);
                    }
                
                    EventOpen = function() {
                        size_width.value = 0;
                        size_width.SetTarget(size_width.origin);
                        
                        SetScale(1, 1, true);
                        
                        clickable = true;
                    }
                    EventClose = function() {
                        if(!mouse_input_event_released) {
                            size_width.SetTarget(0);
                        }
                        clickable = false;
                    }
                }
                array_push(_panel.contents, _button);
            #endregion
            
            #region Button: Option
                _x = _gui_w * 120;
                _y = _gui_h * 96;
                _w = _gui_w * 24;
                _h = _gui_h * 8;
                _button = new GCButton(
                    new GAPosition(_x, _y),
                    new GASize(_w, _h),
                    new GAScale(1, 1),
                    new GARotation(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAThickness(2),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(1),
                    new GAAlpha(1),
                    bm_normal,
                    fa_middle, fa_right
                );
                with(_button) {
                    parent = _panel;
                
                    position_x.smooth = 0.05;
                    position_y.smooth = 0.05;
                    
                    size_width.smooth = 0.05;
                    size_height.smooth = 0.05;
                    
                    scale_x.smooth = 0.25;
                    scale_y.smooth = 0.25;
                
                    SetLabel(new GCLabel(), fa_middle, fa_right, 0, -16);
                    label.SetContent(new GCCString("Option"));
                    label.SetAlign(fa_middle, fa_right);
                    label.SetFont(global.__font);
                    label.SetScale(0.625, 0.625, true);
                
                    EventMouseOver = function() {
                        SetScale(1.125, 1.125);
                        SetBackfieldAlpha(0.5);
                    }
                    EventMouseReleased = function() {
                        SetScale(1.25, 1.25);
                        
                        other.phase_goto(gui_system.MENU_OPTION);
                    }
                    EventMouseDone = function() {
                        if(!mouse_input_event_released) {
                            SetScale(1, 1);
                        }
                        SetBackfieldAlpha(0);
                    }
                
                    EventOpen = function() {
                        size_width.value = 0;
                        size_width.SetTarget(size_width.origin);
                        
                        SetScale(1, 1, true);
                        
                        clickable = true;
                    }
                    EventClose = function() {
                        if(!mouse_input_event_released) {
                            size_width.SetTarget(0);
                        }
                        clickable = false;
                    }
                }
                array_push(_panel.contents, _button);
            #endregion
            
            #region Button: Exit
                _x = _gui_w * 120;
                _y = _gui_h * 116;
                _w = _gui_w * 24;
                _h = _gui_h * 8;
                _button = new GCButton(
                    new GAPosition(_x, _y),
                    new GASize(_w, _h),
                    new GAScale(1, 1),
                    new GARotation(0),
                    new GAColor(c_black, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAThickness(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(1),
                    new GAAlpha(1),
                    bm_normal,
                    fa_middle, fa_right
                );
                with(_button) {
                    parent = _panel;
                
                    position_x.smooth = 0.05;
                    position_y.smooth = 0.05;
                    
                    size_width.smooth = 0.05;
                    size_height.smooth = 0.05;
                    
                    scale_x.smooth = 0.25;
                    scale_y.smooth = 0.25;
                
                    SetLabel(new GCLabel(), fa_middle, fa_right, 0, -16);
                    label.SetColor(c_red);
                    label.SetContent(new GCCString("Exit"));
                    label.SetAlign(fa_middle, fa_right);
                    label.SetFont(global.__font);
                    label.SetScale(0.625, 0.625, true);
                
                    EventMouseOver = function() {
                        SetScale(1.125, 1.125);
                        SetBackfieldAlpha(0.5);
                    }
                    EventMouseReleased = function() {
                        SetScale(1.25, 1.25);
                    
                        game_end();
                    }
                    EventMouseDone = function() {
                        if(!mouse_input_event_released) {
                            SetScale(1, 1);
                        }
                        SetBackfieldAlpha(0);
                    }
                
                    EventOpen = function() {
                        size_width.value = 0;
                        size_width.SetTarget(size_width.origin);
                        
                        SetScale(1, 1, true);
                        
                        clickable = true;
                    }
                    EventClose = function() {
                        if(!mouse_input_event_released) {
                            size_width.SetTarget(0);
                        }
                        clickable = false;
                    }
                }
                array_push(_panel.contents, _button);
            #endregion
        #endregion
        
        #region Menu Multiplayer: 30
            gui_MenuMultiplayer = new GCPanel(
                false,
                new GAPosition(0, 0),
                new GASize(_gui_width, _gui_height),
                new GAScale(1, 1),
                new GARotation(0),
                new GAColor(c_white, ggTYPE.COLOR_RGB),
                new GAAlpha(0),
                new GAColor(c_white, ggTYPE.COLOR_RGB),
                new GAAlpha(0),
                new GAThickness(0),
                new GAColor(c_white, ggTYPE.COLOR_RGB),
                new GAAlpha(1),
                new GAAlpha(0),
                bm_normal,
                fa_top, fa_left
            );
            _panel = gui_MenuMultiplayer;
            with(_panel) {
                alpha.smooth = 0.1;
                
                EventOpen = function() {
                    alpha.SetTarget(1);
                }
                EventClose = function() {
                    alpha.SetTarget(0);
                }
            }
            
            #region Button: Create Room
                _x = _gui_w * 120;
                _y = _gui_h * 85;
                _w = _gui_w * 32;
                _h = _gui_h * 10;
                _button = new GCButton(
                    new GAPosition(_x, _y),
                    new GASize(_w, _h),
                    new GAScale(1, 1),
                    new GARotation(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAThickness(2),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(1),
                    new GAAlpha(1),
                    bm_normal,
                    fa_middle, fa_right
                );
                with(_button) {
                    parent = _panel;
                
                    position_x.smooth = 0.05;
                    position_y.smooth = 0.05;
                    
                    size_width.smooth = 0.05;
                    size_height.smooth = 0.05;
                    
                    scale_x.smooth = 0.25;
                    scale_y.smooth = 0.25;
                
                    SetLabel(new GCLabel(), fa_middle, fa_right, 0, -16);
                    label.SetContent(new GCCString("Create Room"));
                    label.SetAlign(fa_middle, fa_right);
                    label.SetFont(global.__font);
                    label.SetScale(0.75, 0.75, true);
                
                    EventMouseOver = function() {
                        SetScale(1.125, 1.125);
                        SetBackfieldAlpha(0.5);
                    }
                    EventMouseReleased = function() {
                        SetScale(1.25, 1.25);
                        
                        other.phase_goto(gui_system.MENU_MULTIPLAYER_CREATE);
                    }
                    EventMouseDone = function() {
                        if(!mouse_input_event_released) {
                            SetScale(1, 1);
                        }
                        SetBackfieldAlpha(0);
                    }
                
                    EventOpen = function() {
                        size_width.value = 0;
                        size_width.SetTarget(size_width.origin);
                        
                        SetScale(1, 1, true);
                        
                        clickable = true;
                    }
                    EventClose = function() {
                        if(!mouse_input_event_released) {
                            size_width.SetTarget(0);
                        }
                        clickable = false;
                    }
                }
                array_push(_panel.contents, _button);
            #endregion
            
            #region Button: Join Room
                _x = _gui_w * 120;
                _y = _gui_h * 97;
                _w = _gui_w * 32;
                _h = _gui_h * 10;
                _button = new GCButton(
                    new GAPosition(_x, _y),
                    new GASize(_w, _h),
                    new GAScale(1, 1),
                    new GARotation(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAThickness(2),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(1),
                    new GAAlpha(1),
                    bm_normal,
                    fa_middle, fa_right
                );
                with(_button) {
                    parent = _panel;
                
                    position_x.smooth = 0.05;
                    position_y.smooth = 0.05;
                    
                    size_width.smooth = 0.05;
                    size_height.smooth = 0.05;
                    
                    scale_x.smooth = 0.25;
                    scale_y.smooth = 0.25;
                
                    SetLabel(new GCLabel(), fa_middle, fa_right, 0, -16);
                    label.SetContent(new GCCString("Join Room"));
                    label.SetAlign(fa_middle, fa_right);
                    label.SetFont(global.__font);
                    label.SetScale(0.75, 0.75, true);
                
                    EventMouseOver = function() {
                        SetScale(1.125, 1.125);
                        SetBackfieldAlpha(0.5);
                    }
                    EventMouseReleased = function() {
                        SetScale(1.25, 1.25);
                        
                        other.phase_goto(gui_system.MENU_MULTIPLAYER_JOIN);
                    }
                    EventMouseDone = function() {
                        if(!mouse_input_event_released) {
                            SetScale(1, 1);
                        }
                        SetBackfieldAlpha(0);
                    }
                
                    EventOpen = function() {
                        size_width.value = 0;
                        size_width.SetTarget(size_width.origin);
                        
                        SetScale(1, 1, true);
                        
                        clickable = true;
                    }
                    EventClose = function() {
                        if(!mouse_input_event_released) {
                            size_width.SetTarget(0);
                        }
                        clickable = false;
                    }
                }
                array_push(_panel.contents, _button);
            #endregion
            
            #region Button: Back
                _x = _gui_w * 120;
                _y = _gui_h * 116;
                _w = _gui_w * 24;
                _h = _gui_h * 8;
                _button = new GCButton(
                    new GAPosition(_x, _y),
                    new GASize(_w, _h),
                    new GAScale(1, 1),
                    new GARotation(0),
                    new GAColor(c_black, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(0),
                    new GAThickness(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(1),
                    new GAAlpha(1),
                    bm_normal,
                    fa_middle, fa_right
                );
                with(_button) {
                    parent = _panel;
                
                    position_x.smooth = 0.05;
                    position_y.smooth = 0.05;
                    
                    size_width.smooth = 0.05;
                    size_height.smooth = 0.05;
                    
                    scale_x.smooth = 0.25;
                    scale_y.smooth = 0.25;
                
                    SetLabel(new GCLabel(), fa_middle, fa_right, 0, -16);
                    label.SetColor(c_white);
                    label.SetContent(new GCCString("Back"));
                    label.SetAlign(fa_middle, fa_right);
                    label.SetFont(global.__font);
                    label.SetScale(0.625, 0.625, true);
                
                    EventMouseOver = function() {
                        SetScale(1.125, 1.125);
                        SetBackfieldAlpha(0.5);
                    }
                    EventMouseReleased = function() {
                        SetScale(1.25, 1.25);
                    
                        other.phase_goto(gui_system.MENU_MAIN);
                    }
                    EventMouseDone = function() {
                        if(!mouse_input_event_released) {
                            SetScale(1, 1);
                        }
                        SetBackfieldAlpha(0);
                    }
                
                    EventOpen = function() {
                        size_width.value = 0;
                        size_width.SetTarget(size_width.origin);
                        
                        SetScale(1, 1, true);
                        
                        clickable = true;
                    }
                    EventClose = function() {
                        if(!mouse_input_event_released) {
                            size_width.SetTarget(0);
                        }
                        clickable = false;
                    }
                }
                array_push(_panel.contents, _button);
            #endregion
        #endregion
    #endregion
#endregion


network_set_config(network_config_connect_timeout, 5000);
network_set_config(network_config_use_non_blocking_socket, true);


client_socket = network_create_socket(network_socket_tcp);
client_ip = "127.0.0.1";
client_port = 17540;

client_packet = buffer_create(1024, buffer_grow, 1);

server_connecting = 0;
server = -1;


time = 0;

player_list = [];

projectile_list = [];
projectile_id = 0;

user_id = random_range(1, 10000);
show_debug_message(user_id);

player = -1;