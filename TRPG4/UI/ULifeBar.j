library ULifeBar
    
    globals
        private integer ProgressBar = 0
        private integer Text = 0
    endglobals

    globals
        private real Width = 0.17757
        private real Height = 0.03840
    endglobals

    public function Create takes real inX, real inY returns nothing
        set ProgressBar = JNCreateFrameByType("SPRITE", "", JNGetGameUI(), "ULifeBar", 0)
        call SetFramePosition(handler, inX, inY)
        call DzFrameSetSize(handler, Wdith, Height)
        call DzFrameSetAnimate(handler, 0, false)
        call DzFrameSetAnimateOffset(handler, 100.0)

        set Text = JNCreateFrameByType("TEXT", "", JNGetGameUI(), "UIndicateText", 0)
        call SetFramePosition(handler, inX, inY)
        call DzFrameSetSize(handler, Wdith, Height)
    endfunction
    
    public function Enable takes boolean inEnable returns nothing
        call JNFrameSetVisible(ProgressBar, inEnable)
        call JNFrameSetVisible(Text, inEnable)
    endfunction

    public function Set takes real inPercentage returns nothing
        local real value

        if ProgressBar == 0 or Text == 0 then
            return
        endif

        set value = FMath.max(0.0, inPercentage)
        call DzFrameSetAnimateOffset(ProgressBar, inPercentage * 60.0)

        call DzFrameSetText(Text, I2S(R2I(value * 100.0)) + "%")
    endfunction
endlibrary
