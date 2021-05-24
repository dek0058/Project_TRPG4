library Actor initializer Start uses Alloc, Controller, FVector, FColor, MainDefine

    //! runtextmacro DEFINE_STRUCT_TARRAY("Actor", "Actor")

    globals
        private constant integer FLYING_ABILITY = 'Amrf'

        private TArrayActor WaitingActorList
        private hashtable hs

        private integer Count = 0
        Actor array Actors
    endglobals

    private function HasPointer takes integer inIndex returns boolean
        return HaveSavedInteger(hs, 0, inIndex)
    endfunction

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
        private real x
        private real y
        private real z

        private real scale

        // Physical
        real velocityX
        real velocityY
        real velocityZ

        real forceX
        real forceY
        real forceZ

        real mass
        real imass
        real locFriction


        static method AllocCount takes nothing returns integer
            return Count
        endmethod

        static method operator [] takes unit inUnit returns thistype
            return GetPointer(GetHandleId(inUnit))
        endmethod

        static method operator Register= takes unit inUnit returns thistype
            local thistype this = 0

            if GetHandleId(inUnit) == 0 then
                return 0
            endif

            if HasPointer(GetHandleId(inUnit)) then
                return Actor[inUnit]
            endif

            if WaitingActorList.Size() == 0 then
                set this = allocate()
                set Actors[Count] = this
                set Count = Count + 1
            else
                set this = WaitingActorList.Back()
                call WaitingActorList.Pop()
            endif
            
            set gameUnit = inUnit
            call UnitAddAbility(gameUnit, FLYING_ABILITY)
            call UnitRemoveAbility(gameUnit, FLYING_ABILITY)

            call Register()

            return this
        endmethod

        static method create takes real inX, real inY, real inZ, real inFace, integer inId, player inPlayer returns thistype
            local thistype this = 0

            if WaitingActorList.Size() == 0 then
                set this = allocate()
                set Actors[Count] = this
                set Count = Count + 1
            else
                set this = WaitingActorList.Back()
                call WaitingActorList.Pop()
            endif

            set gameUnit = CreateUnit(inPlayer, inId, inX, inY, inFace)
            call UnitAddAbility(gameUnit, FLYING_ABILITY)
            call UnitRemoveAbility(gameUnit, FLYING_ABILITY)
            call SetUnitFlyHeight(gameUnit, inZ, 0.00)
            call Register()

            return this
        endmethod

        method destroy takes nothing returns nothing
            call WaitingActorList.Push(this)
            set gameUnit = null
            set controller = 0
        endmethod

        method Value takes nothing returns unit
            return gameUnit
        endmethod

        private method Register takes nothing returns nothing
            set controller = Controller[GetOwningPlayer(gameUnit)]
            call controller.RegisterUnit(gameUnit)

            set x = GetUnitX(gameUnit)
            set y = GetUnitY(gameUnit)
            set z = GetUnitFlyHeight(gameUnit)

            set velocityX = 0
            set velocityY = 0
            set velocityZ = 0

            set forceX = 0
            set forceY = 0
            set forceZ = 0

            set scale = 1.0
            set mass = 100.0
            set imass = 1.0 / mass
            set locFriction = 1

            call SetPointer(GetHandleId(gameUnit), this)
        endmethod

        method IsValid takes nothing returns boolean
            if gameUnit != null and GetUnitTypeId(gameUnit) == 0 then
                call destroy()
            endif

            return not (gameUnit == null)
        endmethod

        method operator X= takes real inValue returns nothing
            set x = inValue
            call SetUnitX(gameUnit, x)
        endmethod
        method operator X takes nothing returns real
            set x = GetUnitX(gameUnit)
            return x
        endmethod

        method operator Y= takes real inValue returns nothing
            set y = inValue
            call SetUnitY(gameUnit, y)
        endmethod
        method operator Y takes nothing returns real
            set Y = GetUnitY(gameUnit)
            return y
        endmethod

        method operator Z= takes real inValue returns nothing
            local real locZ = GetFloor(X, Y)

            if inValue < locZ then
                set z = locZ
            else
                set z = inValue
            endif
            
            call SetUnitFlyHeight(gameUnit, z, 0.0)
        endmethod
        method operator Z takes nothing returns real
            set z = GetUnitFlyHeight(gameUnit)
            return z
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
        method OrderInstant takes integer inId, real inX, real inY, widget inItem returns boolean
            return IssueInstantPointOrderById(gameUnit, inId, inX, inY, inItem)
        endmethod
        method OrderInstantTarget takes integer inId, widget inTarget, widget inItem returns boolean
            return IssueInstantTargetOrderById(gameUnit, inId, inTarget, inItem)
        endmethod
        method OrderNeutral takes player inPlayer, unit inUnit, integer inUnitId returns boolean
            return IssueNeutralImmediateOrderById(inPlayer, inUnit, inUnitId)
        endmethod
        method OrderNeutralPoint takes player inPlayer, unit inUnit, integer inUnitId, real inX, real inY returns boolean
            return IssueNeutralPointOrderById(inPlayer, inUnit, inUnitId, inX, inY)
        endmethod
        method OrderNeutralTarget takes player inPlayer, unit inUnit, integer inUnitId, widget inTarget returns boolean
            return IssueNeutralTargetOrderById(inPlayer, inUnit, inUnitId, inTarget)
        endmethod
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