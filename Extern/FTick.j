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
        real deltaTime
        code callback

        static method create takes integer inPointer, real inDeletaTime, code inCallback returns thistype
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
            set temp.deltaTime inDeletaTime
            set temp.code = inCallback
            return temp
        endmethod

        method destroy takes nothing returns nothing
            call TimerStart(tick, 0.0, false, null)
            set pointer = 0
            set deletaTime = 0.00
            set callback = null
            call WaitingTickList.Push(this)
        endmethod

        method Value takes nothing returns timer
            return tick
        endmethod

        static method Start takes integer inPointer, real inDeltaTime, bool inLoop, code inCallback returns thistype
            local thistype this = create(inPointer, inDeltaTime, inCallback)
            call TimerStart(tick, deltaTime, inLoop, callback)
            return this
        endmethod

        method Run takes bool inLoop returns nothing
            call TimerStart(tick, deltaTime, inLoop, callback)
        endmethod

        static method GetTick takes nothing returns thistype
            return TickTable.integer[GetHandleId(GetExpiredTimer())]
        endmethod
    endstruct

    private function Start takes nothing returns nothing
        set WaitingTickList = TArrayTick.create()
    endfunction
endlibrary