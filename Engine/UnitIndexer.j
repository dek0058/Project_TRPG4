library UnitIndexer initializer Start uses Table

    globals
        private Table HandleTable
        
        // 맵 상의 유닛 개수
        private integer UnitCount = 0
        
        // 생성된 현재 유닛들의 최대 개수
        private integer UnitPoolCount = 0
        
        // 유닛 ID 인덱스 집합
        private integer UnitIndices = 0

        private integer array UnitIndexArr
        private integer array UnitIdArr
        private unit array UnitArr
        private trigger array UnitEventArr
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

    private function bbb takes nothing returns nothing
        
    endfunction

    private function aaa takes nothing returns nothing
        
    endfunction

    private function RegisterReferance takes unit inUnit, integer inId returns nothing
        
    endfunction
    
    function GetUnitIndex takes unit inUnit returns integer
    endfunction

    function IsUnitIndexed takes unit inUnit returns boolean
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
                set UnitIndices + UnitIndices - 1
                set id = 
            endif

            set UnitCount = UnitCount + 1


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