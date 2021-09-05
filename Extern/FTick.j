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
            local thistype this = 0

            if WaitingTickList.Size() > 0 then
                set this = WaitingTickList.Back()
                call WaitingTickList.Pop()
                //! runtextmacro RecyleLog("FTick", "this")
            else
                set this = allocate()
                set tick = CreateTimer()
                set TickTable.integer[GetHandleId(tick)] = this
                //! runtextmacro CreateLog("FTick", "this")
            endif

            set pointer = inPointer
            set deltaTime = inDeletaTime

            return this
        endmethod

        method destroy takes nothing returns nothing
            //! runtextmacro DestroyLog("FTick", "this")
            call Stop()
            set pointer = 0
            set deltaTime = 0.00
            call WaitingTickList.Push(this)
        endmethod

        method Value takes nothing returns timer
            return tick
        endmethod

        static method Start takes integer inPointer, real inDeltaTime, boolean inLoop, code inCallback returns thistype
            local thistype this = create(inPointer, inDeltaTime)
            call this.Run(inLoop, inCallback)
            return this
        endmethod

        method Run takes boolean inLoop, code inCallback returns nothing
            call TimerStart(tick, deltaTime, inLoop, inCallback)
        endmethod

        method RunUniqueTime takes real inDeltaTime, boolean inLoop, code inCallback returns nothing
            call TimerStart(tick, inDeltaTime, inLoop, inCallback)
        endmethod

        method Stop takes nothing returns nothing
            call TimerStart(tick, 0.0, false, null)
        endmethod

        static method GetTick takes nothing returns thistype
            return TickTable.integer[GetHandleId(GetExpiredTimer())]
        endmethod

        method GetRemaining takes nothing returns real
            return TimerGetRemaining(tick)
        endmethod

        method GetElapsed takes nothing returns real
            return TimerGetElapsed(tick)
        endmethod

        method GetTimeout takes nothing returns real
            return TimerGetTimeout(tick)
        endmethod
    endstruct

    private function Start takes nothing returns nothing
        set TickTable = Table.create()
        set WaitingTickList = TArrayTick.create()
    endfunction
endlibrary