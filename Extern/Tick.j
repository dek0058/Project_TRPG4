library Tick uses Alloc

    struct Tick extends array
        implement Alloc

        timer tick
        

        static method create takes nothing returns thistype
            local thistype this = allocate()
            set tick = CreateTimer()
            return this
        endmethod

        method destroy takes nothing returns nothing
            call DestroyTimer(tick)
            set tick = null
            call deallocate()
        endmethod


        static method Start takes integer inPointer, real inDeltaTime, code inCallback returns thistype
            
        endmethod
        
        method Release takes nothing returns nothing

        endmethod

        method Pause takes nothing returns nothing

        endmethod

        method Restart takes nothing returns nothing

        endmethod
    endstruct




endlibrary