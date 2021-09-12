library UserWidget
    

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
    //function JNFrameSetPoint takes integer frame, integer point, integer relative, integer relativePoint, real x, real y returns nothing

    function IsEnableChatBox takes nothing returns boolean
        return JNMemoryGetByte(GetGameDll() + 0xD04FEC) == 1
    endfunction
endlibrary
