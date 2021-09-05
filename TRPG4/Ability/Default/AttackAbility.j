library AttackAbility initializer Start uses AbilitySystem, FVector

    globals
        private constant real Range = 128.00
    endglobals

    private function OnEvent takes nothing returns nothing
        local FVector pos = GetAbilityPosition()
        local Actor actor = GetActor(R2I(pos.z))
        local Actor target = GetActorByPosition(pos.x, pos.y, Range, null)
        local integer orderId = Order.attackonce
        if target != NULL and target.IsValid() == true then
            if GetUnitCurrentOrder(actor.Value()) == Order.attackonce then
                set orderId = Order.attack
            endif
            call actor.OrderTarget(orderId, target.Value())
        else
            call actor.OrderPoint(Order.smart, pos.x, pos.y)
        endif
    endfunction

    private function Start takes nothing returns nothing
        local integer id = ABILITY_ATTACK
        local integer abilityType = ABILITY_TYPE_DEFAULT
        local real cooltime = 0.0
        local string name = "공격"
        local string icon = ABILITY_ICON_NONE
        local AbilityInfo abilityInfo = AbilityInfo.create(id, abilityType, 0, cooltime, name, icon)
        call abilityInfo.RegisterEvent(Filter(function OnEvent))
        call AddAbilityInfo(abilityInfo)
    endfunction
    
endlibrary