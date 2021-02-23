library MainThread initializer Start uses ShotEvent

    globals
        constant real DeltaTime = 0.005

        private real GameTime = 0.00
        private integer State = 0
    endglobals

    

    // [ToolTip] 게임 상태를 설정하거나 가져옵니다.
    globals
        constant integer GAMESTATE_INITIALIZE   = 0
        constant integer GAMESTATE_PLAYING      = 1
        constant integer GAMESTATE_PAUSE        = 2
    endglobals

    function SetGameState takes integer inState returns nothing
        set State = inState
    endfunction

    function GetGameState takes nothing returns integer
        return State
    endfunction
    //


    // [ToolTip] MainThread에서 실행되는 이벤트를 등록합니다.
    globals
        private TArrayShotEvent ShotEventList
    endglobals

    function AddShotEvent takes ShotEvent inEvent returns nothing
        call ShotEventList.Push(inEvent)
    endfunction
    //


    // [ToolTip] 게임이 시작하고 나서 시간을 반환합니다.
    function GetGameTime takes nothing returns real
        return GameTime
    endfunction
    

    // [ToolTip] 게임 초기화
    private function OnInitialize takes nothing returns nothing
        set ShotEventList = TArrayShotEvent.create()
    
        
        // 임시 우선 초기화에 사용되는 리소스가 없으므로...
        call SetGameState(GAMESTATE_PLAYING)
    endfunction



    private function Update takes nothing returns nothing
        local ShotEvent tmpShotEvent
        
        if State == GAMESTATE_INITIALIZE then
            // 기본 초기화
            call OnInitialize()
        elseif State == GAMESTATE_PLAYING then
            set GameTime = GameTime + DeltaTime
            
            

        elseif State == GAMESTATE_PAUSE then

        endif
        
        loop
            exitwhen ShotEventList.Size() == 0
            set tmpShotEvent = ShotEventList.Back()
            call tmpShotEvent.Execute()
            call tmpShotEvent.destroy()
            set tmpShotEvent = 0
            call ShotEventList.Pop()
        endloop
    endfunction

    private function Start takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerAddAction(trig, function Update)
        call TriggerRegisterTimerEvent(trig, DeltaTime, true)
        set trig = null
    endfunction
endlibrary