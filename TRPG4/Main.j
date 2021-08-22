library Main initializer Start uses MainDefine


    // @게임 초기화 함수
    function Main takes nothing returns nothing
        debug call WriteLog("TRPG4", "Main", "Main", "Calling")
        call InitCommandManager.evaluate()
        call InitUIManager.evaluate()
    endfunction
    
    function OnLoop takes nothing returns nothing

        if FixedCamera == true then
            call SetCameraPosition(MainPlayerActors[GetLocalController()].X, MainPlayerActors[GetLocalController()].Y)
        endif
        //SetCameraPosition()
    endfunction

    function OnRightClick takes nothing returns nothing
        local real x = JNGetTriggerPlayerMouseX()
        local real y = JNGetTriggerPlayerMouseY()
        local string packet = ""

        set packet = packet + Regex.SetX(packet, x)
        set packet = packet + Regex.SetY(packet, y)
        set packet = packet+ Regex.SetClickData(packet, SyncRightClickData)

        call JNSendSyncData(SyncClickEvent, packet)
    endfunction

    function OnLeftClick takes nothing returns nothing
        local real x = JNGetTriggerPlayerMouseX()
        local real y = JNGetTriggerPlayerMouseY()
        local string packet = ""

        set packet = packet + Regex.SetX(packet, x)
        set packet = packet + Regex.SetY(packet, y)
        set packet = packet + Regex.SetClickData(packet, SyncLeftClickData)

        call JNSendSyncData(SyncClickEvent, packet)
    endfunction

    private function Start takes nothing returns nothing
    endfunction
endlibrary