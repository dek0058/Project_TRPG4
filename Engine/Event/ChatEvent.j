library ChatEvent initializer Start requires Alloc, Table, ErrorMessage
    
    globals
        private player CommandPlayer = null
        private string array CommandMsgArray
        private integer ArgsCount

        private HashTable Map
    endglobals

    function GetChatPlayer takes nothing returns player
        return CommandPlayer
    endfunction

    function GetCommand takes nothing returns string
        return CommandMsgArray[0]
    endfunction

    function GetArgs takes integer inPos returns string
        return 
    endfunction

    function GetArgsCount takes nothing returns integer
        return ArgsCount
    endfunction
    
    function AddChatEvent takes string inCommand, boolexpr inCallback returns nothing
        local integer hashKey = StringHash(inCommand)

        if hashKey == 0 then
            debug 
            return
        endif
        
        if Map[0].has(hashKey) then
            debug 
            return
        endif

        set Map[0].boolexpr[hashKey] = inCallback
    endfunction

    private 

    private function Action takes nothing returns boolean
        //@ TODO 커맨드 구하기
        local msg = GetEventPlayerChatString()
        local length = StringLength(msg)
        
        local integer hashKey = 0 // = //StringHash(inCommand)
        
        /*
                local boolean rsta = false
                local integer ddx = 0
                local integer sdx = 0
                local string cstr = GetEventPlayerChatString(  )
                local integer slen = StringLength(cstr)
                set CDC = 0
                loop
                    if not rsta then
                        if SubString(cstr, sdx, sdx+1) != " " then
                            set ddx = sdx
                            set rsta = true
                        endif
                    else
                        if SubString(cstr, sdx, sdx+1) == " " then
                            set CD[CDC] = SubString(cstr, ddx, sdx)
                            set CDC = CDC + 1
                            set rsta = false
                        endif
                    endif
                    set sdx = sdx + 1
                    exitwhen sdx >= slen
                endloop
                if rsta then
                    set CD[CDC] = SubString(cstr, ddx, sdx)
                    set CDC = CDC + 1
                endif
                call TriggerEvaluate(LoadTriggerHandle( H, 0, StringHash(CD[0]) ))
        */
        


        if hashKey == 0 then
            return
        endif

        if Map[0].has(hashKey) == false then
            return
        endif
        


        set CommandPlayer = GetTriggerPlayer()
        //set CommandMsgArray = 

        call OnCallback(Map[0].boolexpr[hashKey])
        return false
    endfunction

    private function Start takes nothing returns nothing
        local trigger trig = CreateTrigger()

        call TriggerAddCondition(trig, function Action)
        loop
            exitwhen i >= MaxPlayerCount
            set i = i + 1
            call TriggerRegisterPlayerChatEvent(trig, Player(i), "", false)
        endloop

        set ChatHashTable = HashTable.create()

        set trig = null
    endfunction
endlibrary
