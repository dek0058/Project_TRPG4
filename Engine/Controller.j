library Controller initializer Start uses UnitGroup, ErrorMessage
    
    globals
        private Controller array controller
    endglobals
    
    struct Controller extends array
        implement GlobalAlloc

        private player gamePlayer
        private UnitGroup unitGroup

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

        endmethod

        method ExecuteUnitGroup takes code inCallback returns nothing
            call unitGroup.Execute(inCallback)
        endmethod
        
    endstruct


    private function Start takes nothing returns nothing
        local integer i = 0

        loop
            exitwhen i > bj_MAX_PLAYER_SLOTS
            set controller[i] = Controller.create(i)
            set i = i + 1
        endloop
    endfunction
endlibrary