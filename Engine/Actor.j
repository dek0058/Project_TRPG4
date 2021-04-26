library Actor initializer Start uses Alloc, Controller, FVector, FColor

    //! runtextmacro DEFINE_STRUCT_TARRAY("Actor", "Actor")

    globals
        private constant integer FLYING_ABILITY = 'Amrf'

        private TArrayActor WaitingActorList
    endglobals

    struct Actor extends array
        implement Alloc
        
        private unit gameUnit
        private Controller controller

        // Unit Status
        private FVector position
        private real scale
        private FColor color

        static method create takes real inX, real inY, real inZ, real inFace, integer inId, player inPlayer returns thistype
            local thistype this = allocate()
            
            set position = FVector.create(inX, inY, inZ)
            set color = FColor.create(255, 255, 255, 255)

            set gameUnit = CreateUnit(inPlayer, inId, position.x, position.y, inFace)
            call UnitAddAbility(gameUnit, FLYING_ABILITY)
            call UnitRemoveAbility(gameUnit, FLYING_ABILITY)
            call SetUnitFlyHeight(gameUnit, position.z, 0.00)

            set controller = Controller.Get(inPlayer)
            call controller.RegisterUnit(gameUnit)

            return this
        endmethod

        method destroy takes nothing returns nothing
            //set controller = 0
            
            call deallocate()
        endmethod

        method Value takes nothing returns unit
            return gameUnit
        endmethod

        method IsValid takes nothing returns boolean
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
            return position
        endmethod

        method GetPositionZ takes nothing returns real
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
        // 이 메소드는 아이템을 해당 위치에 버리는데 사용 됩니다.
        method OrderInstant takes integer inId, real inX, real inY, widget inItem returns boolean
            return IssueInstantPointOrderById(gameUnit, inId, inX, inY, inItem)
        endmethod
        // 이 메소드는 아이템을 다른 유닛에게 전달하는데 사용 됩니다.
        method OrderInstantTarget takes integer inId, widget inTarget, widget inItem returns boolean
            return IssueInstantTargetOrderById(gameUnit, inId, inTarget, inItem)
        endmethod
        // 이 메소드들은 영웅을 구매한다는데 사용 한다고는 합니다...
        method OrderNeutral takes player inPlayer, unit inUnit, integer inUnitId returns boolean
            return IssueNeutralImmediateOrderById(inPlayer, inUnit, inUnitId)
        endmethod
        method OrderNeutralPoint takes player inPlayer, unit inUnit, integer inUnitId, real inX, real inY returns boolean
            return IssueNeutralPointOrderById(inPlayer, inUnit, inUnitId, inX, inY)
        endmethod
        method OrderNeutralTarget takes player inPlayer, unit inUnit, integer inUnitId, widget inTarget returns boolean
            return IssueNeutralTargetOrderById(inPlayer, inUnit, inUnitId, inTarget)
        endmethod
        // 이 메소드는 건물 건설 명령을 내릴 때 사용 됩니다.
        method OrderBuild takes integer inUnitId, real inX, real inY returns boolean
            return IssueBuildOrderById(gameUnit, inUnitId, inX, inY)
        endmethod

        method SetAnimation takes integer inIndex returns nothing
            call SetUnitAnimationByIndex(gameUnit, inIndex)
        endmethod

    endstruct

    private function Start takes nothing returns nothing
        set WaitingActorList = TArrayActor.create()
    endfunction
endlibrary