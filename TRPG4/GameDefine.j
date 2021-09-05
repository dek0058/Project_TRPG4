library GameDefine
    
    // @Setting
    globals
        
        constant integer PlayerMaxSlot = 12
        constant integer AbilityMaxSlot = 6
        

    endglobals


    // @Server
    globals
        constant string SyncClickEvent = "s1"
        constant integer SyncRightClickData = 0
        constant integer SyncLeftClickData = 1
    endglobals

    // @Local
    globals
        boolean FixedCamera = false
        
        integer ClickLimitedCount = 0
        constant integer MaxClickLimited = 1

        real ClickTime = 0.0
        constant real ClickResetTime = 0.18
    endglobals

endlibrary