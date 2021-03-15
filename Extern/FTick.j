library FTick uses Alloc

    struct FTick extends array
        implement Alloc

        timer tick
        integer pointer

        static method create takes nothing returns thistype
            local thistype this = allocate()
            set tick = CreateTimer()
            set pointer = 0
            return this
        endmethod

        method destroy takes nothing returns nothing
            call DestroyTimer(tick)
            set tick = null
            call deallocate()
        endmethod


        static method Start takes integer inPointer, real inDeltaTime, bool inLoop, code inCallback returns thistype
            local thistype this = create()
            set pointer = inPointer
            call TimerStart(tick, inDeltaTime, inLoop, inCallback)
            return this
        endmethod
        
        method Release takes nothing returns nothing

        endmethod

        method Pause takes nothing returns nothing

        endmethod

        method Restart takes nothing returns nothing

        endmethod
    
        static method GetTick takes nothing returns thistype
            

        endmethod
    endstruct




endlibrary