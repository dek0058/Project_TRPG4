library UnitGroup uses Alloc

    globals
        private integer TmpUnitGroup

        private integer count
    endglobals

    private function CalcCount takes nothing returns boolean
        if not IsUnitType(GetFilterUnit(), UNIT_TYPE_DEAD) then
            set count = count + 1
        endif
        return false
    endfunction

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

        method Add takes unit inUnit returns nothing
            if GetHandleId(inUnit) == 0 or IsUnitInGroup(inUnit, unitGroup) then
                return
            endif
            call GroupAddUnit(unitGroup, inUnit)
        endmethod

        method Remove takes unit inUnit returns nothing
            if GetHandleId(inUnit) == 0 or not IsUnitInGroup(inUnit, unitGroup) then
                return
            endif
            call GroupRemoveUnit(unitGroup, inUnit)
        endmethod

        method Execute takes code inCallback returns nothing
            set TmpUnitGroup = this
            call ForGroup(unitGroup, inCallback)
            set TmpUnitGroup = 0
        endmethod

        method Count takes nothing returns integer
            set count = 0
            call ForGroup(unitGroup, function CalcCount)
            return count
        endmethod

        method GetGroup takes nothing returns thistype
            return TmpUnitGroup
        endmethod
    endstruct
endlibrary