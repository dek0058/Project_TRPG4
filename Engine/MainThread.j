library MainThread initializer Start uses MainDefine, ShotEvent

    globals
        private real GameTime = 0.00
        private integer State = 0

        private boolean IsIntiailize = false
    endglobals

    

    // [ToolTip] 게임 상태를 설정하거나 가져옵니다.
    globals
        constant integer GAMESTATE_INITIALIZE   = 0
        constant integer GAMESTATE_PLAYING      = 1
        constant integer GAMESTATE_PAUSE        = 2
    endglobals

    function SetGameState takes integer inState returns nothing
        debug call WriteLog("Engine", "MainThread", "SetGameState", I2S(inState))
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
    
    private function MainThread takes nothing returns nothing
        local integer handler = JNGetFrameByName("ScoreScreenFrame", 0)

        if handler != 0 and JNFrameGetAlpha(handler) != 0 then
            call DzFrameSetUpdateCallbackByCode(null)
            return
        endif
        
        call OnLoop.evaluate()
        if GetLocalController().isRightClick == true then
            call OnRightClick.evaluate()
        endif
        if GetLocalController().isLeftClick == true then
            call OnLeftClick.evaluate()
        endif
    endfunction

    // [ToolTip] 게임 초기화
    private function OnInitialize takes nothing returns nothing
        debug call WriteLog("Engine", "MainThread", "OnInitialize", "Calling")
        call Main.evaluate()
        call SetGameState(GAMESTATE_PLAYING)
        call DzFrameSetUpdateCallbackByCode(function MainThread)
    endfunction

    private function Update takes nothing returns nothing
        local ShotEvent tmpShotEvent
        
        if State == GAMESTATE_INITIALIZE then
            call OnInitialize()
            call SetGameState(GAMESTATE_PLAYING)
        elseif State == GAMESTATE_PLAYING then
            set GameTime = GameTime + DeltaTime
            call Tick.evaluate()
        elseif State == GAMESTATE_PAUSE then

        endif
        
        if ShotEventList.Size() > 0 then
            set tmpShotEvent = ShotEventList.Back()
            call tmpShotEvent.Execute()
            call tmpShotEvent.destroy()
            set tmpShotEvent = 0
            call ShotEventList.Pop()
        endif
    endfunction

    private function Start takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerAddAction(trig, function Update)
        call TriggerRegisterTimerEvent(trig, DeltaTime, true)
        set trig = null
    endfunction
endlibrary