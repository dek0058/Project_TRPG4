library UAbilitySlotWidget uses UserWidget

    globals
        private integer array pBorderArray
        
        private integer array pEmptyArray
        private integer array pFillArray
        private integer array pFrameArray

        private integer Count = 0
    endglobals
    
    public function Create takes real inX, real inY, real inWidth, real inHeight returns integer
        local integer handler
        local integer ptr = Count

        set Count = Count + 1
        return ptr
    endfunction


    //! runtextmacro GetUI("Border", "pBorderArray")
    

    public function Destroy takes integer inPtr returns nothing
        call JNDestroyFrame(pBorderArray[inPtr])
        call JNDestroyFrame(pEmptyArray[inPtr])
        call JNDestroyFrame(pFillArray[inPtr])
        call JNDestroyFrame(pFrameArray[inPtr])
    endfunction

endlibrary