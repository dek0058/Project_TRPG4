library UnitStateCmd uses PlayerController

    private function LifeCmd takes nothing returns boolean
        local PlayerController pController = PlayerController[GetChatPlayer()]
        local unit target
        local real value

        if GetArgsCount() == 3 then
            if pController.ExistCharacter() == false then
                return false
            endif
            
            set target = pController.GetCharacter().Value()
            set value = FMath.clamp(0.0, 100.0, S2R(GetArgs(2))) * 0.01
            set value = JNGetUnitMaxHP(target) * value
            call JNSetUnitHP(target, value)
        endif
        return false
    endfunction

    private function ManaCmd takes nothing returns boolean
        local PlayerController pController = PlayerController[GetChatPlayer()]
        local unit target
        local real value

        if GetArgsCount() == 3 then
            if pController.ExistCharacter() == false then
                return false
            endif
            
            set target = pController.GetCharacter().Value()
            set value = FMath.clamp(0.0, 100.0, S2R(GetArgs(2))) * 0.01
            set value = JNGetUnitMaxMana(target) * value
            call JNSetUnitMana(target, value)
        endif
        return false
    endfunction


    function InitUnitStateCmd takes nothing returns nothing
        call AddCommand.evaluate("life", Filter(function LifeCmd))
        call AddCommand.evaluate("mana", Filter(function ManaCmd))
        
    endfunction

endlibrary
