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

    private function OnSelectedUnit takes nothing returns boolean
        local unit u = GetFilterUnit()
        set u = null
        return true
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
            if GetHandleId(inUnit) == NULL or IsUnitInGroup(inUnit, unitGroup) then
                return
            endif
            call GroupAddUnit(unitGroup, inUnit)
        endmethod

        method Remove takes unit inUnit returns nothing
            if GetHandleId(inUnit) == NULL or not IsUnitInGroup(inUnit, unitGroup) then
                return
            endif
            call GroupRemoveUnit(unitGroup, inUnit)
        endmethod

        method Execute takes code inCallback returns nothing
            set TmpUnitGroup = this
            call ForGroup(unitGroup, inCallback)
            set TmpUnitGroup = NULL
        endmethod

        method Count takes nothing returns integer
            set count = 0
            call ForGroup(unitGroup, function CalcCount)
            return count
        endmethod

        method Pop takes nothing returns unit
            local unit u = FirstOfGroup(unitGroup)
            call GroupRemoveUnit(unitGroup, u)
            return u
        endmethod

        method UpdateSelectedUnit takes player inPlayer returns nothing
            call GroupEnumUnitsSelected(unitGroup, inPlayer, Filter(function OnSelectedUnit))
        endmethod

        method GetGroup takes nothing returns thistype
            return TmpUnitGroup
        endmethod
    endstruct
endlibrary