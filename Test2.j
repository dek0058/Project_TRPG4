library TimerTest initializer Start uses Timers

    globals
        integer TimerCount = 0
        constant integer TimerCountMax = 10
    endglobals


    private function Update takes nothing returns nothing
        local Timer t = Timer.get_expired()

        call BJDebugMsg( I2S(TimerCount) + "회 Callback!")
        if TimerCount < TimerCountMax then
            call t.restart(function Update)
            return
        endif
        call BJDebugMsg( "타이머 종료!" )
    endfunction

    private function Action takes nothing returns nothing
        call Timer.start(0, 0.5, function Update)
    endfunction


    private function Start takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerAddAction(trig, function Action)
        call TriggerRegisterTimerEvent(trig, 0.1, false)
        set trig = null
    endfunction
endlibrary