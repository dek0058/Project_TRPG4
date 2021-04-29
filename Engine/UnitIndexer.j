library UnitIndexer initializer Start uses Table

    globals
        private Table HandleTable
        
        // �� ���� ���� ����
        private integer UnitCount = 0
        
        // ������ ���� ���ֵ��� �ִ� ����
        private integer UnitPoolCount = 0
        
        // ���� ID �ε��� ����
        private integer UnitIndices = 0

        private integer TriggerIndex = 0

        private integer array UnitIdArr
        private integer array UnitHandleIdArr
        private unit array UnitArr
        private trigger array RemoveTrigArr

        private timer array CGTimerArr
        private real array CGTimeArr
        private trigger array DeathTrigArr
        private triggeraction array DeathTrigActArr
    endglobals


    function GetIndexRate takes nothing returns real
        return UnitCount / I2R(JASS_MAX_ARRAY_SIZE)
    endfunction
    
    function GetTriggerIndex takes nothing returns integer
        return TriggerIndex
    endfunction

    function GetUnitRemoveTrigger takes unit inUnit returns trigger
        return RemoveTrigArr[HandleTable.integer[GetHandleId(inUnit)]]
    endfunction

    private function Deindex takes integer inId returns nothing
        local integer temp = TriggerIndex

        set TriggerIndex = inId
        call TriggerExecute(RemoveTrigArr[inId])
        set TriggerIndex = temp

        // Ʈ���� ����
        call DestroyTrigger(RemoveTrigArr[inId])
        set RemoveTrigArr[inId] = null

        call HandleTable.remove(UnitHandleIdArr[inId])
        set UnitArr[inId] = null
        set UnitHandleIdArr[inId] = 0
        set UnitIdArr[UnitIndices] = inId
        set UnitIndices = UnitIndices + 1
        set UnitCount = UnitCount - 1
    endfunction

    private function UnregisterReferance takes integer inId returns nothing
        // �ڵ� ���̺� ����
        call HandleTable.remove(GetHandleId(CGTimerArr[inId]))
        call HandleTable.remove(GetHandleId(DeathTrigArr[inId]))
        
        // Ÿ�̸� ����
        call DestroyTimer(CGTimerArr[inId])
        set CGTimerArr[inId] = null

        // Ʈ���� ����
        call TriggerRemoveAction(DeathTrigArr[inId], DeathTrigActArr[inId])
        set DeathTrigActArr[inId] = null
        call DestroyTrigger(DeathTrigArr[inId])
        set DeathTrigArr[inId] = null
    endfunction

    // ������ �ʻ� �������� ���� ��� Deindex ȣ��
    private function OnGarbageCollector takes nothing returns nothing
        local integer id = HandleTable.integer[GetHandleId(GetExpiredTimer())]
        if GetUnitTypeId(UnitArr[id]) != 0 then
            if IsUnitType(UnitArr[id], UNIT_TYPE_DEAD) then
                set CGTimeArr[id] = CGTimeArr[id] + 1.00
                call TimerStart(CGTimerArr[id], CGTimeArr[id], false, function OnGarbageCollector)
            endif
            return
        endif
        call UnregisterReferance(id)
        call Deindex(id)
    endfunction

    // ������ �׾��� ��� ������ Ÿ���� �ʱ�ȭ ��Ű�� ������ �÷��� �����
    private function OnUnitDeathEvent takes nothing returns nothing
        local integer id = HandleTable.integer[GetHandleId(GetTriggeringTrigger())]
        set CGTimeArr[id] = 1.00
        call TimerStart(CGTimerArr[id], CGTimeArr[id], false, function OnGarbageCollector)
    endfunction

    private function RegisterReferance takes unit inUnit, integer inId returns nothing
        set CGTimerArr[inId] = CreateTimer()
        set DeathTrigArr[inId] = CreateTrigger()
        set DeathTrigActArr[inId] = TriggerAddAction(DeathTrigArr[inId], function OnUnitDeathEvent)
        call TriggerRegisterUnitEvent(DeathTrigArr[inId], inUnit, EVENT_UNIT_DEATH)

        set HandleTable.integer[GetHandleId(CGTimerArr[inId])] = inId
        set HandleTable.integer[GetHandleId(DeathTrigArr[inId])] = inId

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
        local integer handleId = GetHandleId(inUnit)
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
            set RemoveTrigArr[id] = CreateTrigger()

            set HandleTable.integer[handleId] = id

            call RegisterReferance(inUnit, id)
        endif

        return id
    endfunction


    // [Tooltip] �� �ʱ�ȭ�� �̹� ������ ���ֵ鿡 ���ؼ� Ʈ���� �ߵ�
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
    // end

    // [Tooltip] ���� ������ Ʈ���� �ߵ�
    private function OnEnumPreAllocate takes nothing returns boolean
        call UnitIndex(GetFilterUnit())
        return false
    endfunction

    private function OnPreAllocate takes nothing returns nothing
        local group preAllocateGroup = CreateGroup()
        call GroupEnumUnitsInRect(preAllocateGroup, GetWorldBounds(), Filter(function OnEnumPreAllocate))
        call DestroyGroup(preAllocateGroup)
        set preAllocateGroup = null
    endfunction
    // end

    private function Start takes nothing returns nothing
        set HandleTable = Table.create()
        call OnPreAllocate()
        call OnPostAllocate()
    endfunction
endlibrary