library FColor initializer Start uses Alloc

    struct FColor extends array
        implement Alloc

        readonly static thistype Red
        readonly static thistype Blue
        readonly static thistype Green
        readonly static thistype Black
        readonly static thistype Clean

        real r
        real g
        real b
        real a

        private static method onInit takes nothing returns nothing

        endmethod

        static method create takes real inR, real inG, real inB, real inA returns thistype
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

        

    endstruct

    
endlibrary
