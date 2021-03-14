library Timers

//# +nosemanticerror
private function int_to_real takes integer i returns real
    return i
endfunction

//# +nosemanticerror
private function real_to_int takes real r returns integer
    return r
endfunction

private function clean_real takes real r returns real
    return r
    return 0.0 // prevent jasshelper from inlining
endfunction

private function clean_int takes integer i returns integer
    return i
    return 0 // prevent jasshelper from inlining
endfunction

private function i2r takes integer i returns real
    return clean_real(int_to_real(i))
endfunction

private function r2i takes real i returns integer
    return clean_int(real_to_int(i))
endfunction

struct Timer extends array
    readonly static integer max_count = 0 // the maximum number of timers we've ever had ticking
    readonly static integer curr_count = 0 // the current number of timers ticking

    private static Timer head = 0 // a free list of timers
    private Timer next

    private timer t
    integer data
    private real timeout

    static method start takes integer user_data, real timeout, code callback returns Timer
        local Timer this

        if head != 0 then
            set this = head
            set head = head.next

        else
            set max_count = max_count + 1
            if max_count > 8190 then
static if DEBUG_MODE then
                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0.0, 0.0, 1000.0, "|cffFF0000[Timer] error: could not allocate a Timer instance|r")
endif
                return 0
            endif

            set this = max_count
            set this.t = CreateTimer()
        endif
        set curr_count = curr_count + 1

        set this.next = 0
        set this.data = user_data
        set this.timeout = i2r( r2i(timeout) / 8192 * 8192 + this )

        call TimerStart(this.t, this.timeout, false, callback)

        return this
    endmethod

    method stop takes nothing returns nothing
        if this == 0 then
static if DEBUG_MODE then
        call DisplayTimedTextToPlayer(GetLocalPlayer(), 0.0, 0.0, 1000.0, "|cffFF0000[Timer] error: cannot stop null Timer instance|r")
endif
            return
        endif

        if this.next != 0 then
static if DEBUG_MODE then
        call DisplayTimedTextToPlayer(GetLocalPlayer(), 0.0, 0.0, 1000.0, "|cffFF0000[Timer] error: cannot stop Timer(" + I2S(this) + ") instance more than once|r")
endif
            return
        endif

        set curr_count = curr_count - 1

        call TimerStart(this.t, 0.0, false, null)
        set this.next = head
        set head = this
    endmethod

    method pause takes nothing returns nothing
        call TimerStart(this.t, 0.0, false, null)
    endmethod

    static method get_expired takes nothing returns Timer
        local integer i = r2i( TimerGetTimeout(GetExpiredTimer()) )
        return Timer( i - i / 8192 * 8192 )
    endmethod

    static method get_expired_data takes nothing returns integer
        local Timer t = get_expired()
        local integer data = t.data
        call t.stop()
        return data
    endmethod

    method restart takes code callback returns nothing
        call TimerStart(this.t, this.timeout, false, callback)
    endmethod

endstruct

endlibrary