library Megumin initializer Start uses MainDefine

    globals
        public constant integer ID = 'A000'
    endglobals

    private function OnSpawn takes nothing returns boolean
        if ID != CreateUnitId then
            return false
        endif

        call BJDebugMsg("메구밍 출현!")
        // TODO - - -

        return false
    endfunction

    private function Start takes nothing returns nothing
        call AddSpawnEvent(ID, Filter(function OnSpawn))
    endfunction
endlibrary