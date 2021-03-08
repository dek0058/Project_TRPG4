library FVector uses Alloc

    /*
    Right, Left     = XÁÂÇ¥
    Up, Down        = YÁÂÇ¥
    Forward, Back   = ZÁÂÇ¥
    */

    struct FVector extends array
        implement Alloc

        readonly static thistype Zero
        readonly static thistype One
        readonly static thistype Right
        readonly static thistype Left
        readonly static thistype Up
        readonly static thistype Down
        readonly static thistype Forward
        readonly static thistype Back

        real x
        real y
        real z

        private static method onInit takes nothing returns nothing
            set Zero = create(0, 0, 0)
            set One = create(1, 1, 1)
            set Right = create(1, 0 , 0)
            set Left = create(-1, 0, 0)
            set Up = create(0, 1, 0)
            set Down = create(0, -1, 0)
            set Forward = create(0, 0, 1)
            set Back = create(0, 0, -1)
        endmethod

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

        method Set takes nothing returns nothing

        endmethod

         /*µ¡¼À*/
        method Add takes nothing returns nothing

        endmethod

        /*»¬›»*/
        method Sub takes nothing returns nothing

        endmethod

        /*°ö¼À*/
        method Mul takes nothing returns nothing

        endmethod

        /*³ª´°¼À*/
        method Div takes nothing returns nothing

        endmethod

        /*º¤ÅÍÀÇ Å©±â*/
        method Size takes nothing returns nothing

        endmethod

        /*³»Àû*/
        method Dot takes nothing returns nothing

        endmethod

        /*¿ÜÀû*/
        method Cross takes nothing returns nothing

        endmethod

        /*Á¤±ÔÈ­*/
        method Normalize takes nothing returns nothing

        endmethod

        /*º¤ÅÍÀÇ Á¦°öÀÇ Å©±â*/
        method Squared takes nothing returns nothing

        endmethod
    endstruct
endlibrary