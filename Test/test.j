
globals
    hashtable STRUCT_2_TICK_TABLE = InitHashtable()
endglobals
//! textmacro Struct2TickVJ
        private static integer MAX = 0
        private timer T
        static method operator Count takes nothing returns integer
            return MAX
        endmethod
        static method GetExpired takes nothing returns thistype
            return LoadInteger( STRUCT_2_TICK_TABLE, 0, GetHandleId(GetExpiredTimer()) )
        endmethod
        static method Create takes nothing returns thistype
            local thistype this = thistype.allocate(  )
            set MAX = MAX + 1
            if .T == null then
                set .T = CreateTimer(  )
                call SaveInteger( STRUCT_2_TICK_TABLE, 0, GetHandleId(T), this )
            endif
            static if thistype.OnCreate.exists then
                call this.OnCreate()
            endif
            return this
        endmethod
        method operator Base takes nothing returns timer
            return .T
        endmethod
        method operator Elapsed takes nothing returns real
            return TimerGetElapsed( .T )
        endmethod
        method operator Remaining takes nothing returns real
            return TimerGetRemaining( .T )
        endmethod
        method operator Timeout takes nothing returns real
            return TimerGetTimeout( .T )
        endmethod
        method Pause takes nothing returns nothing
            call PauseTimer( .T )
        endmethod
        method Resume takes nothing returns nothing
            call ResumeTimer( .T )
        endmethod
        method Start takes real r, boolean flag, code c returns nothing
            call TimerStart( .T, r, flag, c )
        endmethod
        method Destroy takes nothing returns nothing
            static if thistype.OnDestroy.exists then
                call this.OnDestroy()
            endif
            set MAX = MAX - 1
            call PauseTimer( .T )
            call thistype.deallocate( this )
        endmethod
//! endtextmacro