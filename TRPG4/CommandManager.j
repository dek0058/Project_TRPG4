library CommandManager uses ChatEvent

    globals
        private Table Map
    endglobals


    function AddCommand takes string inCommand, boolexpr inCallback returns nothing
        local string cmd = StringCase(inCommand, false)
        local integer hashKey = StringHash(cmd)
        local integer length = StringLength(cmd)

        if length == 0 then
            debug call ThrowWarning(true, "Main", "AddCommand", "", 0, "명령어가 없습니다. [" + inCommand + "]")
            return
        endif

        if Map.boolexpr.has(hashKey) then
            debug call ThrowWarning(true, "Main", "AddCommand", "", 0, "이미 존재하는 Key Value입니다. [" + inCommand + "]")
            return
        endif

        debug call WriteLog("TRPG4", "CommandManager", "AddCommand", inCommand)
        set Map.boolexpr[hashKey] = inCallback
    endfunction

    private function OnCommand takes nothing returns boolean
        local integer hashKey
        
        if GetArgsCount() < 2 then
            return false
        endif

        set hashKey = StringHash(StringCase(GetArgs(1), false))

        if not Map.boolexpr.has(hashKey) then
            return false
        endif

        call OnCallback(Map.boolexpr[hashKey])
        return false
    endfunction

    function InitCommandManager takes nothing returns nothing
        set Map = Table.create()

        call AddChatEvent("cmd", Filter(function OnCommand))

        call InitUnitCommonCmd.evaluate()
    endfunction
endlibrary