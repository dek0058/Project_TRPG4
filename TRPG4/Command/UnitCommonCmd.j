library UnitCommonCmd uses Controller

    private function KillCmd takes nothing returns boolean
        local Controller controller = Controller[GetChatPlayer()]
        local unit target

        call controller.UpdateSelectedUnitGroup()
        loop
            set target = controller.GetSelectedUnitGroup().Pop()
            exitwhen target == null
            call Actor[target].Kill()
        endloop
        return false
    endfunction

    private function RemoveCmd takes nothing returns boolean
        local Controller controller = Controller[GetChatPlayer()]
        local unit target

        call controller.UpdateSelectedUnitGroup()
        loop
            set target = controller.GetSelectedUnitGroup().Pop()
            exitwhen target == null
            call Actor[target].Remove()
        endloop
        return false
    endfunction

    function InitUnitCommonCmd takes nothing returns nothing
        call AddCommand.evaluate("kill", Filter(function KillCmd))
        call AddCommand.evaluate("remove", Filter(function RemoveCmd))
    endfunction
endlibrary