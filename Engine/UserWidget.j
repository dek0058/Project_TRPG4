library UserWidget
    

    function SetFramePoint takes integer inFrame, real inTLX, real inTLY, real inTRX, real inTRY, real inBLX, real inBLY, real inBRX, real inBRY returns nothing
        call JNFrameClearAllPoints(inFrame)
        call DzFrameSetAbsolutePoint(inFrame, JN_FRAMEPOINT_TOPLEFT, inTLX, inTLY)
        call DzFrameSetAbsolutePoint(inFrame, JN_FRAMEPOINT_TOPRIGHT, inTRX, inTRY)
        call DzFrameSetAbsolutePoint(inFrame, JN_FRAMEPOINT_BOTTOMLEFT, inBLX, inBLY)
        call DzFrameSetAbsolutePoint(inFrame, JN_FRAMEPOINT_BOTTOMRIGHT, inBRX, inBRY)
    endfunction

    //function JNFrameSetPoint takes integer frame, integer point, integer relative, integer relativePoint, real x, real y returns nothing

    
endlibrary
