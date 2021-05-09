library MainThread initializer Start uses MainDefine, ShotEvent

    globals
        private real GameTime = 0.00
        private integer State = 0
    endglobals

    

    // [ToolTip] ���� ���¸� �����ϰų� �����ɴϴ�.
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


    // [ToolTip] MainThread���� ����Ǵ� �̺�Ʈ�� ����մϴ�.
    globals
        private TArrayShotEvent ShotEventList
    endglobals

    function AddShotEvent takes ShotEvent inEvent returns nothing
        call ShotEventList.Push(inEvent)
    endfunction
    //


    // [ToolTip] ������ �����ϰ� ���� �ð��� ��ȯ�մϴ�.
    function GetGameTime takes nothing returns real
        return GameTime
    endfunction
    

    // [ToolTip] ���� �ʱ�ȭ
    private function OnInitialize takes nothing returns nothing
        set ShotEventList = TArrayShotEvent.create()
    
        
        // �ӽ� �켱 �ʱ�ȭ�� ���Ǵ� ���ҽ��� �����Ƿ�...
        call SetGameState(GAMESTATE_PLAYING)
    endfunction



    private function Update takes nothing returns nothing
        local ShotEvent tmpShotEvent
        
        if State == GAMESTATE_INITIALIZE then
            // �⺻ �ʱ�ȭ
            call OnInitialize()
        elseif State == GAMESTATE_PLAYING then
            set GameTime = GameTime + DeltaTime

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