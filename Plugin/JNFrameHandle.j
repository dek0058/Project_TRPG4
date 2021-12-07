library JNFrameHandle

    globals
        
    endglobals

    struct FrameHandleAnchor
        // Point
        static constant integer POINT_TOP_LEFT                = 0
        static constant integer POINT_TOP                     = 1
        static constant integer POINT_TOP_RIGHT               = 2
        static constant integer POINT_LEFT                    = 3
        static constant integer POINT_CENTER                  = 4
        static constant integer POINT_RIGHT                   = 5
        static constant integer POINT_BOTTOM_LEFT             = 6
        static constant integer POINT_BOTTOM                  = 7
        static constant integer POINT_BOTTOM_RIGHT            = 8

        // Text Justif
        static constant integer JUSTIFY_TOP                   = 0
        static constant integer JUSTIFY_MIDDLE                = 1
        static constant integer JUSTIFY_BOTTOM                = 2
        static constant integer JUSTIFY_LEFT                  = 3
        static constant integer JUSTIFY_CENTER                = 4
        static constant integer JUSTIFY_RIGHT                 = 5

        // Event
        static constant integer EVENT_CONTROL_CLICK           = 1
        static constant integer EVENT_MOUSE_ENTER             = 2
        static constant integer EVENT_MOUSE_LEAVE             = 3
        static constant integer EVENT_MOUSE_UP                = 4
        static constant integer EVENT_MOUSE_DOWN              = 5
        static constant integer EVENT_MOUSE_WHEEL             = 6
        static constant integer EVENT_CHECKBOX_CHECKED        = 7
        static constant integer EVENT_CHECKBOX_UNCHECKED      = 8
        static constant integer EVENT_EDITBOX_TEXT_CHANGED    = 9
        static constant integer EVENT_POPUPMENU_ITEM_CHANGED  = 10
        static constant integer EVENT_MOUSE_DOUBLECLICK       = 11
        static constant integer EVENT_SPRITE_ANIM_UPDATE      = 12
        static constant integer EVENT_SLIDER_VALUE_CHANGED    = 13
        static constant integer EVENT_DIALOG_CANCEL           = 14
        static constant integer EVENT_DIALOG_ACCEPT           = 15
        static constant integer EVENT_EDITBOX_ENTER           = 16

        // Scale
        static constant real MAX_WIDTH                        = 0.8
        static constant real MAX_HEIGHT                       = 0.6
        static constant real CENTER_X                         = 0.4
        static constant real CENTER_Y                         = 0.3

        /*
        constant real JN_FRAME_ITEM_BUTTON_SIZE               = 0.03125
        constant real JN_FRAME_ITEM_BUTTON_SPACING_WIDTH      = 0.00875
        constant real JN_FRAME_ITEM_BUTTON_SPACING_HEIGHT     = 0.0068625
        */

    endstruct


endlibrary