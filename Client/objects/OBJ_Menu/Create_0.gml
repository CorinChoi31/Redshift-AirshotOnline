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
                    if(other.client != noone) {
                        instance_destroy(other.client);
                        other.client = noone;
                    }
                    other.client = instance_create_layer(0, 0, "Menu", OBJ_Client);
                    other.client.menu = other.id;
                    other.client.user_id = _button_username.label.content.content;
                    alpha.SetTarget(1);
                }
                EventClose = function() {
                    alpha.SetTarget(0);
                }
            }
            
            #region Label: Username
                _x = _gui_w * 121;
                _y = _gui_h * 73;
                _label = new GCLabel(
                    new GAPosition(_x, _y),
                    new GAScale(0.5, 0.5),
                    new GARotation(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(1),
                    bm_normal,
                    global.__font,
                    fa_middle,
                    fa_left
                );
                with(_label) {
                    parent = _panel;
                    
                    SetContent(new GCCString("Name"));
                }
                array_push(_panel.contents, _label);
            #endregion
            #region Button: Username
                _x = _gui_w * 120;
                _y = _gui_h * 73;
                _w = _gui_w * 28;
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
                    label.SetContent(new GCCString(""));
                    label.SetAlign(fa_middle, fa_right);
                    label.SetFont(global.__font);
                    label.SetScale(0.75, 0.75, true);
                
                    EventMouseOver = function() {
                        if(other.client.server_connecting == 0) {
                            SetScale(1.125, 1.125);
                            SetBackfieldAlpha(0.5);
                        }
                    }
                    EventMouseReleased = function() {
                        if(other.client.server_connecting == 0) {
                            SetScale(1.25, 1.25);
                        
                            var _input = get_string("Username", label.content.content);
                            if(_input != "") {
                                label.content.content = _input;
                                other.client.user_id = _input;
                            }
                        }
                    }
                    EventMouseDone = function() {
                        SetScale(1, 1);
                        SetBackfieldAlpha(0);
                    }
                
                    EventOpen = function() {
                        size_width.value = 0;
                        size_width.SetTarget(size_width.origin);
                        
                        SetScale(1, 1, true);
                        
                        clickable = true;
                    }
                    EventClose = function() {
                        size_width.SetTarget(0);
                        clickable = false;
                    }
                }
                array_push(_panel.contents, _button);
                _panel._button_username = _button;
            #endregion
            #region Label: IP
                _x = _gui_w * 121;
                _y = _gui_h * 85;
                _label = new GCLabel(
                    new GAPosition(_x, _y),
                    new GAScale(0.5, 0.5),
                    new GARotation(0),
                    new GAColor(c_white, ggTYPE.COLOR_RGB),
                    new GAAlpha(1),
                    bm_normal,
                    global.__font,
                    fa_middle,
                    fa_left
                );
                with(_label) {
                    parent = _panel;
                    
                    SetContent(new GCCString("IP"));
                }
                array_push(_panel.contents, _label);
            #endregion
            #region Button: IP
                _x = _gui_w * 120;
                _y = _gui_h * 85;
                _w = _gui_w * 28;
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
                        if(other.client.server_connecting == 0) {
                            SetScale(1.125, 1.125);
                            SetBackfieldAlpha(0.5);
                        }
                    }
                    EventMouseReleased = function() {
                        if(other.client.server_connecting == 0) {
                            SetScale(1.25, 1.25);
                        
                            var _input = get_string("IP Address", label.content.content);
                            if(_input != "") {
                                label.content.content = _input;
                                other.client.client_ip = _input;
                            }
                        }
                    }
                    EventMouseDone = function() {
                        SetScale(1, 1);
                        SetBackfieldAlpha(0);
                    }
                
                    EventOpen = function() {
                        size_width.value = 0;
                        size_width.SetTarget(size_width.origin);
                        
                        SetScale(1, 1, true);
                        
                        clickable = true;
                    }
                    EventClose = function() {
                        size_width.SetTarget(0);
                        clickable = false;
                    }
                }
                array_push(_panel.contents, _button);
            #endregion
            
            #region Button: Connect
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
                        
                        if(other.client.server_connecting == 0 && other.client.user_id != "") {
                            other.client.server = network_connect_async(other.client.client_socket, other.client.client_ip, other.client.client_port);
                            other.client.server_connecting = 1;
                        }
                    }
                    EventMouseDone = function() {
                        SetScale(1, 1);
                        SetBackfieldAlpha(0);
                    }
                    
                    CustomStep = function(_delta_tick=1) {
                        if(instance_exists(other.client) && other.client.server_connecting == 0) {
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
                        if(other.client != noone) {
                            instance_destroy(other.client);
                            other.client = noone;
                        }
                        
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

client = noone;