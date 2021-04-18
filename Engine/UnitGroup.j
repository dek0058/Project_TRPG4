library UnitGroup uses Alloc

    globals
        private integer TmpUnitGroup
    endglobals

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

        method Add takes unit inUnit returns nothing
            if GetHandleId(inUnit) == 0 or IsUnitInGroup(inUnit, unitGroup) then
                return
            endif
            call GroupAddUnit(unitGroup, inUnit)
            set count = count + 1
        endmethod

        method Remove takes unit inUnit returns nothing
            if GetHandleId(inUnit) == 0 or not IsUnitInGroup(inUnit, unitGroup) then
                return
            endif
            call GroupRemoveUnit(unitGroup, inUnit)
            set count = count - 1
        endmethod

        method Execute takes code inCallback returns nothing
            set TmpUnitGroup = this
            call ForGroup(unitGroup, inCallback)
            set TmpUnitGroup = 0
        endmethod

        method CleanUp takes nothing returns nothing
            set TmpUnitGroup = this
            call ForGroup(unitGroup, function thistype.OnCleanUp)
            set TmpUnitGroup = 0
        endmethod

        method Count takes nothing returns integer
            return count
        endmethod

        method GetGroup takes nothing returns thistype
            return TmpUnitGroup
        endmethod

        private static method OnCleanUp takes nothing returns nothing
            local unit u = GetEnumUnit()
            local UnitGroup this = TmpUnitGroup
            if GetHandleId(u) == 0 then
                set this.count = this.count - 1
            endif
            set u = null
        endmethod
    endstruct
endlibrary