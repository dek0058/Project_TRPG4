library Controller initializer Start uses UnitGroup, ErrorMessage
    
    globals
        private Controller array controller
    endglobals
    
    struct Controller extends array
        implement GlobalAlloc

        private player gamePlayer
        private UnitGroup unitGroup
        private UnitGroup selectGroup

        private string id
        //private string nickname


        static method operator [] takes player inPlayer returns thistype
            local integer id = GetPlayerId(inPlayer)
            if id >= 0 and id <= bj_MAX_PLAYER_SLOTS then
                return controller[id]
            endif
            debug call ThrowError(true, "Controller", "Get", "Controller", controller[id], "Player Id(" + I2S(id) + ")가 잘못되었습니다.")
            return -1
        endmethod

        static method create takes integer inIndex returns thistype
            local thistype this = allocate()

            set gamePlayer = Player(inIndex)
            set unitGroup = UnitGroup.create()
            set selectGroup = UnitGroup.create()

            

            return this
        endmethod

        method Value takes nothing returns player
            return gamePlayer
        endmethod

        method GetUnitGroup takes nothing returns UnitGroup
            return unitGroup
        endmethod

        method RegisterUnit takes unit inUnit returns nothing
            call unitGroup.Add(inUnit)
        endmethod

        method UnregisterUnit takes unit inUnit returns nothing
            call unitGroup.Remove(inUnit)
        endmethod

        method ExecuteUnitGroup takes code inCallback returns nothing
            call unitGroup.Execute(inCallback)
        endmethod
        
    endstruct
    
    private function OnSelected takes nothing returns nothing
        local player localPlayer = GetTriggerPlayer()
    endfunction

    private function Start takes nothing returns nothing
        local trigger trig = CreateTrigger()
        local integer i = 0

        call TriggerAddAction(trig, function OnSelected)

        loop
            exitwhen i > bj_MAX_PLAYER_SLOTS
            set controller[i] = Controller.create(i)
            call TriggerRegisterPlayerUnitEvent(trig, Player(i), EVENT_PLAYER_UNIT_SELECTED, null)
            set i = i + 1
        endloop

        set trig = null
    endfunction
endlibrary