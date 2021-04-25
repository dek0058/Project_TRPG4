library FColor uses Alloc, Ascii

//! textmacro COLOR_MIN takes TYPE, MAX, MIN
    if $TYPE$ > $MAX$ then
        set $TYPE$ = $MAX$
    elseif $TYPE$ < $MIN$ then
        set $TYPE$ = $MIN$
    endif
//! endtextmacro

    struct FColor extends array
        implement Alloc

        readonly static thistype Red
        readonly static thistype Blue
        readonly static thistype Green
        readonly static thistype Black
        readonly static thistype Clean

        integer r
        integer g
        integer b
        integer a

        private static method onInit takes nothing returns nothing
            set Red = create(255, 0, 0, 255)
        endmethod

        static method create takes integer inR, integer inG, integer inB, integer inA returns thistype
            local thistype this = allocate()
            set r = inR
            set g = inG
            set b = inB
            set a = inA
            return this
        endmethod

        method destroy takes nothing returns nothing
            call deallocate()
        endmethod

        method Set takes integer inR, integer inG, integer inB, integer inA returns nothing
            set r = inR
            set g = inG
            set b = inB
            set a = inA

            //! runtextmacro COLOR_MIN("r", "255", "0")
            //! runtextmacro COLOR_MIN("g", "255", "0")
            //! runtextmacro COLOR_MIN("b", "255", "0")
            //! runtextmacro COLOR_MIN("a", "255", "0")     
        endmethod

        method Add takes integer inR, integer inG, integer inB, integer inA returns nothing
            set r = r + inR
            set g = g + inG
            set b = b + inB
            set a = a + inA

            //! runtextmacro COLOR_MIN("r", "255", "0")
            //! runtextmacro COLOR_MIN("g", "255", "0")
            //! runtextmacro COLOR_MIN("b", "255", "0")
            //! runtextmacro COLOR_MIN("a", "255", "0")
        endmethod

        method Sub takes integer inR, integer inG, integer inB, integer inA returns nothing
            set r = r - inR
            set g = g - inG
            set b = b - inB
            set a = a - inA

            //! runtextmacro COLOR_MIN("r", "255", "0")
            //! runtextmacro COLOR_MIN("g", "255", "0")
            //! runtextmacro COLOR_MIN("b", "255", "0")
            //! runtextmacro COLOR_MIN("a", "255", "0")
        endmethod

        method Mul takes real inVal returns nothing
            set r = R2I(r * inVal)
            set g = R2I(g * inVal)
            set b = R2I(b * inVal)
            set a = R2I(a * inVal)

            //! runtextmacro COLOR_MIN("r", "255", "0")
            //! runtextmacro COLOR_MIN("g", "255", "0")
            //! runtextmacro COLOR_MIN("b", "255", "0")
            //! runtextmacro COLOR_MIN("a", "255", "0")
        endmethod

        method Div takes real inVal returns nothing
            set r = R2I(r / inVal)
            set g = R2I(g / inVal)
            set b = R2I(b / inVal)
            set a = R2I(a / inVal)

            //! runtextmacro COLOR_MIN("r", "255", "0")
            //! runtextmacro COLOR_MIN("g", "255", "0")
            //! runtextmacro COLOR_MIN("b", "255", "0")
            //! runtextmacro COLOR_MIN("a", "255", "0")
        endmethod

        method ToString takes string inText returns string
            local string msg = "|C" + A2S(a) + A2S(r) + A2S(g) + A2S(b) + inText + "|r"
            return msg
        endmethod

        static method ToStringText takes integer inR, integer inG, integer inB, string inText returns string
            local string msg = "|CFF" + A2S(inR) + A2S(inG) + A2S(inB) + inText + "|r"
            return msg
        endmethod
    endstruct    
endlibrary
