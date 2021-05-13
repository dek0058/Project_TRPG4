library Controller initializer Start uses UnitGroup, ErrorMessage
    
    globals
        private Controller array AAA
    endglobals
    
    struct Controller extends array
        implement GlobalAlloc

        private player gamePlayer
        private UnitGroup unitGroup

        private string id
        //private string nickname

        static method create takes integer inIndex returns thistype
            local thistype this = allocate()

            set gamePlayer = Player(inIndex)
            set unitGroup = UnitGroup.create()

            return this
        endmethod

        method Value takes nothing returns player
            return gamePlayer
        endmethod

        static method Get takes player inPlayer returns thistype
            local integer id = GetPlayerId(inPlayer)
            if id >= 0 and id <= bj_MAX_PLAYER_SLOTS then
                return Controller[id]
            endif
            debug call ThrowError(true, "Controller", "Get", "Controller", Controller[id], "Player Id(" + I2S(id) + ")가 잘못되었습니다.")
            return -1
        endmethod

        method RegisterUnit takes unit inUnit returns nothing
            call unitGroup.Add(inUnit)
        endmethod

        method ExecuteUnitGroup takes code inCallback returns nothing
            call unitGroup.Execute(inCallback)
        endmethod
        
    endstruct


    private function Start takes nothing returns nothing
        local integer i = 0

        loop
            exitwhen i > bj_MAX_PLAYER_SLOTS
            //set Controller[i] = Controller.create(i)
            set i = i + 1
        endloop
    endfunction
endlibrary