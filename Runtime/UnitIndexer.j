library UnitIndexer initializer Start uses Table

    globals
        private HashTable UnitDataHashTable

        private constant integer INDEX_ID       = 0
        private constant integer INDEX_HANDLE   = 1
        private constant integer INDEX_TRIGGER  = 2
        private constant integer INDEX_UNIT     = 3
    endglobals
    

    /* [Tooltip] 유닛 등록 */
    globals
        private HashTable RegisterDataHashTable

        private constant integer REGISTER_TIMER             = 0
        private constant integer REGISTER_TIMER_INDEX       = 1
        private constant integer REGISTER_TRIGGER           = 2
        private constant integer REGISTER_TRIGGER_ACTION    = 3
        private constant integer REGISTER_TRIGGER_INDEX     = 4
        private constant integer REGISTER_DELAY             = 5
    endglobals

    private function UnregisterReferance takes integer inId returns nothing

    endfunction

    private function bbb takes nothing returns nothing

    endfunction

    private function aaa takes nothing returns nothing
        
    endfunction

    private function RegisterReferance takes unit inUnit, integer inId returns nothing
        local integer tempIndex
        local timer tempTimer
        local real tempReal
        local trigger tempTrig

        set RegisterDataHashTable[inId].timer[REGISTER_TIMER] = CreateTimer()

        set RegisterDataHashTable[inId].trigger[REGISTER_TRIGGER] = CreateTrigger()

        set tempTrig = RegisterDataHashTable[inId].trigger[REGISTER_TRIGGER]
        set RegisterDataHashTable[inid].triggeraction[REGISTER_TRIGGER_ACTION] = TriggerAddAction(tempTrig, function aaa)

        set tempIndex = GetHandleId(RegisterDataHashTable[inId].timer[REGISTER_TIMER])
        set RegisterDataHashTable[tempIndex].integer[REGISTER_TIMER_INDEX] = tempIndex

        set tempIndex = GetHandleId(RegisterDataHashTable[inId].trigger[REGISTER_TRIGGER_ACTION])
        set RegisterDataHashTable[tempIndex].integer[REGISTER_TRIGGER_INDEX] = tempIndex

        call TriggerRegisterUnitEvent(tempTrig, inUnit, EVENT_UNIT_DEATH)
        if IsUnitType(inUnit, UNIT_TYPE_DEAD) then
            set RegisterDataHashTable[inId].real[REGISTER_DELAY] = 1.00
            set tempTimer = RegisterDataHashTable[inId].timer[REGISTER_TIMER]
            set tempReal = RegisterDataHashTable[inId].real[REGISTER_DELAY]
            call TimerStart(tempTimer, tempReal, false, function bbb)
        endif
    endfunction

    function UnitIndex takes unit inUnit returns integer
        local integer handleId = GetHandleId(inUnit)
        local integer id = 0

        if UnitDataHashTable.has(handleId) then
            set id = UnitDataHashTable[handleId].integer[UNIT_ID]
        else
            if GetUnitTypeId(handleId) == 0 then
                return 0
            endif
            
            // TODO
            
            //

            set UnitDataHashTable[handleId].integer[INDEX_ID] = id
            set UnitDataHashTable[handleId].integer[INDEX_HANDLE] = handleId
            set UnitDataHashTable[handleId].trigger[INDEX_TRIGGER] = CreateTrigger()
            set UnitDataHashTable[handleId].unit[INDEX_UNIT] = inUnit
            call RegisterReferance(inUnit, id)
        endif

        return id
    endfunction


    /* [Tooltip] 초기화 */
    private function OnEnumPreAllocate takes nothing returns boolean
        call UnitIndex(GetFilterUnit())
        return false
    endfunction

    private function OnPreAllocate takes nothing returns nothing
        local group initGroup = CreateGroup()
        call GroupEnumUnitsInRect(initGroup, GetWorldBounds(), Filter(function OnEnumPreAllocate))
        call DestroyGroup(initGroup)
        set initGroup = null
    endfunction

    private function OnAllocateCondition takes nothing returns boolean
        return not UnitDataHashTable.has(GetHandleId(GetTriggerUnit()))
    endfunction

    private function OnAllocateAction takes nothing returns nothing
        call UnitIndex(GetTriggerUnit())
    endfunction

    private function OnPostAllocate takes nothing returns nothing
        local trigger trig = CreateTrigger()
        local triggeraction trigAction = TriggerAddAction(trig, function OnAllocateAction)
        local triggercondition trigCondition = TriggerAddCondition(trig, Condition(function OnAllocateCondition))
        call TriggerRegisterEnterRectSimple(trig, GetWorldBounds())
        set trig = null
        set trigAction = null
        set trigCondition = null
    endfunction

    private function Start takes nothing returns nothing
        set UnitDataHashTable = HashTable.create()
        set RegisterDataHashTable = HashTable.create()
        
        call OnPreAllocate()
        call OnPostAllocate()
    endfunction
endlibrary