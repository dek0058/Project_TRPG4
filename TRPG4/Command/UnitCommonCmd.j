library UnitCommonCmd uses Controller

    private function KillCmd takes nothing returns boolean
        local Controller controller = Controller[GetChatPlayer()]
        local unit selectedUnit

        //loop

        //endloop

        return false
    endfunction





    function InitUnitCommonCmd takes nothing returns nothing
        call AddCommand.evaluate("kill", null)
    endfunction
endlibrary