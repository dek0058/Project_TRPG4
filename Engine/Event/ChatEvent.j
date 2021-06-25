library ChatEvent initializer Start requires Alloc, Table, ErrorMessage
    
    globals
        private trigger Trigger

        private player CommandPlayer = null
        private string CommandMsg = ""

        private HashTable ChatHashTable
    endglobals


    struct ChatCommand extends array
        implement GlobalAlloc

        string command
        code callback

        /*static method create takes string inCommand, code inCallback returns thistype
            local thistype this = allocate()
            local integer hashKey = StringHash(inCommand)
            local integer i = 0

            if ChatHashTable.has(hashKey) then
                debug call ThrowError(true, "ChatEvent", "create", "ChatCommand", this, inCommand + " Haved HashKey(" + I2S(hashKey) + ")")
                call deallocate()
                return 0;
            endif

            set command = inCommand
            set callback = inCallback

            loop
                exitwhen i >= MaxPlayerCount
                set i = i + 1
                call TriggerRegisterPlayerChatEvent(Trigger, Player(i), inCommand, false)
            endloop

            set ChatHashTable[hashKey]

            return this
        endmethod
        */
    endstruct


    struct ChatEvent extends array
        implement GlobalAlloc

        //private TArraystring 

        static method create takes nothing returns thistype
            local thistype this = allocate()

            return this
        endmethod
    endstruct

    private function Action takes nothing returns boolean
        
        //ExecuteFunc()

        return false
    endfunction

    private function Start takes nothing returns nothing
        set Trigger = CreateTrigger()
        set ChatHashTable = HashTable.create()

        call TriggerAddCondition(Trigger, function Action)
    endfunction
endlibrary
