library TestGameState initializer Start uses MainDefine
    
    globals
        Actor array MainPlayerActors

    endglobals

    private function Initialize takes nothing returns boolean
        local Controller controller
        local Actor actor
        local integer i = 0

        loop
            exitwhen i == DefaultPlayerIndex
            set controller = Controller.Get(i)
            if controller.IsPlayerPlaying() == true then
                set actor = Actor.create(0.0, 0.0, 0.0, 0.0, DebugMachine_ID, controller.Value())
                set MainPlayerActors[controller] = actor
                call SetFixedCamera(true)
            endif
            set i = i + 1
        endloop

        return false
    endfunction

    private function Start takes nothing returns nothing
        local ShotEvent shotEvent

        set shotEvent = ShotEvent.create(Filter(function Initialize))
        call ShotEventList.Push(shotEvent)
        
        set shotEvent = 0
    endfunction
endlibrary
