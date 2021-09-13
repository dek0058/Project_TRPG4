library TestGameState uses MainDefine

    private function Initialize takes nothing returns boolean
        local PlayerController pController
        local Actor actor
        local integer i = 0

        loop
            exitwhen i == PlayerMaxSlot
            set pController = PlayerController.Get(i)
            if pController.controller.IsPlayerPlaying() == true then
                set actor = Actor.create(0.0, 0.0, 0.0, 0.0, Megumin_ID, pController.controller.Value())
                call pController.SetCharacter(actor)
                set pController.RightClickInfo = ABILITY_MOVE
                set pController.LeftClickInfo = ABILITY_ATTACK
                call SetFixedCamera(true)
            endif
            set i = i + 1
        endloop

        set i = 0
        loop
            exitwhen i == 4
            call Actor.create(0.0, 0.0, 0.0, 0.0, DebugMachine_ID, Player(1))
        
            set i = i + 1
        endloop

        return false
    endfunction

    function InitTestGameState takes nothing returns nothing
        local ShotEvent shotEvent

        set shotEvent = ShotEvent.create(Filter(function Initialize))
        call ShotEventList.Push(shotEvent)

        set shotEvent = NULL
    endfunction
endlibrary
