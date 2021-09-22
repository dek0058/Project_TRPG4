library UUnitStateWidget uses UserWidget

    globals
        private integer array pBorderArray

        private integer array pNameArray
        private integer array pHpTextArray
        private integer array pMpTextArray

        private integer array pPortraitPtrArray
        private integer array pHpBarPtrArray
        private integer array pMpBarPtrArray
        private integer array pExpBarPtrArray

        private integer Count = 0    
    endglobals

    globals
        private constant real Width = 228.0
        private constant real Height = 80.0

        private constant real PortraitWidth = 72.0
        private constant real PortraitHeight = 72.0

        private constant real ProgressBarWidth = 146.0
        private constant real ProgressBarHeight = 25.0

        private constant real NameWidth = ProgressBarWidth
        private constant real NameHeight = 30.0

        private constant real IndicatorWidth = ProgressBarWidth
        private constant real IndicatorHeight = 25.0

        private constant real ExpBarWidth = 196.0
        private constant real ExpBarHegiht = 10.0

    endglobals

    public function Create takes nothing returns integer
        local integer handler
        local integer ptr = Count

        local real emptyX = ToUI(32)
        local real emptyY = ToUI(42)
        local real x = emptyX + ToUI(Width)
        local real y = emptyY + ToUI(Height)
        local real hx = x / 2.0
        local real hy = y / 2.0

        set handler = JNCreateFrameByType("FRAME", "", JNGetGameUI(), "", Count)
        call JNFrameClearAllPoints(handler)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_TOPLEFT, JNGetGameUI(), JN_FRAMEPOINT_TOPLEFT, emptyX, -emptyY)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_TOPRIGHT, JNGetGameUI(), JN_FRAMEPOINT_TOPLEFT, x, -emptyY)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_BOTTOMLEFT, JNGetGameUI(), JN_FRAMEPOINT_TOPLEFT, emptyX, -y)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_BOTTOMRIGHT, JNGetGameUI(), JN_FRAMEPOINT_TOPLEFT, x, -y)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_TOP, JNGetGameUI(), JN_FRAMEPOINT_TOPLEFT, hx, -emptyY)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_LEFT, JNGetGameUI(), JN_FRAMEPOINT_TOPLEFT, emptyX, -hy)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_CENTER, JNGetGameUI(), JN_FRAMEPOINT_TOPLEFT, hx, -hy)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_RIGHT, JNGetGameUI(), JN_FRAMEPOINT_TOPLEFT, x, -hy)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_BOTTOM, JNGetGameUI(), JN_FRAMEPOINT_TOPLEFT, hx, -y)
        set pBorderArray[ptr] = handler

        set handler = JNCreateFrameByType("TEXT", "", pBorderArray[ptr], "UNameText", Count)
        set x = ToUI(NameWidth) / 2.0
        set x = emptyX + ToUI(68) + x
        set y = JN_FRAME_MAX_HEIGHT - emptyY - ToUI(24)
        call SetFrameSize(handler, x, y, ToUI(NameWidth), ToUI(NameHeight))
        set pNameArray[ptr] = handler
        
        set x = ToUI(PortraitWidth) / 2.0
        set y = ToUI(PortraitHeight) / 2.0
        set x = emptyX + x
        set y = JN_FRAME_MAX_HEIGHT - emptyY - y
        set handler = UPortraitWidget_Create(x, y, ToUI(PortraitWidth), ToUI(PortraitHeight))
        call JNFrameSetParent(UPortraitWidget_GetBorder(handler), pBorderArray[ptr])
        set pPortraitPtrArray[ptr] = handler

        set x = ToUI(ProgressBarWidth) / 2.0
        set y = ToUI(ProgressBarHeight) / 2.0
        set x = emptyX + ToUI(64) + x
        set y = JN_FRAME_MAX_HEIGHT  - emptyY - ToUI(22) - y
        set handler = UProgressBarWidget_Create2Red(x, y, ToUI(ProgressBarWidth), ToUI(ProgressBarHeight))
        call JNFrameSetParent(UProgressBarWidget_GetBorder(handler), pBorderArray[ptr])
        set pHpBarPtrArray[ptr] = handler

        set handler = JNCreateFrameByType("TEXT", "", pBorderArray[ptr], "UIndicateText", Count)
        call SetFrameSize(handler, x, y, ToUI(IndicatorWidth), ToUI(IndicatorHeight))
        set pHpTextArray[ptr] = handler

        set x = ToUI(ProgressBarWidth) / 2.0
        set y = ToUI(ProgressBarHeight) / 2.0
        set x = emptyX + ToUI(64) + x
        set y = JN_FRAME_MAX_HEIGHT  - emptyY - ToUI(16) - ToUI(ProgressBarHeight) - y
        set handler = UProgressBarWidget_Create2Blue(x, y, ToUI(ProgressBarWidth), ToUI(ProgressBarHeight))
        call JNFrameSetParent(UProgressBarWidget_GetBorder(handler), pBorderArray[ptr])
        set pMpBarPtrArray[ptr] = handler

        set handler = JNCreateFrameByType("TEXT", "", pBorderArray[ptr], "UIndicateText", Count)
        call SetFrameSize(handler, x, y, ToUI(IndicatorWidth), ToUI(IndicatorHeight))
        set pMpTextArray[ptr] = handler

        set x = ToUI(ExpBarWidth) / 2.0
        set y = ToUI(ExpBarHegiht) / 2.0
        set x = emptyX + ToUI(10) + x
        set y = JN_FRAME_MAX_HEIGHT  - emptyY - ToUI(64) - y
        set handler = UProgressBar2Widget_Create2Green(x, y, ToUI(ExpBarWidth), ToUI(ExpBarHegiht))
        call JNFrameSetParent(UProgressBar2Widget_GetBorder(handler), pBorderArray[ptr])
        set pExpBarPtrArray[ptr] = handler

        set Count = Count + 1
        return Count
    endfunction
    
    //! runtextmacro GetUI("Border", "pBorderArray")

    public function SetName takes integer inPtr, string inName returns nothing
        call JNFrameSetText(pNameArray[inPtr], inName)
    endfunction

    public function SetPortrait takes integer inPtr, string inPath returns nothing
        call UPortraitWidget_SetPortrait(pPortraitPtrArray[inPtr], inPath)
    endfunction

    public function SetHpValue takes integer inPtr, real inPercent returns nothing
        call UProgressBarWidget_SetValue(pHpBarPtrArray[inPtr], inPercent)
        call JNFrameSetText(pHpTextArray[inPtr], I2S(R2I(inPercent * 100.0)) + "%")
    endfunction

    public function SetMpValue takes integer inPtr, real inPercent returns nothing
        call UProgressBarWidget_SetValue(pMpBarPtrArray[inPtr], inPercent)
        call JNFrameSetText(pMpTextArray[inPtr], I2S(R2I(inPercent * 100.0)) + "%")
    endfunction

    public function SetExpValue takes integer inPtr, real inPercent returns nothing
        call UProgressBar2Widget_SetValue(pExpBarPtrArray[inPtr], inPercent)
    endfunction

    public function Destroy takes integer inPtr returns nothing
        call UProgressBar2Widget_Destroy(pExpBarPtrArray[inPtr])
        call UProgressBarWidget_Destroy(pHpBarPtrArray[inPtr])
        call UProgressBarWidget_Destroy(pMpBarPtrArray[inPtr])
        call UPortraitWidget_Destroy(pPortraitPtrArray[inPtr])

        call JNDestroyFrame(pHpTextArray[inPtr])
        call JNDestroyFrame(pMpTextArray[inPtr])
        call JNDestroyFrame(pNameArray[inPtr])
        call JNDestroyFrame(pBorderArray[inPtr])
    endfunction

endlibrary