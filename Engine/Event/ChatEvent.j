library ChatEvent requires Alloc
    
    globals
        private player CommandPlayer = null
        private string CommandMsg = ""
    endglobals


    struct ChatCommand extends array
        implement GlobalAlloc

        string command
        private trigger trig

        static method create takes string inCommand, code inCallback returns thistype
            local thistype this = allocate()

            set trig = CreateTrigger()
            //call TriggerRegisterPlayerChatEvent()

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


endlibrary
