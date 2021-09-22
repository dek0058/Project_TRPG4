library UAbilitySlot uses UserWidget

    globals
        private integer array Slot
        private integer array Type
        private integer Count = 0
    endglobals
    
    //public function Set takes integer inHandler, 

    public function Create takes real inX, real inY, real inWidth, real inHeight returns integer
        local integer handler = 0
        local integer ptr = NULL
        // local real x
        // local real y
        // local real centerX
        // local real centerY
        // local FVector topLeft = FVector.create(0.0, 0.0, 0.0)
        // local FVector topRight = FVector.create(0.0, 0.0, 0.0)
        // local FVector bottomLeft = FVector.create(0.0, 0.0, 0.0)
        // local FVector bottomRight = FVector.create(0.0, 0.0, 0.0)
        // local integer ptr

        // set handler = JNCreateFrameByType("BACKDROP", "", JNGetGameUI(), "UEmptySlot", Count)
        // set x = inX
        // set y = inY
        // set centerX = inWidth / 2.0
        // set centerY = inHeight / 2.0
        // call topLeft.Set(x - centerX, y + centerY, 0.0)
        // call topRight.Set(x + centerX, y + centerY, 0.0)
        // call bottomLeft.Set(x - centerX, y - centerY, 0.0)
        // call bottomRight.Set(x + centerX, y - centerY, 0.0)
        // call SetFramePoint(handler, topLeft.x, topLeft.y, topRight.x, topRight.y, bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y)
        // set Slot[Count] = handler

        // set handler = JNCreateFrameByType("BACKDROP", "", JNGetGameUI(), "UEmptySlot", Count)
        // call JNFrameSetTexture(handler, UI_SLOT_RARE, 0)
        // set x = inX
        // set y = inY
        // set centerX = inWidth / 2.0
        // set centerY = inHeight / 2.0
        // call topLeft.Set(x - centerX, y + centerY, 0.0)
        // call topRight.Set(x + centerX, y + centerY, 0.0)
        // call bottomLeft.Set(x - centerX, y - centerY, 0.0)
        // call bottomRight.Set(x + centerX, y - centerY, 0.0)
        // call SetFramePoint(handler, topLeft.x, topLeft.y, topRight.x, topRight.y, bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y)
        // set Type[Count] = handler

        // set ptr = Count
        // set Count = Count + 1

        // call topLeft.destroy()
        // call topRight.destroy()
        // call bottomLeft.destroy()
        // call bottomRight.destroy()

        return ptr
    endfunction



endlibrary