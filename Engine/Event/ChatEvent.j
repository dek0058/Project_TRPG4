library ChatEvent requires Alloc
    
    
    struct ChatCommand extends array
        implement Alloc

        
    endstruct


    struct ChatEvent extends array
        implement GlobalAlloc

        private player gamePlayer
        private trigger trig

        static method create takes player inPlayer returns thistype
            local thistype this = allocate()

            set gamePlayer = inPlayer

            set trig = CreateTrigger()
            call TriggerAddCondition(trig, Condition(function thistype.Action))

            return this
        endmethod

        private static method Action takes nothing returns boolean

            return false
        endmethod

    endstruct
endlibrary
