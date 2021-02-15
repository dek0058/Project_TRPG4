library UnitIndexer initializer Start uses Table

    globals
        private Table HandleTable
        
        // 맵 상의 유닛 개수
        private integer UnitCount = 0
        
        // 생성된 현재 유닛들의 최대 개수
        private integer UnitPoolCount = 0
        
        // 유닛 ID 인덱스 집합
        private integer UnitIndices = 0

        private integer array UnitIdArr
        private integer array UnitHandleIdArr
        private unit array UnitArr
        private trigger array UnitEventArr

        private timer array CGTimerArr
        private real array CGTimeArr
        private trigger array DeathTrigArr
        private trigger array DeathTrigActArr
    endglobals

    function GetIndexRate takes nothing returns real
        return UnitCount / JASS_MAX_ARRAY_SIZE
    endfunction

    
    function GetTriggerIndex takes nothing returns integer
        return
    endfunction

    function GetUnitRemoveTrigger takes unit inUnit returns trigger
        return
    endfunction

    private function Deindex takes integer inId returns nothing

    endfunction

    private function UnregisterReferance takes integer inId returns nothing
        
    endfunction

    /* 유닛이 맵상에 존재하지 않을 경우 Deindex 호출 */
    private function OnGarbageCollector takes nothing returns nothing
        
    endfunction

    /* 유닛이 죽었을 경우 딜레이 타임을 초기화 시키고 가비지 컬렉션 재실행 */
    private function OnUnitDeathEvent takes nothing returns nothing
        
    endfunction

    private function RegisterReferance takes unit inUnit, integer inId returns nothing
        set CGTimerArr[inId] = CreateTimer()
        set DeathTrigArr[inId] = CreateTrigger()
        set DeathTrigActArr[inId] = TriggerAddAction(DeathTrigActArr[inId], function OnUnitDeathEvent)
        call TriggerRegisterUnitEvent(DeathTrigActArr[inId], inUnit, EVENT_UNIT_DEATH)

        call HandleTable.integer[GetHandleId[CGTimerArr[inId]]] = id
        call HandleTable.integer[GetHandleId[DeathTrigArr[inId]]] = id

        if IsUnitType(inUnit, UNIT_TYPE_DEAD) then
            set CGTimeArr[inId] = 1.00
            call TimerStart(CGTimerArr[inId], CGTimeArr[inId], false, function OnGarbageCollector)
        endif
    endfunction
    
    function GetUnitIndex takes unit inUnit returns integer
        return HandleTable.integer[GetHandleId(inUnit)]
    endfunction

    function IsUnitIndexed takes unit inUnit returns boolean
        return HandleTable.has(GetHandleId(inUnit))
    endfunction

    function UnitIndex takes unit inUnit returns integer
        local integer handleId = GetTriggerUnit(inUnit)
        local integer id

        if true == HandleTable.has(handleId) then
            set id = HandleTable.integer[handleId]
        else
            if 0 == GetUnitTypeId(inUnit) then
                return 0
            endif
            
            if UnitIndices == 0 then
                set UnitPoolCount = UnitPoolCount + 1
                set id = UnitPoolCount
            else
                set UnitIndices = UnitIndices - 1
                set id = UnitIdArr[UnitIndices]
            endif

            set UnitCount = UnitCount + 1
            set UnitArr[id] = inUnit
            set UnitHandleIdArr[id] = handleId
            set UnitEventArr[id] = CreateTrigger()

            set HandleTable.integer[handleId] = id

            call RegisterReferance(inUnit, id)
        endif

        return id
    endfunction


    /* [Tooltip] 맵 초기화시 이미 생성된 유닛들에 한해서 트리거 발동 */
    private function OnAllocateCondition takes nothing returns boolean
        return not HandleTable.has(GetHandleId(GetTriggerUnit()))
    endfunction

    private function OnAllocateAction takes nothing returns nothing
        call UnitIndex(GetTriggerUnit())
    endfunction

    private function OnPostAllocate takes nothing returns nothing
        local trigger enterRectSimpTrig = CreateTrigger()
        call TriggerAddCondition(enterRectSimpTrig, Condition(function OnAllocateCondition))
        call TriggerAddAction(enterRectSimpTrig, function OnAllocateAction)
        call TriggerRegisterEnterRectSimple(enterRectSimpTrig, GetWorldBounds())
        set enterRectSimpTrig = null
    endfunction
    /* end */

    /* [Tooltip] 유닛 생성시 트리거 발동 */
    private function OnEnumPreAllocate takes nothing returns boolean
        call UnitIndex(GetFilterUnit())
        return false
    endfunction

    private function OnPreAllocate takes nothing returns nothing
        local group preAllocateGroup = CreateGroup()
        set GroupEnumUnitsInRect(preAllocateGroup, GetWorldBounds(), Filter(function OnEnumPreAllocate))
        call DestroyGroup(preAllocateGroup)
        set preAllocateGroup = null
    endfunction
    /* end */

    private function Start takes nothing returns nothing
        set HandleTable = Table.create()
        call OnPreAllocate()
        call OnPostAllocate()
    endfunction
endlibrary