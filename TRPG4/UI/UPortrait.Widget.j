library UPortraitWidget uses UserWidget

    globals
        private constant string Path_PortraitFrame = "UI\\PortraitFrame.blp"
    endglobals

    globals
        private integer array pBorderArray

        private integer array pFrameArray
        private integer array pPortraitArray

        private integer Count = 0
    endglobals

    public function Create takes real inX, real inY, real inWidth, real inHeight returns integer
        local integer handler
        local integer ptr = Count
        
        set handler = JNCreateFrameByType("FRAME", "", JNGetGameUI(), "", Count)
        call SetFrameSize(handler, inX, inY, inWidth, inHeight)
        set pBorderArray[ptr] = handler


        set handler = JNCreateFrameByType("BACKDROP", "", pBorderArray[ptr], "", Count)
        call JNFrameSetTexture(handler, Portrait_Empty_Path, 0)
        call SetFrameSizeOnParent(handler, pBorderArray[ptr])
        call JNFrameSetLevel(handler, -1)
        set pPortraitArray[ptr] = handler

        set handler = JNCreateFrameByType("BACKDROP", "", pBorderArray[ptr], "", Count)
        call JNFrameSetTexture(handler, Path_PortraitFrame, 0)
        call SetFrameSizeOnParent(handler, pBorderArray[ptr])
        call JNFrameSetLevel(handler, 0)
        set pFrameArray[ptr] = handler

        set Count = Count + 1
        return ptr
    endfunction

    public function SetPortrait takes integer inPtr, string inPath returns nothing
        call JNFrameSetTexture(pPortraitArray[inPtr], inPath, 0)
    endfunction

    //! runtextmacro GetUI("Border", "pBorderArray")

    public function Destroy takes integer inPtr returns nothing
        call JNDestroyFrame(pFrameArray[inPtr])
        call JNDestroyFrame(pPortraitArray[inPtr])
        call JNDestroyFrame(pBorderArray[inPtr])
    endfunction

endlibrary