library UManaBar uses UserWidget
    
    globals
        private integer ProgressBar = 0
        private integer Text = 0
    endglobals

    globals
        private constant real Width = 0.17757
        private constant real Height = 0.03840
    endglobals

    public function Create takes real inX, real inY returns nothing
        set ProgressBar = JNCreateFrameByType("SPRITE", "", JNGetGameUI(), "ULifeBar", 0)
        call SetFramePosition(ProgressBar, inX, inY)
        call DzFrameSetSize(ProgressBar, Width, Height)
        call DzFrameSetAnimate(ProgressBar, 0, false)
        call DzFrameSetAnimateOffset(ProgressBar, 100.0)

        set Text = JNCreateFrameByType("TEXT", "", JNGetGameUI(), "UIndicateText", 0)
        call SetFramePosition(Text, inX, inY)
        call DzFrameSetSize(Text, Width, Height)
    endfunction
    
    public function Enable takes boolean inEnable returns nothing
        call JNFrameSetVisible(ProgressBar, inEnable)
        call JNFrameSetVisible(Text, inEnable)
    endfunction

    public function Set takes real inWeight returns nothing
        local real value

        if ProgressBar == 0 or Text == 0 then
            return
        endif

        set value = FMath.max(0.0, inWeight)
        call DzFrameSetAnimateOffset(ProgressBar, inWeight * 60.0)

        call DzFrameSetText(Text, I2S(R2I(value * 100.0)) + "%")
    endfunction
endlibrary
