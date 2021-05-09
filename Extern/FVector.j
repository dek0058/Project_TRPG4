library FVector uses Alloc

    //! runtextmacro DEFINE_STRUCT_TARRAY("Vector", "FVector")

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

        method Set takes real inX, real inY, real inZ returns nothing
            set x = inX
            set y = inY
            set z = inZ
        endmethod

        //����
        method Add takes real inX, real inY, real inZ returns nothing
            set x = x + inX
            set y = y + inY
            set z = z + inZ
        endmethod

        //����
        method Sub takes real inX, real inY, real inZ returns nothing
            set x = x - inX
            set y = y - inY
            set z = z - inZ
        endmethod

        //����
        method Mul takes real inVal returns nothing
            set x = x * inVal
            set y = y * inVal
            set z = z * inVal
        endmethod

        //������
        method Div takes real inVal returns nothing
            if inVal == 0 then
                debug call ThrowError(true, "FVector", "Div", "FVector", this, "�и� '0' �Դϴ�.")
                return
            endif
            set x = x / inVal
            set y = y / inVal
            set z = z / inVal
        endmethod

        //������ ũ��
        method Size takes nothing returns real
            local real size = (x * x) + (y * y) + (z * z)
            return SquareRoot(size)
        endmethod

        //������ ������ ũ��
        method Squared takes nothing returns real
            return (x * x) + (y * y) + (z * z)
        endmethod

        //����ȭ
        method Normalize takes nothing returns nothing
            local real size = SquareRoot((x * x) + (y * y) + (z * z))
            if size == 1 or size == 0 then
                return
            endif
            set x = x / size
            set y = y / size
            set z = z / size
        endmethod

        method ToString takes nothing returns string
            return "X:[" + R2S(x) + "], Y:[" + R2S(y) + "] Z:[" + R2S(z) + "]"
        endmethod

        //����
        static method Dot takes thistype inRight, thistype inLeft returns real
            local real result = (inRight.x * inLeft.x) + (inRight.y * inLeft.y) + (inRight.z * inLeft.z)
            return result
        endmethod

        //����
        static method Cross takes thistype inRight, thistype inLeft, boolean inTransient returns thistype
            local real x = (inRight.y * inLeft.z) - (inRight.z * inLeft.y)
            local real y = (inRight.z * inLeft.x) - (inRight.x * inLeft.z)
            local real z = (inRight.x * inLeft.y) - (inRight.y * inLeft.x)
            local thistype vector = create(x, y, z)
            return vector
        endmethod
    endstruct
endlibrary