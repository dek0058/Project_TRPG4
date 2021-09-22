library UProgressBarWidget uses UserWidget

    globals
        private constant string Path_ProgressBarEmpty = "UI\\ProgressBar\\ProgressBarEmpty.blp"
        private constant string Path_ProgressBarFrame = "UI\\ProgressBar\\ProgressBarFrame.blp"
        private constant string Path_ProgressBarStrenth = "UI\\ProgressBar\\ProgressBarStrenth.blp"

        private constant string Path_ProgressBarBlue = "UI\\ProgressBar\\ProgressBarBlue.blp"
        private constant string Path_ProgressBarGreen = "UI\\ProgressBar\\ProgressBarGreen.blp"
        private constant string Path_ProgressBarRed = "UI\\ProgressBar\\ProgressBarRed.blp"
        private constant string Path_ProgressBarYellow = "UI\\ProgressBar\\ProgressBarYellow.blp"
        private constant string Path_ProgressBarOrenge = "UI\\ProgressBar\\ProgressBarOrenge.blp"
    endglobals

    globals
        private integer array pBorderArray
        private integer array pFillBorderArray
        
        private integer array pEmptyArray
        private integer array pFrameArray
        private integer array pStrenthArray
        private integer array pFillArray
        
        private real array pMinValueArray
        private real array pMaxValueArray

        private integer Count = 0
    endglobals

    globals
        private constant real FrameWidth = 152.0
        private constant real FrameHeight = 32.0
        private constant real EmptyWidth = 10.0
        private constant real EmptyHeight = 10.0
    endglobals

    //! textmacro CreateProgressBar takes NAME, PATH
    public function $NAME$ takes real inX, real inY, real inWidth, real inHeight returns integer
        local integer handler
        local integer ptr = Count
        local real ratioX = inWidth / ToUI(FrameWidth)
        local real ratioY = inHeight / ToUI(FrameHeight)
        local real emptyX = ToUI(EmptyWidth * ratioX)
        local real emptyY = ToUI(EmptyHeight * ratioY)
        local real hw = inWidth / 2.0
        
        set handler = JNCreateFrameByType("FRAME", "", JNGetGameUI(), "", Count)
        call SetFrameSize(handler, inX, inY, inWidth, inHeight)
        set pBorderArray[ptr] = handler

        set handler = JNCreateFrameByType("BACKDROP", "", pBorderArray[ptr], "", Count)
        call JNFrameSetTexture(handler, Path_ProgressBarEmpty, 0)
        call SetFrameSizeOnParent(handler, pBorderArray[ptr])
        call JNFrameSetLevel(handler, -1)
        set pEmptyArray[ptr] = handler
        
        set handler = JNCreateFrameByType("FRAME", "", pBorderArray[ptr], "", Count)
        call JNFrameClearAllPoints(handler)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_TOPLEFT, pBorderArray[ptr], JN_FRAMEPOINT_TOPLEFT, emptyX, -emptyY)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_TOPRIGHT, pBorderArray[ptr], JN_FRAMEPOINT_TOPRIGHT, -emptyX, -emptyY)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_BOTTOMLEFT, pBorderArray[ptr], JN_FRAMEPOINT_BOTTOMLEFT, emptyX, emptyY)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_BOTTOMRIGHT, pBorderArray[ptr], JN_FRAMEPOINT_BOTTOMRIGHT, -emptyX, emptyY)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_TOP, pBorderArray[ptr], JN_FRAMEPOINT_TOP, 0.0, -emptyX)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_LEFT, pBorderArray[ptr], JN_FRAMEPOINT_LEFT, emptyX, 0.0)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_CENTER, pBorderArray[ptr], JN_FRAMEPOINT_CENTER, 0.0, 0.0)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_RIGHT, pBorderArray[ptr], JN_FRAMEPOINT_RIGHT, -emptyX, 0.0)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_BOTTOM, pBorderArray[ptr], JN_FRAMEPOINT_BOTTOM, 0.0, emptyY)
        call JNFrameSetLevel(handler, 0)
        set pFillBorderArray[ptr] = handler

        set handler = JNCreateFrameByType("BACKDROP", "", pFillBorderArray[ptr], "", Count)
        call JNFrameSetTexture(handler, $PATH$, 0)
        call SetFrameSizeOnParent(handler, pFillBorderArray[ptr])
        set pFillArray[ptr] = handler
        
        set handler = JNCreateFrameByType("BACKDROP", "", pBorderArray[ptr], "", Count)
        call JNFrameSetTexture(handler, Path_ProgressBarStrenth, 0)
        call SetFrameSizeOnParent(handler, pBorderArray[ptr])
        call JNFrameSetLevel(handler, 1)
        set pStrenthArray[ptr] = handler
        
        set handler = JNCreateFrameByType("BACKDROP", "", pBorderArray[ptr], "", Count)
        call JNFrameSetTexture(handler, Path_ProgressBarFrame, 0)
        call SetFrameSizeOnParent(handler, pBorderArray[ptr])
        call JNFrameSetLevel(handler, 2)
        set pFrameArray[ptr] = handler
        
        set pMinValueArray[ptr] = inX - hw + emptyX
        set pMaxValueArray[ptr] = inX + hw - emptyX

        set Count = Count + 1
        return ptr
    endfunction
    //! endtextmacro

    //! runtextmacro CreateProgressBar("Create2Blue", "Path_ProgressBarBlue")
    //! runtextmacro CreateProgressBar("Create2Green", "Path_ProgressBarGreen")
    //! runtextmacro CreateProgressBar("Create2Red", "Path_ProgressBarRed")
    //! runtextmacro CreateProgressBar("Create2Yellow", "Path_ProgressBarYellow")
    //! runtextmacro CreateProgressBar("Create2Orenge", "Path_ProgressBarOrenge")

    //! runtextmacro GetUI("Border", "pBorderArray")

    //! runtextmacro SetValue("pFillBorderArray", "pFillArray", "pMinValueArray", "pMaxValueArray")

    public function Destroy takes integer inPtr returns nothing
        call JNDestroyFrame(pFrameArray[inPtr])
        call JNDestroyFrame(pStrenthArray[inPtr])
        call JNDestroyFrame(pFillArray[inPtr])
        call JNDestroyFrame(pEmptyArray[inPtr])
        call JNDestroyFrame(pFillBorderArray[inPtr])
        call JNDestroyFrame(pBorderArray[inPtr])
    endfunction
endlibrary