library ChatEvent initializer Start requires Alloc, Table, ErrorMessage
    
    globals
        private player CommandPlayer = null
        private string array CommandMsgArray
        private integer ArgsCount = 0
        private integer MinLength = 2147483647

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
        local integer hashKey = StringHash(inCommand)
        local integer length = StringLength(inCommand)

        if length == 0 then
            debug call ThrowWarning(true, "ChatEvent", "AddChatEvent", "", 0, "명령어가 없습니다. [" + inCommand + "]")
            return
        endif
        
        if Map.boolexpr.has(hashKey) then
            debug call ThrowWarning(true, "ChatEvent", "AddChatEvent", "", 0, "이미 존재하는 Key Value입니다. [" + inCommand + "]")
            return
        endif

        if MinLength > length then
            set MinLength = length
        endif 

        set Map.boolexpr[hashKey] = inCallback
    endfunction

    private function Action takes nothing returns boolean
        local string msg = GetEventPlayerChatString()
        local integer length = StringLength(msg)
        local integer iter = 0
        local integer index = 0

        local string str
        local integer hashKey

        set ArgsCount = 0

        loop
            if iter == length then
                if iter > index then
                    set str = SubString(msg, index, iter)
                    if StringLength(str) >= MinLength then
                        set CommandMsgArray[ArgsCount] = str
                        set ArgsCount = ArgsCount + 1
                    endif
                endif
                exitwhen true
            endif

            set str = SubString(msg, iter, iter + 1)
            if str == " " then
                set str = SubString(msg, index, iter)
                if StringLength(str) >= MinLength then
                    set CommandMsgArray[ArgsCount] = str
                    set ArgsCount = ArgsCount + 1
                endif
                set index = iter + 1
            endif

            set iter = iter + 1
        endloop

        if ArgsCount == 0 then
            return false
        endif

        set hashKey = StringHash(CommandMsgArray[0])

        if hashKey == 0 then
            return false
        endif

        if not Map.boolexpr.has(hashKey) then
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
