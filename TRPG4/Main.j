library Main uses MainDefine

    globals
        private boolean initialize = false
    endglobals

    // @게임 초기화 함수
    function Main takes nothing returns nothing
        debug call WriteLog("TRPG4", "Main", "Main", "Calling")
        call InitCommandManager.evaluate()
        call InitUIManager.evaluate()
        call InitPlayerController.evaluate()

        // 테스트용
        call InitTestGameState.evaluate()
        //

        set initialize = true
    endfunction
    
    // @Timer로 돌아가는 Upate (멀티)
    function OnTick takes nothing returns nothing
        //call BJDebugMsg(I2S(DzGetMouseFocus()))
        
        set ClickTime = ClickTime + DeltaTime
        if ClickTime >= ClickResetTime then
            set ClickTime = 0.0
            set ClickLimitedCount = 0
        endif
    endfunction

    // @Thrad로 돌아가는 Update (로컬)
    function OnLoop takes nothing returns nothing
        local PlayerController pController
        if initialize == false then
            return
        endif
        
        call PlayerController.OnLoop()

        //SetCameraPosition()
    endfunction

    function OnRightClick takes nothing returns nothing
        local string packet = ""
        
        if initialize == false then
            return
        endif
        
        if DzGetMouseFocus() > 0 then
            return
        endif

        if ClickLimitedCount < MaxClickLimited then
            set ClickLimitedCount = ClickLimitedCount + 1
            set packet = packet + Regex.SetX(JNGetTriggerPlayerMouseX())
            set packet = packet + Regex.SetY(JNGetTriggerPlayerMouseY())
            set packet = packet+ Regex.SetClickData(SyncRightClickData)
            call JNSendSyncData(SyncClickEvent, packet)
        endif
    endfunction

    function OnLeftClick takes nothing returns nothing
        local string packet = ""
        
        if initialize == false then
            return
        endif

        if DzGetMouseFocus() > 0 then
            return
        endif
        
        if ClickLimitedCount < MaxClickLimited then
            set ClickLimitedCount = ClickLimitedCount + 1
            set packet = packet + Regex.SetX(JNGetTriggerPlayerMouseX())
            set packet = packet + Regex.SetY(JNGetTriggerPlayerMouseY())
            set packet = packet+ Regex.SetClickData(SyncLeftClickData)
            call JNSendSyncData(SyncClickEvent, packet)
        endif
    endfunction

    function OnRemoveUnit takes Actor inActor returns nothing
        call ClearActorAbility.evaluate(inActor)
    endfunction
endlibrary