library UnitIndexer initializer Start uses Table

    globals
        private HashTable handleTable
        
        private integer 

    endglobals

    globals


    endglobals


    function GetIndexRate takes nothing returns real
        return 
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
        
    endfunction

    private function OnAllocateAction takes nothing returns nothing

    endfunction

    private function OnAllocateCondition takes nothing returns boolean

    endfunction

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