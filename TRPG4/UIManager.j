library UIManager uses UserWidget, FVector
    
    globals
        constant string DefaultFontPath = "Font\\Maplestory Light.ttf"
        constant string DefaultBoldFontPath = "Font\\Maplestory Bold.ttf"
    endglobals



    function InitUIManager takes nothing returns nothing
        local integer handler = 0
        local real centerX = JN_FRAME_MAX_WIDTH / 2.0
        local real centerY = JN_FRAME_MAX_HEIGHT / 2.0
        local FVector topLeft = FVector.create(0.0, 0.0, 0.0)
        local FVector topRight = FVector.create(0.0, 0.0, 0.0)
        local FVector bottomLeft = FVector.create(0.0, 0.0, 0.0)
        local FVector bottomRight = FVector.create(0.0, 0.0, 0.0)

        debug call WriteLog("TRPG4", "UIManager", "InitUIManager", "Calling")

        // @기본 설정
        call JNFrameEditBlackBorders(0.0, 0.0)
        call JNHideOriginFrames()
        call EnableDragSelect( false, false )

        // @기본 UI 설정
        // 싱글일 경우 예외처리
        if IsSingleMode() == true then
            // [XXX] 오류가 나더라도 z-order 설정을 해주어야함.
            set handler = JNGetFrameByName("LogDialog", 0)
            call JNFrameSetLevel(handler, FMath.MaxInt)
        else
            // [XXX] 오류가 나더라도 z-order 설정을 해주어야함.
            set handler = JNGetFrameByName("ChatDialog", 0)
            call JNFrameSetLevel(handler, FMath.MaxInt)
        endif

        // 채팅
        set handler = JNFrameGetChatMessage()
        call topLeft.Set(0.02, JN_FRAME_MAX_HEIGHT, 0.0)
        call topRight.Set(JN_FRAME_MAX_WIDTH, JN_FRAME_MAX_HEIGHT, 0.0)
        call bottomLeft.Set(0.02, 0.2, 0.0)
        call bottomRight.Set(JN_FRAME_MAX_WIDTH, 0.2, 0.0)
        call SetFramePoint(handler, topLeft.x, topLeft.y, topRight.x, topRight.y, bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y)
        call JNFrameSetFont(handler, DefaultFontPath, 0.011, 0)

        // 트리거 메세지
        set handler = JNFrameGetUnitMessage()
        call topLeft.Set(0.0, JN_FRAME_MAX_HEIGHT, 0.0)
        call topRight.Set(JN_FRAME_MAX_WIDTH, JN_FRAME_MAX_HEIGHT, 0.0)
        call bottomLeft.Set(0.0, 0.2, 0.0)
        call bottomRight.Set(JN_FRAME_MAX_WIDTH, 0.2, 0.0)
        call SetFramePoint(handler, topLeft.x, topLeft.y, topRight.x, topRight.y, bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y)
        call JNFrameSetFont(handler, DefaultBoldFontPath, 0.018, 0)
        call JNFrameSetTextAlignment(handler, JN_TEXT_JUSTIFY_CENTER, JN_TEXT_JUSTIFY_CENTER)
        
        // 버튼 설정
        set handler = JNGetFrameByName("RestartButton", 0)
        call JNFrameSetEnable(handler, false)
        call JNFrameSetVisible(handler, false)
    endfunction

endlibrary
