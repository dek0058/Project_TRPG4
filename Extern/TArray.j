library TArray requires Table, ErrorMessage, Alloc

// 기본 변수
//! runtextmacro DEFINE_TARRAY("boolean", "boolean")
//! runtextmacro DEFINE_TARRAY("integer", "integer")
//! runtextmacro DEFINE_TARRAY("real", "real")
//! runtextmacro DEFINE_TARRAY("string", "string")

// 워크 클래스 변수
//! runtextmacro DEFINE_TARRAY("player", "player")
//! runtextmacro DEFINE_TARRAY("widget", "widget")
//! runtextmacro DEFINE_TARRAY("destructable", "destructable")
//! runtextmacro DEFINE_TARRAY("item", "item")
//! runtextmacro DEFINE_TARRAY("unit", "unit")
//! runtextmacro DEFINE_TARRAY("ability", "ability")
//! runtextmacro DEFINE_TARRAY("timer", "timer")
//! runtextmacro DEFINE_TARRAY("trigger", "trigger")
//! runtextmacro DEFINE_TARRAY("triggercondition", "triggercondition")
//! runtextmacro DEFINE_TARRAY("triggeraction", "triggeraction")
//! runtextmacro DEFINE_TARRAY("event", "event")
//! runtextmacro DEFINE_TARRAY("force", "force")
//! runtextmacro DEFINE_TARRAY("group", "group")
//! runtextmacro DEFINE_TARRAY("location", "location")
//! runtextmacro DEFINE_TARRAY("rect", "rect")
//! runtextmacro DEFINE_TARRAY("boolexpr", "boolexpr")
//! runtextmacro DEFINE_TARRAY("sound", "sound")
//! runtextmacro DEFINE_TARRAY("effect", "effect")
//! runtextmacro DEFINE_TARRAY("unitpool", "unitpool")
//! runtextmacro DEFINE_TARRAY("itempool", "itempool")
//! runtextmacro DEFINE_TARRAY("quest", "quest")
//! runtextmacro DEFINE_TARRAY("questitem", "questitem")
//! runtextmacro DEFINE_TARRAY("defeatcondition", "defeatcondition")
//! runtextmacro DEFINE_TARRAY("timerdialog", "timerdialog")
//! runtextmacro DEFINE_TARRAY("leaderboard", "leaderboard")
//! runtextmacro DEFINE_TARRAY("multiboard", "multiboard")
//! runtextmacro DEFINE_TARRAY("multiboarditem", "multiboarditem")
//! runtextmacro DEFINE_TARRAY("trackable", "trackable")
//! runtextmacro DEFINE_TARRAY("dialog", "dialog")
//! runtextmacro DEFINE_TARRAY("button", "button")
//! runtextmacro DEFINE_TARRAY("texttag", "texttag")
//! runtextmacro DEFINE_TARRAY("lightning", "lightning")
//! runtextmacro DEFINE_TARRAY("image", "image")
//! runtextmacro DEFINE_TARRAY("ubersplat", "ubersplat")
//! runtextmacro DEFINE_TARRAY("region", "region")
//! runtextmacro DEFINE_TARRAY("fogstate", "fogstate")
//! runtextmacro DEFINE_TARRAY("fogmodifier", "fogmodifier")
//! runtextmacro DEFINE_TARRAY("hashtable", "hashtable")

