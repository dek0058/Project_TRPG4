library UserWidget
    
    function SetFrameSize takes integer inFrame, real inX, real inY, real inWidth, real inHeight returns nothing
        local real hw = inWidth / 2.0
        local real hh = inHeight / 2.0

        call JNFrameClearAllPoints(inFrame)

        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_TOPLEFT, inX - hw, inY + hh)
        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_TOPRIGHT, inX + hw, inY + hh)
        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_BOTTOMLEFT, inX - hw, inY - hh)
        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_BOTTOMRIGHT, inX + hw, inY - hh)

        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_TOP, inX, inY + hh)
        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_LEFT, inX - hw, inY)
        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_CENTER, inX, inY)
        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_RIGHT, inX + hw, inY)
        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_BOTTOM, inX, inY - hh)
    endfunction
    
    function SetFramePoint takes integer inFrame, real inTLX, real inTLY, real inTRX, real inTRY, real inBLX, real inBLY, real inBRX, real inBRY returns nothing
        call JNFrameClearAllPoints(inFrame)
        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_TOPLEFT, inTLX, inTLY)
        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_TOPRIGHT, inTRX, inTRY)
        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_BOTTOMLEFT, inBLX, inBLY)
        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_BOTTOMRIGHT, inBRX, inBRY)
    endfunction
    
    function SetFramePosition takes integer inFrame, real inX, real inY returns nothing
        call JNFrameClearAllPoints(inFrame)
        call JNFrameSetAbsPoint(inFrame, JN_FRAMEPOINT_CENTER, inX, inY)
    endfunction

    function SetFrameSizeOnParent takes integer inFrame, integer inParent returns nothing
        call JNFrameClearAllPoints(inFrame)
        call JNFrameSetPoint(inFrame, JN_FRAMEPOINT_TOPLEFT, inParent, JN_FRAMEPOINT_TOPLEFT, 0.0, 0.0)
        call JNFrameSetPoint(inFrame, JN_FRAMEPOINT_TOPRIGHT, inParent, JN_FRAMEPOINT_TOPRIGHT, 0.0, 0.0)
        call JNFrameSetPoint(inFrame, JN_FRAMEPOINT_BOTTOMLEFT, inParent, JN_FRAMEPOINT_BOTTOMLEFT, 0.0, 0.0)
        call JNFrameSetPoint(inFrame, JN_FRAMEPOINT_BOTTOMRIGHT, inParent, JN_FRAMEPOINT_BOTTOMRIGHT, 0.0, 0.0)
        call JNFrameSetPoint(inFrame, JN_FRAMEPOINT_TOP, inParent, JN_FRAMEPOINT_TOP, 0.0, 0.0)
        call JNFrameSetPoint(inFrame, JN_FRAMEPOINT_LEFT, inParent, JN_FRAMEPOINT_LEFT, 0.0, 0.0)
        call JNFrameSetPoint(inFrame, JN_FRAMEPOINT_CENTER, inParent, JN_FRAMEPOINT_CENTER, 0.0, 0.0)
        call JNFrameSetPoint(inFrame, JN_FRAMEPOINT_RIGHT, inParent, JN_FRAMEPOINT_RIGHT, 0.0, 0.0)
        call JNFrameSetPoint(inFrame, JN_FRAMEPOINT_BOTTOM, inParent, JN_FRAMEPOINT_BOTTOM, 0.0, 0.0)
    endfunction

    function ToUI takes real inValue returns real
        return 0.00078125 * inValue
    endfunction

    function IsEnableChatBox takes nothing returns boolean
        return JNMemoryGetByte(GetGameDll() + 0xD04FEC) == 1
    endfunction

    function GetRelativeWidth takes nothing returns real
        return I2R(JNMemoryGetInteger(GetGameDll() + 0xD05000))
    endfunction

    function GetRelativeHeight takes nothing returns real
        return I2R(JNMemoryGetInteger(GetGameDll() + 0xD05004))
    endfunction

    function GetAbsWidth takes nothing returns real
        return I2R(JNMemoryGetInteger(GetGameDll() + 0xCB2274))
    endfunction

    function GetAbsHeight takes nothing returns real
        return I2R(JNMemoryGetInteger(GetGameDll() + 0xCB2278))
    endfunction
endlibrary
