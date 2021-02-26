library UnitGroup

    struct UnitGroup extends array
        implement Alloc

        private group unitGroup
        private integer count

        static method create takes nothing returns thistype
            local thistype this = allocate()

            set unitGroup = CreateGroup()
            set count = 0

            return this
        endmethod
        
        method destroy takes nothing returns nothing
            
            call DestroyGroup(unitGroup)
            set unitGroup = null
            call deallocate()
        endmethod


        method Add takes Actor inActor returns nothing

        endmethod

        method Remove takes Actor inActor returns nothing

        endmethod

        method Count takes nothing returns integer
            return count
        endmethod
        
    endstruct
endlibrary