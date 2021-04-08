library FTick uses Alloc, Table, TArray initializer Start

    //! runtextmacro DEFINE_STRUCT_TARRAY("Tick", "FTick")

    globals
        private Table TickTable
        private TArrayTick WaitingTickList
    endglobals

    struct FTick extends array
        implement Alloc

        timer tick
        integer pointer

        static method create takes nothing returns thistype
            local thistype temp = 0

            if WaitingTickList.Size() > 0 then
                set temp = WaitingTickList.Back()
                call WaitingTickList.Pop()
            else
                set temp = allocate()
                set temp.tick = CreateTimer()
            endif

            set temp.pointer = 0

            return temp
        endmethod

        method destroy takes nothing returns nothing
            call WaitingTickList.Push(this)
        endmethod

        method Value takes nothing returns timer
            return tick
        endmethod

        static method Start takes integer inPointer, real inDeltaTime, bool inLoop, code inCallback returns thistype
            local thistype this = create()
            set pointer = inPointer
            call TimerStart(tick, inDeltaTime, inLoop, inCallback)
            return this
        endmethod

        static method GetTick takes nothing returns thistype
                        
        endmethod
    endstruct

    private function Start takes nothing returns nothing
        set WaitingTickList = TArrayTick.create()
    endfunction
endlibrary