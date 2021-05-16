library Actor initializer Start uses Alloc, Controller, FVector, FColor

    //! runtextmacro DEFINE_STRUCT_TARRAY("Actor", "Actor")

    globals
        private constant integer FLYING_ABILITY = 'Amrf'

        private TArrayActor WaitingActorList
        private hashtable hs

        private integer Count = 0
        Actor array Actors
    endglobals

    private function GetPointer takes integer inIndex returns integer
        return LoadInteger(hs, 0, inIndex)
    endfunction

    private function SetPointer takes integer inIndex, integer inPointer returns nothing
        call SaveInteger(hs, 0, inIndex, inPointer)
    endfunction

    private function DeletePointer takes integer inIndex returns nothing
        call RemoveSavedInteger(hs, 0, inIndex)
    endfunction

    struct Actor extends array
        implement Alloc
        
        private unit gameUnit
        private Controller controller

        // Unit Status
        private FVector position
        private real scale
        private FColor color

        // Physical
        FVector velocity
        FVector physForce
        real mass
        real imass
        real locFriction

        static method AllocCount takes nothing returns integer
            return Count
        endmethod

        static method operator [] takes unit inUnit returns thistype
            return GetPointer(GetHandleId(inUnit))
        endmethod

        static method create takes real inX, real inY, real inZ, real inFace, integer inId, player inPlayer returns thistype
            local thistype temp = 0

            if WaitingActorList.Size() > 0 then
                set temp = WaitingActorList.Back()
                call WaitingActorList.Pop()
                call temp.position.Set(inX, inY, inZ)
                call temp.color.Set(255, 255, 255,255)

                call temp.velocity.Set(0.0, 0.0, 0.0)
                call temp.physForce.Set(0.0, 0.0, 0.0)
            else
                set temp = allocate()
                set temp.position = FVector.create(inX, inY, inZ)
                set temp.color = FColor.create(255, 255, 255, 255)

                set temp.velocity = FVector.create(0.0, 0.0, 0.0)
                set temp.physForce = FVector.create(0.0, 0.0, 0.0)

                set Actors[Count] = temp
                set Count = Count + 1
            endif

            set temp.gameUnit = CreateUnit(inPlayer, inId, temp.position.x, temp.position.y, inFace)
            call UnitAddAbility(temp.gameUnit, FLYING_ABILITY)
            call UnitRemoveAbility(temp.gameUnit, FLYING_ABILITY)
            call SetUnitFlyHeight(temp.gameUnit, temp.position.z, 0.00)

            set temp.scale = 1.0
            set temp.mass = 100.0
            set temp.imass = 1.0 / temp.mass
            set temp.locFriction = 1

            set temp.controller = Controller.Get(inPlayer)
            call temp.controller.RegisterUnit(temp.gameUnit)
            
            call SetPointer(GetHandleId(temp.gameUnit), temp)

            // Extern Setting

            return temp
        endmethod

        method destroy takes nothing returns nothing
            call WaitingActorList.Push(this)
            set gameUnit = null
            set controller = 0
        endmethod

        method Value takes nothing returns unit
            return gameUnit
        endmethod

        method IsValid takes nothing returns boolean
            if gameUnit != null and GetUnitTypeId(gameUnit) == 0 then
                call destroy()
            endif

            return not (gameUnit == null)
        endmethod

        method SetPositionXY takes real inX, real inY returns nothing
            set position.x = inX
            set position.y = inY
            call SetUnitX(gameUnit, position.x)
            call SetUnitY(gameUnit, position.y)
        endmethod
        method SetPositionZ takes real inZ returns nothing
            set position.z = inZ
            call SetUnitFlyHeight(gameUnit, position.z, 0)
        endmethod
        method SetPositionXYZ takes real inX, real inY, real inZ returns nothing
            call position.Set(inX, inY, inZ)
            call SetUnitX(gameUnit, position.x)
            call SetUnitY(gameUnit, position.y)
            call SetUnitFlyHeight(gameUnit, position.z, 0)
        endmethod
        
        method GetPosition takes nothing returns FVector
            call position.Set(GetUnitX(gameUnit), GetUnitY(gameUnit), GetUnitFlyHeight(gameUnit))
            return position
        endmethod

        method GetPositionZ takes nothing returns real
            set position.z = GetUnitFlyHeight(gameUnit)
            return position.z
        endmethod

        method SetScale takes real inValue returns nothing
            if inValue <= 0 then
                set scale = 0.01
            endif
            set scale = inValue
            call SetUnitScale(gameUnit, scale, scale, scale)
        endmethod

        method GetScale takes nothing returns real
            return scale
        endmethod

        method OrderPoint takes integer inId, real inX, real inY returns boolean
            return IssuePointOrderById(gameUnit, inId, inX, inY)
        endmethod
        method OrderTarget takes integer inId, widget inTarget returns boolean
            return IssueTargetOrderById(gameUnit, inId, inTarget)
        endmethod
        method Order takes integer inId returns boolean
            return IssueImmediateOrderById(gameUnit, inId)
        endmethod

        //Extra Order
        // ?´ ë©”ì†Œ?“œ?Š” ?•„?´?…œ?„ ?•´?‹¹ ?œ„ì¹˜ì— ë²„ë¦¬?Š”?° ?‚¬?š© ?©?‹ˆ?‹¤.
        method OrderInstant takes integer inId, real inX, real inY, widget inItem returns boolean
            return IssueInstantPointOrderById(gameUnit, inId, inX, inY, inItem)
        endmethod
        // ?´ ë©”ì†Œ?“œ?Š” ?•„?´?…œ?„ ?‹¤ë¥? ?œ ?‹›?—ê²? ? „?‹¬?•˜?Š”?° ?‚¬?š© ?©?‹ˆ?‹¤.
        method OrderInstantTarget takes integer inId, widget inTarget, widget inItem returns boolean
            return IssueInstantTargetOrderById(gameUnit, inId, inTarget, inItem)
        endmethod
        // ?´ ë©”ì†Œ?“œ?“¤??? ?˜?›…?„ êµ¬ë§¤?•œ?‹¤?Š”?° ?‚¬?š© ?•œ?‹¤ê³ ëŠ” ?•©?‹ˆ?‹¤...
        method OrderNeutral takes player inPlayer, unit inUnit, integer inUnitId returns boolean
            return IssueNeutralImmediateOrderById(inPlayer, inUnit, inUnitId)
        endmethod
        method OrderNeutralPoint takes player inPlayer, unit inUnit, integer inUnitId, real inX, real inY returns boolean
            return IssueNeutralPointOrderById(inPlayer, inUnit, inUnitId, inX, inY)
        endmethod
        method OrderNeutralTarget takes player inPlayer, unit inUnit, integer inUnitId, widget inTarget returns boolean
            return IssueNeutralTargetOrderById(inPlayer, inUnit, inUnitId, inTarget)
        endmethod
        // ?´ ë©”ì†Œ?“œ?Š” ê±´ë¬¼ ê±´ì„¤ ëª…ë ¹?„ ?‚´ë¦? ?•Œ ?‚¬?š© ?©?‹ˆ?‹¤.
        method OrderBuild takes integer inUnitId, real inX, real inY returns boolean
            return IssueBuildOrderById(gameUnit, inUnitId, inX, inY)
        endmethod

        method SetAnimation takes integer inIndex returns nothing
            call SetUnitAnimationByIndex(gameUnit, inIndex)
        endmethod

    endstruct

    private function Start takes nothing returns nothing
        set WaitingActorList = TArrayActor.create()
        set hs = InitHashtable()
    endfunction
endlibrary