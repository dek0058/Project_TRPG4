library MainThread initializer Start

    globals
        constant real DeltaTime = 0.005

        private real GameTime = 0.00
        private integer State = 0
    endglobals

    struct GameState
        static constant integer INITIALIZE = 0
        static constant integer PLAYING = 1
        static constant integer PAUSE = 2
    endstruct

    // [ToolTip] 게임 상태를 설정하거나 가져옵니다.
    function SetGameState takes integer inState returns nothing
        set State = inState
    endfunction

    function GetGameState takes nothing returns integer
        return State
    endfunction
    //

    // [ToolTip] 게임이 시작하고 나서 시간을 반환합니다.
    function GetGameTime takes nothing returns real
        return GameTime
    endfunction


    private function Update takes nothing returns nothing
        if State == GameState.INITIALIZE then

        else if State == GameState.PLAYING then
            set GameTime = GameTime + DeltaTime
            

        else if State == GameState.PAUSE then

        endif
    endfunction

    private function Start takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerAddAction(trig, function Update)
        call TriggerRegisterTimerEvent(trig, DeltaTime, true)
        set trig = null
    endfunction
endlibrary