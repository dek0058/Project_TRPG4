library MainThread initializer Start

    globals
        constant real DeltaTime = 0.005

        private real GameTime = 0.00
        private integer State = 0
    endglobals

    // [Tooltip] 즉발 이벤트를 추가하거나 제거합니다.
    globals
        private TArraytrigger EventList
    endglobals

    function AddEvent takes trigger inTrig returns nothing
        call EventList.Push(inTrig)
    endfunction

    function RemoveEvent takes trigger inTrig returns nothing
        local integer targetId = GetHandleId(inTrig)
        local integer i = 0

        loop
            exitwhen i == EventList.Size()
            if GetHandleId(EventList[i]) == targetId then
                EventList.Erase(i, 1)
                return
            endif
            set i = i + 1
        endloop
    endfunction
    //

    // [ToolTip] 게임 상태를 설정하거나 가져옵니다.
    struct GameState
        static constant integer INITIALIZE = 0
        static constant integer PLAYING = 1
        static constant integer PAUSE = 2
    endstruct

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
            // 기본 초기화
            set EventList = TArraytrigger.create()

            // 임시 우선 초기화에 사용되는 리소스가 없으므로...
            call SetGameState(GameState.PLAYING)
            
        elseif State == GameState.PLAYING then
            set GameTime = GameTime + DeltaTime
            
            loop
                exitwhen EventList.Size() == 0
                call TriggerExecute(EventList.Back())
                call EventList.Pop()
            endloop

        elseif State == GameState.PAUSE then

        endif
    endfunction

    private function Start takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerAddAction(trig, function Update)
        call TriggerRegisterTimerEvent(trig, DeltaTime, true)
        set trig = null
    endfunction
endlibrary