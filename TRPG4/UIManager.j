library UIManager uses UserWidget, FVector

    globals
        private boolean IsShowUserInterface = false
    endglobals
    
    function EnableUserInterface takes boolean inEnable returns nothing
        if IsLocalPlayer() == false then
            return
        endif

        call JNFrameSetVisible(LifeBarHandler, inEnable)
        call JNFrameSetVisible(LifeBarTextHandler, inEnable)

        call JNFrameSetVisible(ManaBarHandler, inEnable)
        call JNFrameSetVisible(ManaBarTextHandler, inEnable)

        set IsShowUserInterface = inEnable
    endfunction

    function IsUserInterface takes nothing returns boolean
        return IsShowUserInterface
    endfunction

    function InitUIManager takes nothing returns nothing
        local integer handler = NULL
        local FVector topLeft = FVector.create(0.0, 0.0, 0.0)
        local FVector topRight = FVector.create(0.0, 0.0, 0.0)
        local FVector bottomLeft = FVector.create(0.0, 0.0, 0.0)
        local FVector bottomRight = FVector.create(0.0, 0.0, 0.0)
        local real x = 0.0
        local real y = 0.0
        local real centerX = 0.0
        local real centerY = 0.0

        debug call WriteLog("TRPG4", "UIManager", "InitUIManager", "Calling")

        // @기본 설정
        //call JNEnableWideScreen(true)
        //call EnablePreSelect(false, false)    // Tab시 페이탈 원인
        call EnableSelect(false, false)
        call EnableUserUI(false)
        call JNFrameEditBlackBorders(0.0, 0.0)
        call JNHideOriginFrames()
        call EnableDragSelect( false, false )

        // @기본 UI 설정
        // 싱글일 경우 예외처리
        if IsSingleMode() == true then
            // [XXX] 오류가 나더라도 z-order 설정을 해주어야함.
            set handler = JNGetFrameByName("LogDialog", NULL)
            //call JNFrameSetLevel(handler, FMath.MaxInt)
        else
            // [XXX] 오류가 나더라도 z-order 설정을 해주어야함.
            set handler = JNGetFrameByName("ChatDialog", NULL)
            //call JNFrameSetLevel(handler, FMath.MaxInt)
        endif

        // 채팅
        set handler = JNFrameGetChatMessage()
        call topLeft.Set(0.02, JN_FRAME_MAX_HEIGHT, 0.0)
        call topRight.Set(JN_FRAME_MAX_WIDTH, JN_FRAME_MAX_HEIGHT, 0.0)
        call bottomLeft.Set(0.02, 0.2, 0.0)
        call bottomRight.Set(JN_FRAME_MAX_WIDTH, 0.2, 0.0)
        call SetFramePoint(handler, topLeft.x, topLeft.y, topRight.x, topRight.y, bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y)
        call JNFrameSetFont(handler, DefaultFontPath, 0.011, NULL)

        // 트리거 메세지
        set handler = JNFrameGetUnitMessage()
        call topLeft.Set(0.0, JN_FRAME_MAX_HEIGHT, 0.0)
        call topRight.Set(JN_FRAME_MAX_WIDTH, JN_FRAME_MAX_HEIGHT, 0.0)
        call bottomLeft.Set(0.0, 0.2, 0.0)
        call bottomRight.Set(JN_FRAME_MAX_WIDTH, 0.2, 0.0)
        call SetFramePoint(handler, topLeft.x, topLeft.y, topRight.x, topRight.y, bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y)
        call JNFrameSetFont(handler, DefaultBoldFontPath, 0.018, NULL)
        call JNFrameSetTextAlignment(handler, JN_TEXT_JUSTIFY_CENTER, JN_TEXT_JUSTIFY_CENTER)
        
        // 버튼 설정
        set handler = JNGetFrameByName("RestartButton", NULL)
        call JNFrameSetEnable(handler, false)
        call JNFrameSetVisible(handler, false)

        // 미니맵 설정
        set handler = JNFrameGetMinimap()
        call JNFrameSetAlpha(handler, 0)

        // Custom UI Load
        call JNLoadTOCFile("TRPG4.toc")

        set handler = JNCreateFrameByType("SPRITE", "", JNGetGameUI(), "ULifeBar", 0)
        set x = 0.08
        set y = 0.55
        call SetFramePosition(handler, x, y)
        call DzFrameSetAnimate(handler, 0, false)
        call DzFrameSetAnimateOffset(handler, 100.0)
        set LifeBarHandler = handler
        
        set handler = JNCreateFrameByType("TEXT", "", JNGetGameUI(), "UIndicateText", 0)
        call SetFramePosition(handler, x, y)
        set LifeBarTextHandler = handler

        set handler = JNCreateFrameByType("SPRITE", "", JNGetGameUI(), "UManaBar", 0)
        set x = 0.08
        set y = 0.55 - 0.03
        call SetFramePosition(handler, x, y)
        call DzFrameSetAnimate(handler, 0, false)
        call DzFrameSetAnimateOffset(handler, 100.0)
        set ManaBarHandler = handler

        set handler = JNCreateFrameByType("TEXT", "", JNGetGameUI(), "UIndicateText", 1)
        call SetFramePosition(handler, x, y)
        set ManaBarTextHandler = handler
        
        set handler = JNCreateFrameByType("BACKDROP", "", JNGetGameUI(), "UEmptySlot", 0)
        set x = 0.1
        set y = 0.06
        set centerX = 0.0703125
        set centerY = 0.0703125
        call topLeft.Set(x - centerX, y + centerY, 0.0)
        call topRight.Set(x + centerX, y + centerY, 0.0)
        call bottomLeft.Set(x - centerX, y - centerY, 0.0)
        call bottomRight.Set(x + centerX, y - centerY, 0.0)
        call SetFramePoint(handler, topLeft.x, topLeft.y, topRight.x, topRight.y, bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y)
        set LeftMainSlot = handler

        set handler = JNCreateFrameByType("BACKDROP", "", JNGetGameUI(), "UEmptySlot", 0)
        set x = 0.7
        set y = 0.06
        set centerX = 0.0703125
        set centerY = 0.0703125
        call topLeft.Set(x - centerX, y + centerY, 0.0)
        call topRight.Set(x + centerX, y + centerY, 0.0)
        call bottomLeft.Set(x - centerX, y - centerY, 0.0)
        call bottomRight.Set(x + centerX, y - centerY, 0.0)
        call SetFramePoint(handler, topLeft.x, topLeft.y, topRight.x, topRight.y, bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y)
        set RightMainSlot = handler


        //call DzFrameSetTexture(handler, "UI\\ui_slot_comon.tga", 0)


        call EnableUserInterface(false)

        call topLeft.destroy()
        call topRight.destroy()
        call bottomLeft.destroy()
        call bottomRight.destroy()
    endfunction

endlibrary
