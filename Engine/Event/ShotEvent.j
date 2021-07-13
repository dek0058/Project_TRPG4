library ShotEvent requires Alloc
    //! runtextmacro DEFINE_STRUCT_TARRAY("ShotEvent", "ShotEvent")

    struct ShotEvent extends array
        implement GlobalAlloc
        
        private boolexpr callback

        static method create takes boolexpr inCallback returns thistype
            local thistype this = allocate()
            set callback = inCallback
            return this
        endmethod

        method destroy takes nothing returns nothing
            set callback = null
            call deallocate()
        endmethod

        method Execute takes nothing returns nothing
            call OnCallback(callback)
        endmethod
    endstruct
endlibrary