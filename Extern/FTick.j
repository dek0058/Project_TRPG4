library FTick initializer Start uses Alloc, Table, TArray

    //! runtextmacro DEFINE_STRUCT_TARRAY("Tick", "FTick")

    globals
        private Table TickTable
        private TArrayTick WaitingTickList
    endglobals

    struct FTick extends array
        implement Alloc

        timer tick
        integer pointer
        real deltaTime

        static method create takes integer inPointer, real inDeletaTime returns thistype
            local thistype temp = 0

            if WaitingTickList.Size() > 0 then
                set temp = WaitingTickList.Back()
                call WaitingTickList.Pop()
            else
                set temp = allocate()
                set temp.tick = CreateTimer()
                set TickTable.integer[GetHandleId(temp.tick)] = temp
            endif

            set temp.pointer = inPointer
            set temp.deltaTime = inDeletaTime
            return temp
        endmethod

        method destroy takes nothing returns nothing
            call TimerStart(tick, 0.0, false, null)
            set pointer = 0
            set deltaTime = 0.00
            call WaitingTickList.Push(this)
        endmethod

        method Value takes nothing returns timer
            return tick
        endmethod

        static method Start takes integer inPointer, real inDeltaTime, boolean inLoop, code inCallback returns thistype
            local thistype this = create(inPointer, inDeltaTime)
            call TimerStart(tick, deltaTime, inLoop, inCallback)
            return this
        endmethod

        method Run takes boolean inLoop, code inCallback returns nothing
            call TimerStart(tick, deltaTime, inLoop, inCallback)
        endmethod

        static method GetTick takes nothing returns thistype
            return TickTable.integer[GetHandleId(GetExpiredTimer())]
        endmethod
    endstruct

    private function Start takes nothing returns nothing
        set WaitingTickList = TArrayTick.create()
    endfunction
endlibrary