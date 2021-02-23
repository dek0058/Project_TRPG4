library Controller initializer Start uses UnitGroup
    
    struct Controller extends array
        implement GlobalAlloc

        private player gamePlayer

        private UnitGroup unitGroup

        //private string id
        //private string nickname

        static method create takes integer inIndex returns thistype
            local this = allocate()
            set gamePlayer = Player(inIndex)

            set unitGroup = UnitGroup.create()

            return this
        endmethod

        method Value takes nothing returns player
            return gamePlayer
        endmethod

    endstruct


    private function Start takes nothing returns nothing
        integer i = 0

        loop
            exitwhen i = bj_MAX_PLAYERS
            set Controller[i] = Controller.create(i)
        endloop
    endfunction
endlibrary