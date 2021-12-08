/*
    DZ Client API 라이브러리
*/
library DZUtility

    globals
        
    endglobals

    struct KeyType
        static constant integer KEY_LBUTTON                       = $01
        static constant integer KEY_RBUTTON                       = $02
        static constant integer KEY_CANCEL                        = $03
        static constant integer KEY_MBUTTON                       = $04
        static constant integer KEY_XBUTTON1                      = $05
        static constant integer KEY_XBUTTON2                      = $06

        static constant integer KEY_BACKSPACE                     = $08
        static constant integer KEY_TAB                           = $09
        static constant integer KEY_CLEAR                         = $0C
        static constant integer KEY_RETURN                        = $0D
        static constant integer KEY_SHIFT                         = $10
        static constant integer KEY_CONTROL                       = $11
        static constant integer KEY_ALT                           = $12
        static constant integer KEY_PAUSE                         = $13
        static constant integer KEY_CAPSLOCK                      = $14
        static constant integer KEY_KANA                          = $15
        static constant integer KEY_HANGUL                        = $15
        static constant integer KEY_JUNJA                         = $17
        static constant integer KEY_FINAL                         = $18
        static constant integer KEY_HANJA                         = $19
        static constant integer KEY_KANJI                         = $19
        static constant integer KEY_ESCAPE                        = $1B
        static constant integer KEY_CONVERT                       = $1C
        static constant integer KEY_NONCONVERT                    = $1D
        static constant integer KEY_ACCEPT                        = $1E
        static constant integer KEY_MODECHANGE                    = $1F
        static constant integer KEY_SPACE                         = $20
        static constant integer KEY_PAGEUP                        = $21
        static constant integer KEY_PAGEDOWN                      = $22
        static constant integer KEY_END                           = $23
        static constant integer KEY_HOME                          = $24
        static constant integer KEY_LEFT                          = $25
        static constant integer KEY_UP                            = $26
        static constant integer KEY_RIGHT                         = $27
        static constant integer KEY_DOWN                          = $28
        static constant integer KEY_SELECT                        = $29
        static constant integer KEY_PRINT                         = $2A
        static constant integer KEY_EXECUTE                       = $2B
        static constant integer KEY_PRINTSCREEN                   = $2C
        static constant integer KEY_INSERT                        = $2D
        static constant integer KEY_DELETE                        = $2E
        static constant integer KEY_HELP                          = $2F
        static constant integer KEY_0                             = $30
        static constant integer KEY_1                             = $31
        static constant integer KEY_2                             = $32
        static constant integer KEY_3                             = $33
        static constant integer KEY_4                             = $34
        static constant integer KEY_5                             = $35
        static constant integer KEY_6                             = $36
        static constant integer KEY_7                             = $37
        static constant integer KEY_8                             = $38
        static constant integer KEY_9                             = $39
        static constant integer KEY_A                             = $41
        static constant integer KEY_B                             = $42
        static constant integer KEY_C                             = $43
        static constant integer KEY_D                             = $44
        static constant integer KEY_E                             = $45
        static constant integer KEY_F                             = $46
        static constant integer KEY_G                             = $47
        static constant integer KEY_H                             = $48
        static constant integer KEY_I                             = $49
        static constant integer KEY_J                             = $4A
        static constant integer KEY_K                             = $4B
        static constant integer KEY_L                             = $4C
        static constant integer KEY_M                             = $4D
        static constant integer KEY_N                             = $4E
        static constant integer KEY_O                             = $4F
        static constant integer KEY_P                             = $50
        static constant integer KEY_Q                             = $51
        static constant integer KEY_R                             = $52
        static constant integer KEY_S                             = $53
        static constant integer KEY_T                             = $54
        static constant integer KEY_U                             = $55
        static constant integer KEY_V                             = $56
        static constant integer KEY_W                             = $57
        static constant integer KEY_X                             = $58
        static constant integer KEY_Y                             = $59
        static constant integer KEY_Z                             = $5A
        static constant integer KEY_LMETA                         = $5B
        static constant integer KEY_RMETA                         = $5C
        static constant integer KEY_APPS                          = $5D
        static constant integer KEY_SLEEP                         = $5F
        static constant integer KEY_NUMPAD0                       = $60
        static constant integer KEY_NUMPAD1                       = $61
        static constant integer KEY_NUMPAD2                       = $62
        static constant integer KEY_NUMPAD3                       = $63
        static constant integer KEY_NUMPAD4                       = $64
        static constant integer KEY_NUMPAD5                       = $65
        static constant integer KEY_NUMPAD6                       = $66
        static constant integer KEY_NUMPAD7                       = $67
        static constant integer KEY_NUMPAD8                       = $68
        static constant integer KEY_NUMPAD9                       = $69
        static constant integer KEY_MULTIPLY                      = $6A
        static constant integer KEY_ADD                           = $6B
        static constant integer KEY_SEPARATOR                     = $6C
        static constant integer KEY_SUBTRACT                      = $6D
        static constant integer KEY_DECIMAL                       = $6E
        static constant integer KEY_DIVIDE                        = $6F
        static constant integer KEY_F1                            = $70
        static constant integer KEY_F2                            = $71
        static constant integer KEY_F3                            = $72
        static constant integer KEY_F4                            = $73
        static constant integer KEY_F5                            = $74
        static constant integer KEY_F6                            = $75
        static constant integer KEY_F7                            = $76
        static constant integer KEY_F8                            = $77
        static constant integer KEY_F9                            = $78
        static constant integer KEY_F10                           = $79
        static constant integer KEY_F11                           = $7A
        static constant integer KEY_F12                           = $7B
        static constant integer KEY_F13                           = $7C
        static constant integer KEY_F14                           = $7D
        static constant integer KEY_F15                           = $7E
        static constant integer KEY_F16                           = $7F
        static constant integer KEY_F17                           = $80
        static constant integer KEY_F18                           = $81
        static constant integer KEY_F19                           = $82
        static constant integer KEY_F20                           = $83
        static constant integer KEY_F21                           = $84
        static constant integer KEY_F22                           = $85
        static constant integer KEY_F23                           = $86
        static constant integer KEY_F24                           = $87
        static constant integer KEY_NUMLOCK                       = $90
        static constant integer KEY_SCROLLLOCK                    = $91
        static constant integer KEY_OEM_NEC_EQUAL                 = $92
        static constant integer KEY_OEM_FJ_JISHO                  = $92
        static constant integer KEY_OEM_FJ_MASSHOU                = $93
        static constant integer KEY_OEM_FJ_TOUROKU                = $94
        static constant integer KEY_OEM_FJ_LOYA                   = $95
        static constant integer KEY_OEM_FJ_ROYA                   = $96
        static constant integer KEY_LSHIFT                        = $A0
        static constant integer KEY_RSHIFT                        = $A1
        static constant integer KEY_LCONTROL                      = $A2
        static constant integer KEY_RCONTROL                      = $A3
        static constant integer KEY_LALT                          = $A4
        static constant integer KEY_RALT                          = $A5
        static constant integer KEY_BROWSER_BACK                  = $A6
        static constant integer KEY_BROWSER_FORWARD               = $A7
        static constant integer KEY_BROWSER_REFRESH               = $A8
        static constant integer KEY_BROWSER_STOP                  = $A9
        static constant integer KEY_BROWSER_SEARCH                = $AA
        static constant integer KEY_BROWSER_FAVORITES             = $AB
        static constant integer KEY_BROWSER_HOME                  = $AC
        static constant integer KEY_VOLUME_MUTE                   = $AD
        static constant integer KEY_VOLUME_DOWN                   = $AE
        static constant integer KEY_VOLUME_UP                     = $AF
        static constant integer KEY_MEDIA_NEXT_TRACK              = $B0
        static constant integer KEY_MEDIA_PREV_TRACK              = $B1
        static constant integer KEY_MEDIA_STOP                    = $B2
        static constant integer KEY_MEDIA_PLAY_PAUSE              = $B3
        static constant integer KEY_LAUNCH_MAIL                   = $B4
        static constant integer KEY_LAUNCH_MEDIA_SELECT           = $B5
        static constant integer KEY_LAUNCH_APP1                   = $B6
        static constant integer KEY_LAUNCH_APP2                   = $B7
        static constant integer KEY_OEM_1                         = $BA
        static constant integer KEY_OEM_PLUS                      = $BB
        static constant integer KEY_OEM_COMMA                     = $BC
        static constant integer KEY_OEM_MINUS                     = $BD
        static constant integer KEY_OEM_PERIOD                    = $BE
        static constant integer KEY_OEM_2                         = $BF
        static constant integer KEY_OEM_3                         = $C0
        static constant integer KEY_OEM_4                         = $DB
        static constant integer KEY_OEM_5                         = $DC
        static constant integer KEY_OEM_6                         = $DD
        static constant integer KEY_OEM_7                         = $DE
        static constant integer KEY_OEM_8                         = $DF
        static constant integer KEY_OEM_AX                        = $E1
        static constant integer KEY_OEM_102                       = $E2
        static constant integer KEY_ICO_HELP                      = $E3
        static constant integer KEY_ICO_00                        = $E4
        static constant integer KEY_PROCESSKEY                    = $E5
        static constant integer KEY_ICO_CLEAR                     = $E6
        static constant integer KEY_PACKET                        = $E7
        static constant integer KEY_OEM_RESET                     = $E9
        static constant integer KEY_OEM_JUMP                      = $EA
        static constant integer KEY_OEM_PA1                       = $EB
        static constant integer KEY_OEM_PA2                       = $EC
        static constant integer KEY_OEM_PA3                       = $ED
        static constant integer KEY_OEM_WSCTRL                    = $EE
        static constant integer KEY_OEM_CUSEL                     = $EF
        static constant integer KEY_OEM_ATTN                      = $F0
        static constant integer KEY_OEM_FINISH                    = $F1
        static constant integer KEY_OEM_COPY                      = $F2
        static constant integer KEY_OEM_AUTO                      = $F3
        static constant integer KEY_OEM_ENLW                      = $F4
        static constant integer KEY_OEM_BACKTAB                   = $F5
        static constant integer KEY_ATTN                          = $F6
        static constant integer KEY_CRSEL                         = $F7
        static constant integer KEY_EXSEL                         = $F8
        static constant integer KEY_EREOF                         = $F9
        static constant integer KEY_PLAY                          = $FA
        static constant integer KEY_ZOOM                          = $FB
        static constant integer KEY_NONAME                        = $FC
        static constant integer KEY_PA1                           = $FD
        static constant integer KEY_OEM_CLEAR                     = $FE
    endstruct

    // World position X
    native DzGetMouseTerrainX takes nothing returns real
    
    // World position Y
    native DzGetMouseTerrainY takes nothing returns real

    // World position Z (Terrain standard. and include floor dooded)
    native DzGetMouseTerrainZ takes nothing returns real

    // Mouse pointer hover in UI(interface)
    native DzIsMouseOverUI takes nothing returns boolean

    // Absolute window position X in Window
    native DzGetMouseX takes nothing returns integer

    // Absolute window position Y in Window
    native DzGetMouseY takes nothing returns integer

    // window position X in Window
    native DzGetMouseXRelative takes nothing returns integer

    // window position Y in Window
    native DzGetMouseYRelative takes nothing returns integer

    // Set mouse position in Window
    native DzSetMousePos takes integer x, integer y returns nothing

    // Register mouse event
    // btn = framehandle (default 0)
    // status = 0 is click, 1 is non-click
    // sync = case true calling TriggerExecute, in case false simple calling
    native DzTriggerRegisterMouseEvent takes trigger trig, integer btn, integer status, boolean sync, string func returns nothing

    // Register keyboard event
    // key = reference KeyType struct in this source file
    native DzTriggerRegisterKeyEvent takes trigger trig, integer key, integer status, boolean sync, string func returns nothing
    
    native DzTriggerRegisterMouseWheelEvent takes trigger trig, boolean sync, string func returns nothing

    native DzTriggerRegisterMouseMoveEvent takes trigger trig, boolean sync, string func returns nothing

    native DzGetTriggerKey takes nothing returns integer
    
    // Get mouse wheel physical value
    native DzGetWheelDelta takes nothing returns integer

    native DzIsKeyDown takes integer iKey returns boolean
    
    native DzGetTriggerKeyPlayer takes nothing returns player
    
    native DzGetWindowWidth takes nothing returns integer

    native DzGetWindowHeight takes nothing returns integer

    native DzGetWindowX takes nothing returns integer

    native DzGetWindowY takes nothing returns integer

    native DzTriggerRegisterWindowResizeEvent takes trigger trig, boolean sync, string func returns nothing

    native DzIsWindowActive takes nothing returns boolean

    //设置可摧毁物位置
    native DzDestructablePosition takes destructable d, real x, real y returns nothing

    //设置单位位置-本地调用
    native DzSetUnitPosition takes unit whichUnit, real x, real y returns nothing

    //异步执行函数
    native DzExecuteFunc takes string funcName returns nothing

    //取鼠标指向的unit
    native DzGetUnitUnderMouse takes nothing returns unit

    //设置unit的贴图
    native DzSetUnitTexture takes unit whichUnit, string path, integer texId returns nothing

    native DzSetMemory takes integer address, real value returns nothing

    native DzSetUnitModel takes unit whichUnit, string path returns nothing

    native DzSetUnitID takes unit whitchUnit, integer Id returns nothing

    native DzSetWar3MapMap takes string path returns nothing

    native DzGetLocale takes nothing returns string

    //注册数据同步trigger
    native DzTriggerRegisterSyncData takes trigger trig, string prefix, boolean server returns nothing

    //同步游戏数据
    native DzSyncData takes string prefix, string data returns nothing

    //获取同步的数据
    native DzGetTriggerSyncData takes nothing returns string

    //获取同步数据的玩家
    native DzGetTriggerSyncPlayer takes nothing returns player


    


endlibrary