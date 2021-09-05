library MoveAbility initializer Start uses AbilitySystem, FVector

    private function OnEvent takes nothing returns nothing
        local FVector pos = GetAbilityPosition()
        local Actor actor = GetActor(R2I(pos.z))
        call actor.OrderPoint(Order.smart, pos.x, pos.y)
    endfunction

    private function Start takes nothing returns nothing
        local integer id = ABILITY_MOVE
        local integer abilityType = ABILITY_TYPE_DEFAULT
        local real cooltime = 0.0
        local string name = "이동"
        local string icon = ABILITY_ICON_NONE
        local AbilityInfo abilityInfo = AbilityInfo.create(id, abilityType, 0, cooltime, name, icon)
        call abilityInfo.RegisterEvent(Filter(function OnEvent))
        call AddAbilityInfo(abilityInfo)
    endfunction
    
endlibrary