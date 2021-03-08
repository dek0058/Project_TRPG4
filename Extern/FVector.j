library FVector uses Alloc

    /*
    Right, Left     = X��ǥ
    Up, Down        = Y��ǥ
    Forward, Back   = Z��ǥ
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

         /*����*/
        method Add takes nothing returns nothing

        endmethod

        /*����*/
        method Sub takes nothing returns nothing

        endmethod

        /*����*/
        method Mul takes nothing returns nothing

        endmethod

        /*������*/
        method Div takes nothing returns nothing

        endmethod

        /*������ ũ��*/
        method Size takes nothing returns nothing

        endmethod

        /*����*/
        method Dot takes nothing returns nothing

        endmethod

        /*����*/
        method Cross takes nothing returns nothing

        endmethod

        /*����ȭ*/
        method Normalize takes nothing returns nothing

        endmethod

        /*������ ������ ũ��*/
        method Squared takes nothing returns nothing

        endmethod
    endstruct
endlibrary