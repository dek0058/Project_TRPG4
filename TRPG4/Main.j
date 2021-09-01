library Main initializer Start uses MainDefine

    globals
        private boolean initialize = false
    endglobals

    // @게임 초기화 함수
    function Main takes nothing returns nothing
        debug call WriteLog("TRPG4", "Main", "Main", "Calling")
        call InitCommandManager.evaluate()
        call InitUIManager.evaluate()
        call InitPlayerController.evaluate()
        set initialize = true
    endfunction
    
    function Tick takes nothing returns nothing
        
    endfunction

    function OnLoop takes nothing returns nothing
        if initialize == false then
            return
        endif

        if FixedCamera == true then
            call SetCameraPosition(MainPlayerActors[GetLocalController()].X, MainPlayerActors[GetLocalController()].Y)
        endif
        //SetCameraPosition()
    endfunction

    function OnRightClick takes nothing returns nothing
        if initialize == false then
            return
        endif
        
        call PlayerController.Get(LocalPlayerIndex).RightClickInfo.Evaluate()
    endfunction

    function OnLeftClick takes nothing returns nothing
        if initialize == false then
            return
        endif

        call PlayerController.Get(LocalPlayerIndex).LeftClickInfo.Evaluate()
    endfunction

    private function Start takes nothing returns nothing
    endfunction
endlibrary