//! textmacro_once DEFINE_TARRAY takes NAME, TYPE
    struct TArray$NAME$ extends array
        implement Alloc

        private Table table
        private integer length
        
        private method Set takes integer inPos, $TYPE$ inVal returns nothing
            set table.$TYPE$[inPos] = inVal
        endmethod

        private method Get takes integer inPos returns $TYPE$
            return table.$TYPE$[inPos]
        endmethod
        
        // [Tooltip] 배열의 위치가 잘못되었을 때 오류
        private method AssertPosition takes integer inPos, string exception returns boolean
            local string str = ""
            debug if inPos < 0 or inPos >= length then
                set str = "포지션의 값이 잘못되었습니다."
                set str = str + "(" + exception + " " + "pos :"  +  I2S(inPos) + ", lenth : " + I2S(length) + ")"
                debug call ThrowError(true, "TArray$NAME$", "AssertPosition", this, str)
            debug endif
            return inPos >= 0 and inPos <= length
        endmethod

        private method AssertRange takes integer inPos, string exception returns boolean
            local string str = ""
            debug if inPos < 0 or inPos > length then
                set str = "배열의 범위 밖의 값을 호출하였습니다."
                set str = str + "(" + exception + " " + "pos :"  +  I2S(inPos) + ", lenth : " + I2S(length) + ")"
                debug call ThrowError(true, "TArray$NAME$", )
            debug endif
            return inPos >= 0 and inPos <= length
        endmethod
        
        method operator [] takes integer inPos returns $TYPE$
            debug if AssertPosition(inPos, "operator []") then
                debug return Get(-1)
            debug endif
            return Get(inPos)
        endmethod
        
        method operator []= takes integer inPos, $TYPE$ inVal returns nothing
            debug if AssertPosition(inPos, "operator []") then
                debug return
            debug endif
            call Set(inPos, inVal)
        endmethod

        static method create takes nothing returns thistype
            local thistype this = allocate()
            set table = Table.create()
            set length = 0
            return this
        endmethod  

        method destroy takes nothing returns nothing
            call Clear()
            call table.destroy()
            set table = 0
            call deallocate()
        endmethod

        method Clear takes nothing returns nothing
            set length = 0
            call table.flush()
        endmethod

        method Front takes nothing returns $TYPE$
            return this[0]
        endmethod

        method Back takes nothing returns $TYPE$
            return this[length-1]
        endmethod

        method Value takes nothing returns Table
            return this.table
        endmethod

        method IsEmpty takes nothing returns boolean
            return length == 0
        endmethod

        method Size takes nothing returns integer
            return length
        endmethod

        method Push takes $TYPE$ inVal returns thistype
            call Set(length, inVal)
            set length = length + 1
            return this
        endmethod

        method Pop takes nothing returns thistype
            if length > 0 then
                set length = length - 1
                call table.$TYPE$.remove(length)
            endif
            return this
        endmethod

        static method operator [] takes thistype inPtr returns thistype
            local thistype instance = create()
            loop
                exitwhen instance.Size() >= inPtr.Size()
                call instance.Push(inPtr[instance.Size()])
            endloop
            return instance
        endmethod

        method Assign takes integer inCnt, $TYPE$ inVal returns thistype
            if inCnt > 0 then
                call Clear()
                loop
                    exitwhen length >= inCnt
                    call Push(inVal)
                endloop
            endif

            return this
        endmethod

        method Insert takes integer inPos, integer inCnt, $TYPE$ inVal returns thistype
            local integer i

            if AssertRange(inPos, "Insert") and inCnt > 0 then
                set length = length + inCnt
                set i = length - 1
                loop
                    exitwhen i < (inPos + inCnt)
                    call Set(i, Get(i - inCnt))
                    set i = i - 1
                endloop

                set i = 0
                loop
                    exitwhen i >= inCnt
                    call Set(inPos + i, inVal)
                    set i = i + 1
                endloop
            endif

            return this
        endmethod

        method Erase takes integer inPos, integer inCnt returns thistype
            if AssertPosition(inPos, "Erase") and inCnt > 0 then
                if inPos + inCnt > length then
                    set inCnt = length - inPos
                endif

                set inPos = inPos + inCnt
                loop
                    exitwhen inPos >= length
                    call Set(inPos - inCnt, Get(inPos))
                    set inPos = inPos + 1
                endloop

                loop
                    exitwhen inCnt <= 0
                    call Pop()
                    set inCnt = inCnt - 1
                endloop
            endif

            return this
        endmethod
    endstruct
//! endtextmacro

//! textmacro_once DEFINE_STRUCT_TARRAY takes NAME, TYPE
    struct TArray$NAME$ extends array
        private delegate TArrayinteger parent
        
        method operator[] takes integer inPos returns $TYPE$
            return parent[inPos]
        endmethod

        static method create takes nothing returns thistype
            local thistype this = TArrayinteger.create()
            set parent = this
            return this
        endmethod

        method Front takes nothing returns $TYPE$
            return parent.Front()
        endmethod

        method Back takes nothing returns $TYPE$
            return parent.Back()
        endmethod
    endstruct
//! endtextmacro
endlibrary