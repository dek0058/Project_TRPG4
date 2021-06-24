library ChatEvent initializer Start requires Alloc
    
    globals
        private trigger Trigger = CreateTrigger()

        private player CommandPlayer = null
        private string CommandMsg = ""
    endglobals


    struct ChatCommand extends array
        implement GlobalAlloc

        string command
        code callback

        static method create takes string inCommand, code inCallback returns thistype
            local thistype this = allocate()
            local integer i = 0

            loop
                exitwhen i >= MaxPlayerCount
                set i = i + 1
                call TriggerRegisterPlayerChatEvent(Trigger, Player(i), inCommand, false)
            endloop

            return this
        endmethod
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
        call TriggerAddCondition(Trigger, function Action)
    endfunction
endlibrary
