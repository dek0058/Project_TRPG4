library FVector

    struct FVector extends array
        implement Alloc

        readonly static integer Zero;
        readonly static integer One;
        readonly static integer Up;
        readonly static integer Down;
        readonly static integer Back;
        readonly static integer Forward;
        readonly static integer Right;
        readonly static integer Left;

        real x
        real y
        real z

        static method create takes real inX, real inY, real inZ returns thistype
            local thistype this = allocate()
            set x = inX
            set y = inY
            set z = inZ
            return this
        endmethod

        method destroy takes nothing returns nothing
            call deallocate()
        endmethod


        method Add takes nothing returns nothing

        endmethod

        method Sub takes nothing returns nothing

        endmethod

        method Mul takes nothing returns nothing

        endmethod

        method Div takes nothing returns nothing

        endmethod



    endstruct

endlibrary