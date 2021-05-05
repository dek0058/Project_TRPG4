library ActorThread initializer Start uses MainThread, Actor

    globals
        private integer MaxLoop = 10

        private integer Index = 0

    endglobals

    private function Update takes nothing returns nothing
        local integer i = 0
        
        if not Actors[Index].IsValid() then
            
        endif
    endmethod

    private function Start takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerAddAction(trig, function Update)
        call TriggerRegisterTimerEvent(trig, DeltaTime, true)
        set trig = null
    endfunction
endlibrary