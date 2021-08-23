library AbilitySystem initializer Start uses Table

    globals
        
        constant integer ABILITY_ACTIVE = 1
        constant integer ABILITY_PASSIVE = 2

    endglobals

    //! runtextmacro DEFINE_STRUCT_TARRAY("AbilityInfo", "AbilityInfo")

    struct AbilityInfo

        readonly integer id
        readonly integer type

        static method create takes integer inId, integer inType returns thistype
            local thistype this = allocate()

            set id = inId
            set type = inType

            return this
        endmethod

    endstruct

    private function Start takes nothing returns nothing

    endfunction
endlibrary