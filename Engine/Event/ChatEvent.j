library ChatEvent initializer Start requires Alloc, Table, ErrorMessage
    
    globals
        private player CommandPlayer = null
        private string array CommandMsgArray
        private integer ArgsCount
        private integer MinLength = 2147483647;

        private Table Map
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
        local integer length = StringLength(inCommand)

        if length == 0 then
            debug 
            return
        endif
        
        if Map.has(hashKey) then
            debug 
            return
        endif

        if MinLength > length then
            set MinLength = length
        endif 

        set Map.boolexpr[hashKey] = inCallback
    endfunction

    private 

    private function Action takes nothing returns boolean
        local string msg = GetEventPlayerChatString()
        local integer length = StringLength(msg)
        local integer eof = 0
        local integer start = 0
        local integer end
        local string tmp

        local integer hashKey = 0 // = //StringHash(inCommand)
        

        loop
            exitwhen eof == length

            set tmp = SubString(msg, eof, eof + 1)
            if tmp == " " then
            
            endif

            set eof = eof + 1
        endloop

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

        if Map.has(hashKey) == false then
            return
        endif
        


        set CommandPlayer = GetTriggerPlayer()
        //set CommandMsgArray = 

        call OnCallback(Map.boolexpr[hashKey])
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

        set Map = Table.create()

        set trig = null
    endfunction
endlibrary
