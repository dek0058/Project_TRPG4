library ChatEvent initializer Start requires Alloc, Table, ErrorMessage
    
    globals
        private player CommandPlayer = null
        private string array CommandMsgArray
        private integer ArgsCount = 0

        private Table Map
    endglobals

    function GetChatPlayer takes nothing returns player
        return CommandPlayer
    endfunction

    function GetArgs takes integer inPos returns string
        return CommandMsgArray[inPos]
    endfunction

    function GetArgsCount takes nothing returns integer
        return ArgsCount
    endfunction
    
    function AddChatEvent takes string inCommand, boolexpr inCallback returns nothing
        local string cmd = StringCase(inCommand, false)
        local integer hashKey = StringHash(cmd)
        local integer length = JNStringLength(inCommand)

        if length == 0 then
            debug call ThrowWarning(true, "ChatEvent", "AddChatEvent", "", 0, "명령어가 없습니다. [" + inCommand + "]")
            return
        endif
        
        if Map.boolexpr.has(hashKey) == true then
            debug call ThrowWarning(true, "ChatEvent", "AddChatEvent", "", 0, "이미 존재하는 Key Value입니다. [" + inCommand + "]")
            return
        endif

        debug call WriteLog("Engine", "ChatEvent", "AddChatEvent", inCommand)
        set Map.boolexpr[hashKey] = inCallback
    endfunction

    private function Action takes nothing returns boolean
        local string msg = GetEventPlayerChatString()
        local integer length = JNStringLength(msg)
        local integer iter = 0
        local integer index = 0

        local string str
        local integer hashKey

        set ArgsCount = 0

        loop
            if iter == length then
                if iter > index then
                    set str = JNStringSub(msg, index, length - index)
                    set CommandMsgArray[ArgsCount] = str
                    set ArgsCount = ArgsCount + 1
                endif
                exitwhen true
            endif
            
            set str = JNStringSub(msg, iter, 1)
            if JNStringContains(str, " ") == true then
                set str = JNStringSub(msg, index, iter - index)
                set CommandMsgArray[ArgsCount] = str
                set ArgsCount = ArgsCount + 1
                set index = iter + 1
            endif

            set iter = iter + 1
        endloop

        if ArgsCount == 0 then
            return false
        endif

        set hashKey = StringHash(StringCase(CommandMsgArray[0], false))

        if hashKey == NULL then
            return false
        endif

        if not Map.boolexpr.has(hashKey) == true then
            return false
        endif
        
        set CommandPlayer = GetTriggerPlayer()
        call OnCallback(Map.boolexpr[hashKey])
        return false
    endfunction

    private function Start takes nothing returns nothing
        local trigger trig = CreateTrigger()
        local integer i = 0

        call TriggerAddCondition(trig, function Action)
        loop
            exitwhen i > MaxPlayerCount
            call TriggerRegisterPlayerChatEvent(trig, Player(i), "", false)
            set i = i + 1
        endloop

        set Map = Table.create()

        set trig = null
    endfunction
endlibrary
