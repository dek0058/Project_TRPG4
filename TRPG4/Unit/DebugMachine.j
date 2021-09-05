library DebugMachine initializer Start uses MainDefine

    globals
        public constant integer ID = 'EX01'
    endglobals

    
    private function OnSpawn takes nothing returns boolean
        if ID != CreateUnitId then
            return false
        endif

        // TODO - - -

        return false
    endfunction

    private function Start takes nothing returns nothing
        local ShotEvent createUnitEvent

        set createUnitEvent = ShotEvent.create(Filter(function OnSpawn))
        call CreateUnitEventList.Push(createUnitEvent)
        
        set createUnitEvent = NULL
    endfunction
endlibrary