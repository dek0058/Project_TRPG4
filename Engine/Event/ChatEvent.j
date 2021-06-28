library ChatEvent initializer Start requires Alloc, Table, ErrorMessage
    
    globals
        private player CommandPlayer = null
        private string CommandMsg = ""

        private HashTable Map
    endglobals

    function GetChatPlayer takes nothing returns player
        return CommandPlayer
    endfunction

    function GetCommand takes nothing returns string
        return CommandMsg
    endfunction

    function GetArgs takes integer inPos returns string
        return 
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

    private function Action takes nothing returns boolean
        //@ TODO 커맨드 구하기
        local integer hashKey = //StringHash(inCommand)

        if hashKey == 0 then
            return
        endif

        if Map[0].has(hashKey) == false then
            return
        endif
        
        set CommandPlayer = GetTriggerPlayer()
        set CommandMsg = 

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
