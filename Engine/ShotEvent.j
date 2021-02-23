library ShotEvent requires Alloc
    //! runtextmacro DEFINE_STRUCT_TARRAY("ShotEvent", "ShotEvent")

    struct ShotEvent extends array
        implement GlobalAlloc
        
        private trigger trig
        private triggeraction trigAct
        private triggercondition trigCon


        static method create takes nothing returns thistype
            local thistype this = allocate()
            set trig = CreateTrigger()
            set trigAct = null
            set trigCon = null
            return this
        endmethod

        method destroy takes nothing returns nothing
            if GetHandleId(trigAct) != 0 then
                call TriggerRemoveAction(trig, trigAct)
                set trigAct = null
            endif

            if GetHandleId(trigCon) != 0 then
                call TriggerRemoveCondition(trig, trigCon)
                set trigCon = null
            endif
            
            call DestroyTrigger(trig)
            set trig = null
            call deallocate()
        endmethod

        method Execute takes nothing returns nothing
            call TriggerExecute(trig)
        endmethod

        method AddAction takes code inFunction returns nothing
            set trigAct = TriggerAddAction(trig, inFunction)
        endmethod

        method AddCondition takes code inFunction returns nothing
            set trigCon = TriggerAddCondition(trig, Filter(inFunction))
        endmethod
    endstruct
endlibrary