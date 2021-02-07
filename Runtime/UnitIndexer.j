library UnitIndexer initializer Start uses Table

    globals
        private HashTable handleTable
        private HashTable unitIndexerTable
    endglobals

    globals
        private constant integer HANDLE_UNIT_ID = 0
        private constant integer HANDLE_TIMER_ID = 1
        private constant integer HANDLE_TRIGGER_ID = 2

        private constant integer UNIT_INDEXER_UNIT = 0
        private constant integer UNIT_INDEXER_INDEX = 1
        private constant integer UNIT_INDEXER_TRIGGER = 2
        private constant integer UNIT_INDEXER_TIMER = 3
        private constant integer UNIT_INDEXER_UNIT_EVENT_TRIGGER = 4
        private constant integer UNIT_INDEXER_TRIGGER_ACTION = 5
        private constant integer UNIT_INDEXER_TIMER_DELAY = 6
    endglobals

    
    function GetTriggerIndex takes nothing returns integer
        return
    endfunction

    function GetUnitRemoveTrigger takes unit inUnit returns trigger
        return
    endfunction

    private function Deindex takes integer inId returns nothing
        /*
        local integer pi = V
        set V = inId
        */
        call TriggerExecute(unitIndexerTable[inId].trigger[UNIT_INDEXER_TRIGGER])
        /*
        set V = pi
        */
        call DestroyTrigger(unitIndexerTable[inId].trigger[UNIT_INDEXER_TRIGGER])
        set unitIndexerTable[inId].trigger[UNIT_INDEXER_TRIGGER] = null

        set handleTable[GetHandleId(unitIndexerTable[inId].unit[UNIT_INDEXER_UNIT])].integer[HANDLE_UNIT_ID] = 0
        call handleTable.remove(GetHandleId(unitIndexerTable[inId].unit[UNIT_INDEXER_UNIT]))
        set unitIndexerTable[inId].unit[UNIT_INDEXER_UNIT] = null

        /*
        set S[Z] = inId
        set Z = Z + 1
        set C = C - 1
        */
        call unitIndexerTable.remove(inId)
    endfunction

    /* [Tooltip] 유닛 등록 및 해체 */
    private function UnregisterReferance takes integer inId returns nothing
        call handleTable.remove(GetHandleId(unitIndexerTable[inId].timer[UNIT_INDEXER_TIMER]))
        call handleTable.remove(GetHandleId(unitIndexerTable[inId].trigger[UNIT_INDEXER_UNIT_EVENT_TRIGGER]))
        
        call DestroyTimer(unitIndexerTable[inId].timer[UNIT_INDEXER_TIMER])
        set unitIndexerTable[inId].timer[UNIT_INDEXER_TIMER] = null
        call TriggerRemoveAction(unitIndexerTable[inId].trigger[UNIT_INDEXER_UNIT_EVENT_TRIGGER], unitIndexerTable[inId].triggeraction[UNIT_INDEXER_TRIGGER_ACTION])
        set unitIndexerTable[inId].triggeraction[UNIT_INDEXER_TRIGGER_ACTION] = null
        call DestroyTrigger(unitIndexerTable[inId].trigger[UNIT_INDEXER_UNIT_EVENT_TRIGGER])
        set unitIndexerTable[inId].trigger[UNIT_INDEXER_UNIT_EVENT_TRIGGER] = null
    endfunction

    private function bbb takes nothing returns nothing
        local timer expiredTimer = GetExpiredTimer()
        local integer id = handleTable[GetHandleId(expiredTimer)].integer[HANDLE_TIMER_ID]
        if GetUnitTypeId(unitIndexerTable[id].unit[UNIT_INDEXER_UNIT]) != 0 then
            if IsUnitType(unitIndexerTable[id].unit[UNIT_INDEXER_UNIT], UNIT_TYPE_DEAD) then
                set unitIndexerTable[id].real[UNIT_INDEXER_TIMER_DELAY] = unitIndexerTable[id].real[UNIT_INDEXER_TIMER_DELAY] + 1.00
                call TimerStart(expiredTimer, unitIndexerTable[id].real[UNIT_INDEXER_TIMER_DELAY], false, function bbb)
            endif
        else
            call UnregisterReferance(id)
            call Deindex(id)
        endif
        set expiredTimer = null
    endfunction

    private function aaa takes nothing returns nothing
        local integer id = handleTable[GetHandleId(GetTriggeringTrigger())].integer[HANDLE_TRIGGER_ID]
        set unitIndexerTable[id].real[UNIT_INDEXER_TIMER_DELAY] = 1.00
        call TimerStart(unitIndexerTable[id].timer[UNIT_INDEXER_TIMER], unitIndexerTable[id].real[UNIT_INDEXER_TIMER_DELAY], false, function bbb)
    endfunction

    private function RegisterReferance takes unit inUnit, integer inId returns nothing
        set unitIndexerTable[id].timer[UNIT_INDEXER_TIMER] = CreateTimer()
        set unitIndexerTable[id].trigger[UNIT_INDEXER_UNIT_EVENT_TRIGGER] = CreateTrigger()
        set unitIndexerTable[id].triggeraction[UNIT_INDEXER_TRIGGER_ACTION] = TriggerAddAction(unitIndexerTable[id].trigger[UNIT_INDEXER_UNIT_EVENT_TRIGGER], function aaa)
        call TriggerRegisterUnitEvent(unitIndexerTable[id].trigger[UNIT_INDEXER_UNIT_EVENT_TRIGGER], inUnit, EVENT_UNIT_DEATH)
        
        set handleTable[GetHandleId(unitIndexerTable[id].timer[UNIT_INDEXER_TIMER])].integer[HANDLE_TIMER_ID] = id
        set handleTable[GetHandleId(unitIndexerTable[id].trigger[UNIT_INDEXER_UNIT_EVENT_TRIGGER])].integer[HANDLE_TRIGGER_ID] = id

        if IsUnitType(inUnit, UNIT_TYPE_DEAD) then
            set unitIndexerTable[id].real[UNIT_INDEXER_TIMER_DELAY] = 1.00
            call TimerStart(unitIndexerTable[id].timer[UNIT_INDEXER_TIMER], unitIndexerTable[id].real[UNIT_INDEXER_TIMER_DELAY], false, function bbb)
        endif
    endfunction
    
    function GetUnitIndex takes unit inUnit returns integer
        return handleTable[GetHandleId(inUnit)].integer[HANDLE_UNIT_ID]
    endfunction

    function IsUnitIndexed takes unit inUnit returns boolean
        return handleTable.has(GetHandleId(inUnit))
    endfunction

    function UnitIndex takes unit inUnit returns integer
        local integer handleId = GetHandleId(GetTriggerUnit())
        local integer id = 0

        if not handleTable.has(handleId) then
            if GetUnitTypeId(inUnit) then
                return 0
            endif

            /*
            if Z == 0 then
                set M = M + 1
                set id = M
            else
                set Z = Z - 1
                set id = S[Z]
            endif
            set C = C + 1
            */

            set unitIndexerTable[id].unit[UNIT_INDEXER_UNIT] = inUnit
            set unitIndexerTable[id].integer[UNIT_INDEXER_INDEX] = handleId
            set unitIndexerTable[id].trigger[UNIT_INDEXER_TRIGGER] = CreateTrigger()
            set handleTable[handleId].integer[HANDLE_UNIT_ID] = id
            call RegisterReferance(inUnit, id)
        else
            set id = handleTable[handleId].integer[HANDLE_UNIT_ID]
        endif
        
        return id
    endfunction

    /* [Tooltip] 초기화 */
    private function OnAllocateAction takes nothing returns nothing
        call UnitIndex(GetTriggerUnit())
    endfunction

    private function OnAllocateCondition takes nothing returns boolean
        return not handleTable.has(GetHandleId(GetTriggerUnit()))
    endfunction

    // [Tootip] 이후 생성되는 unit 등록
    private function OnPostAllocate takes nothing returns nothing
        local trigger enterRectSimpTrig = CreateTrigger()
        call TriggerAddCondition(enterRectSimpTrig, Condition(function OnAllocateCondition))
        call TriggerAddAction(enterRectSimpTrig, function OnAllocateAction)
        call TriggerRegisterEnterRectSimple(enterRectSimpTrig, GetWorldBounds())
        set enterRectSimpTrig = null
    endfunction

    private function OnEnumPreAllocate takes nothing returns boolean
        call UnitIndex(GetFilterUnit())
        return false
    endfunction

    // [Tooltip] 이미 생선된 unit 등록
    private function OnPreAllocate takes nothing returns nothing
        local group preAllocateGroup = CreateGroup()
        set GroupEnumUnitsInRect(preAllocateGroup, GetWorldBounds(), Filter(function OnEnumPreAllocate))
        call DestroyGroup(preAllocateGroup)
        set preAllocateGroup = null
    endfunction

    private function Start takes nothing returns nothing
        set handleTable = handleTable.create()
        set unitIndexerTable = unitIndexerTable.create()
        call OnPreAllocate()
        call OnPostAllocate()
    endfunction
endlibrary