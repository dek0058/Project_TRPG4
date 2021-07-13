library UnitCommandCmd

    private function KillCmd takes nothing returns boolean
        

        return false
    endfunction





    function InitUnitCommandCmd takes nothing returns nothing
        call AddCommand.evaluate("kill", null)
    endfunction
endlibrary