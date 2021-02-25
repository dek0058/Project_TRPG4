library UnitGroup

    struct UnitGroup extends array
        implement Alloc

        private group unitGroup

        static method create takes nothing returns thistype
            local thistype this = allocate()

            set unitGroup = CreateGroup()

            return this
        endmethod
        
        method destroy takes nothing returns nothing
            
            call DestroyGroup(unitGroup)
            set unitGroup = null
            call deallocate()
        endmethod



    endstruct
endlibrary