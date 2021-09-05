library MasterCmd uses Controller

    private function MaterCmd takes nothing returns boolean
        local Controller controller = Controller[GetChatPlayer()]
        call controller.SetVision(VISION_MASTER, true)
        return false
    endfunction

    private function Test1Cmd takes nothing returns boolean
        local Controller controller = Controller[GetChatPlayer()]
        local integer handler

        call BJDebugMsg("테스트 1 명령어 입니다.")

        //call JNHideOriginFrames()
        set handler = JNGetFrameByName("TestDebugBTN", NULL)
        if handler != NULL then
            call JNDestroyFrame(handler)
        endif
        
        return false
    endfunction

    private function Test2Cmd takes nothing returns boolean
        local Controller controller = Controller[GetChatPlayer()]
        local integer argc = GetArgsCount()
        local integer value
        local integer handler

        call BJDebugMsg(I2S(GetArgsCount()))

        if argc < 3 then
            return false
        endif

        set value = S2I(GetArgs(2))
        // set x = S2I(GetArgs(2))
        // set y = S2I(GetArgs(3))

        set handler = JNGetFrameByName("LogDialog", NULL)
        call JNFrameSetLevel(handler, value)
        call DisplayTextToPlayer(controller.Value(), 0.0, 0.0, "테스트 2 명령어 입니다." + I2S(value))
        
        set handler = JNCreateFrameByType("GLUETEXTBUTTON", "TestDebugBTN", JNGetGameUI(), "DebugButton", NULL)
        call JNFrameSetPoint(handler, JN_FRAMEPOINT_CENTER, JNGetGameUI(), JN_FRAMEPOINT_CENTER, 0.0, 0.0)
        call DzFrameSetText(handler, "게임 시작")
        call DzFrameSetSize(handler, 0.1, 0.03)


        return false
    endfunction

    function InitMasterCmd takes nothing returns nothing
        call AddCommand.evaluate("master", Filter(function MaterCmd))
        call AddCommand.evaluate("test1", Filter(function Test1Cmd))
        call AddCommand.evaluate("test2", Filter(function Test2Cmd))
    endfunction
endlibrary