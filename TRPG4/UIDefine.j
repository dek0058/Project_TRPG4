library UIDefine
    
    globals
        constant real CenterX = JN_FRAME_MAX_WIDTH / 2.0
        constant real CenterY = JN_FRAME_MAX_HEIGHT / 2.0
    endglobals
    
    // Common Path
    globals
        constant string Default_Font_Path = "Font\\Maplestory Light.ttf"
        constant string Default_Bold_Font_Path = "Font\\Maplestory Bold.ttf"
    endglobals

    // Portrait Path
    globals
        constant string Portrait_Empty_Path = "UI\\Portrait\\Empty.blp"
        constant string Portrait_Megumin_Path = "UI\\Portrait\\Megumin.blp"

    endglobals

    // Ability Path
    globals
        constant string Ability_Empty_Path = "UI\\Ability\\Empty.blp"
    endglobals

    
    //! textmacro GetUI takes NAME, arrVAR
    public function Get$NAME$ takes integer inPtr returns integer
        if inPtr < 0 or inPtr >= Count then
            return NULL
        endif
        return $arrVAR$[inPtr]
    endfunction
    //! endtextmacro

    //! textmacro SetValue takes arrHANDLER, arrPARENT, arrMinValue, arrMaxValue
    public function SetValue takes integer inPtr, real inPercent returns nothing
        local integer parent = $arrPARENT$[inPtr]
        local integer handler = $arrHANDLER$[inPtr]
        local real min = $arrMinValue$[inPtr]
        local real max = $arrMaxValue$[inPtr]
        local real default = min - max
        local real value = default * inPercent
        local real result = (default - value)

        call JNFrameSetPoint(handler, JN_FRAMEPOINT_TOPRIGHT, parent, JN_FRAMEPOINT_TOPRIGHT, result, 0.0)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_BOTTOMRIGHT, parent, JN_FRAMEPOINT_BOTTOMRIGHT, result, 0.0)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_RIGHT, parent, JN_FRAMEPOINT_RIGHT, result, 0.0)

        call JNFrameSetPoint(handler, JN_FRAMEPOINT_TOP, parent, JN_FRAMEPOINT_TOP, result / 2.0, 0.0)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_BOTTOM, parent, JN_FRAMEPOINT_BOTTOM, result / 2.0, 0.0)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_CENTER, parent, JN_FRAMEPOINT_CENTER, result / 2.0, 0.0)
    endfunction
    //! endtextmacro

endlibrary