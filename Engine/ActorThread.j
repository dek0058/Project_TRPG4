library ActorThread initializer Start uses MainThread, Actor, FMath, FTick

    globals
        private constant integer Capacity = 50
        private constant real ApproximatelyZero = 0.001
        private constant real HalfDeltaTime = (DeltaTime / 2.0)
        
        private Room array Rooms
        private integer RoomCount = 0

        private real LocalVelocityX = 0.0
        private real LocalVelocityY = 0.0
        private real LocalVelocityZ = 0.0
        private boolean IsChanged = false
    endglobals

    //! textmacro IsNearZero takes Value
    if ($Value$ > 0 and $Value$ <= ApproximatelyZero) or ($Value$ < 0 and $Value$ >= -ApproximatelyZero) then
        set $Value$ = 0
    endif
    //! endtextmacro
    
    private function Collision takes Actor inActor returns nothing
        set inActor.velocityX = 0
        set inActor.velocityY = 0
        // TODO 충돌 이벤트
    endfunction


    private function PhysForce takes Actor inActor returns nothing
        local real x = 0.0
        local real y = 0.0
        local real z = 0.0

        if inActor.imass == 0 then
            return
        endif

        if inActor.forceX != 0 then
            set x = (inActor.forceX * inActor.imass) * HalfDeltaTime
            //! runtextmacro IsNearZero("x")
            set inActor.velocityX = inActor.velocityX + x
        endif

        if inActor.forceY != 0 then
            set y = (inActor.forceY * inActor.imass) * HalfDeltaTime
            //! runtextmacro IsNearZero("y")
            set inActor.velocityY = inActor.velocityY + y
        endif
        
        set z = ((inActor.forceZ * inActor.imass) + Gravity) * HalfDeltaTime
        set inActor.velocityZ = inActor.velocityZ + z

        if inActor.velocityZ < 0 and inActor.DefaultZ <= (MinHeight + inActor.defaultFly) then
            set inActor.velocityZ = 0.0
        endif
    endfunction

    private function PhysVelocity takes Actor inActor returns nothing
        local real x
        local real y
        local real z
        local real unitX = inActor.X
        local real unitY = inActor.Y
        local real unitZ = inActor.DefaultZ
        local real locZ = GetFloor(unitX, unitY)
        local real frictionMag
        local real size


        // 땅에 착지된 상태라면 의미가 없음으로 속도를 0으로 맞춘다.
        if inActor.velocityZ < 0 and unitZ <= (MinHeight + inActor.defaultFly) then
            set inActor.velocityZ = 0.0
        endif

        if inActor.velocityX != 0 then
            set x = inActor.velocityX * DeltaTime
            //! runtextmacro IsNearZero("x")
            set LocalVelocityX = x
        endif

        if inActor.velocityY != 0 then
            set y = inActor.velocityY * DeltaTime
            //! runtextmacro IsNearZero("y")
            set LocalVelocityY = y
        endif

        if inActor.velocityZ != 0 then
            set z = inActor.velocityZ * DeltaTime
            //! runtextmacro IsNearZero("z")
            set LocalVelocityZ = z
        endif

        if inActor.mass > 0 then
            set x = inActor.velocityX
            set y = inActor.velocityY
            set z = inActor.velocityZ
            
            set frictionMag = inActor.locFriction * (inActor.mass * -Gravity) * -1
            set size = (x * x) + (y * y)
            if x != 0 then
                set x = (inActor.velocityX / SquareRoot(size)) * frictionMag                
                //! runtextmacro IsNearZero("x")
                set inActor.forceX = inActor.forceX + x

                set x = (inActor.forceX * inActor.imass) * HalfDeltaTime
                if (inActor.velocityX > 0 and (inActor.velocityX + x) < 0) or (inActor.velocityX < 0 and (inActor.velocityX + x) > 0) then
                    set inActor.forceX = 0
                    set inActor.velocityX = 0
                endif
            endif

            if y != 0 then
                set y = (inActor.velocityY / SquareRoot(size)) * frictionMag
                //! runtextmacro IsNearZero("y")
                set inActor.forceY = inActor.forceY + y

                set y = (inActor.forceY * inActor.imass) * HalfDeltaTime
                if (inActor.velocityY > 0 and (inActor.velocityY + y) < 0) or (inActor.velocityY < 0 and (inActor.velocityY + y) > 0) then
                    set inActor.forceY = 0
                    set inActor.velocityY = 0
                endif
            endif

            if z != 0 then
                set z = (inActor.velocityZ / SquareRoot(z * z)) * frictionMag
                //! runtextmacro IsNearZero("z")
                set inActor.forceZ = inActor.forceZ + z

                set z = (inActor.forceZ * inActor.imass) * HalfDeltaTime
                if (inActor.velocityZ > 0 and (inActor.velocityZ + z) < 0) or (inActor.velocityZ < 0 and (inActor.velocityZ + z) > 0) then
                    set inActor.forceZ = 0
                    set inActor.velocityZ = 0
                endif
            endif
        endif
    endfunction

    private function Work takes Actor inActor returns nothing
        local real x = inActor.X
        local real y = inActor.Y
        local real z = inActor.DefaultZ
        local real locZ

        set inActor.forceX = 0.0
        set inActor.forceY = 0.0
        set inActor.forceZ = 0.0
        set IsChanged = false

        if LocalVelocityX != 0 then
            set x = x + LocalVelocityX
            set IsChanged = true
        endif

        if LocalVelocityY != 0 then
            set y = y + LocalVelocityY
            set IsChanged = true
        endif

        if LocalVelocityZ != 0 then
            set z = z + LocalVelocityZ
            set IsChanged = true
        endif

        if true == IsChanged and (not PathableNothing(x, y)) then
            if not inActor.IsFly() then
                set locZ = GetFloor(x, y)
                
                if not PathableWalking(x, y) then
                    if inActor.Z < locZ then
                        call Collision(inActor)
                        set x = inActor.X
                        set y = inActor.Y
                    else
                        call SetUnitPathing(inActor.Value(), false)
                        set z = z + (GetFloor(inActor.X, inActor.Y) - locZ)
                    endif
                else
                    if inActor.Z < locZ then
                        set x = inActor.X + (LocalVelocityX * 0.866)
                        set y = inActor.Y + (LocalVelocityY * 0.866)
                    else
                        set z = z + (GetFloor(inActor.X, inActor.Y) - locZ)
                    endif
                endif
            endif

            if z > MaxHeight then
                set z = MaxHeight
            endif

            set inActor.X = x
            set inActor.Y = y
            set inActor.Z = z
        endif

        if not inActor.IsFly() then
            if PathableWalking(x, y) then
                call SetUnitPathing(inActor.Value(), true)
            endif

            if inActor.DefaultZ > (MinHeight + inActor.defaultFly) then
                call SetUnitMoveSpeed(inActor.Value(), -9999999)
            else
                call SetUnitMoveSpeed(inActor.Value(), inActor.deafultSpeed)
            endif
        endif

        set LocalVelocityX = 0
        set LocalVelocityY = 0
        set LocalVelocityZ = 0
    endfunction

    struct Room extends array
        implement GlobalAlloc

        private FTick tick
        private TArrayActor actors

        private boolean isActive

        static method create takes nothing returns thistype
            local thistype this = allocate()

            //! runtextmacro CreateLog("Room", "this")
            set Rooms[RoomCount] = this
            set RoomCount = RoomCount + 1

            set actors = TArrayActor.create()
            set tick = FTick.create(this, DeltaTime)

            set isActive = false

            return this
        endmethod

        method destroy takes nothing returns nothing
            //! runtextmacro DestroyLog("Room", "this")
            call tick.destroy()
            set tick = NULL
            call actors.destroy()
            set actors = NULL
            call deallocate()
        endmethod

        private static method Update takes nothing returns nothing
            local FTick expiredTick = FTick.GetTick()
            local thistype this = expiredTick.pointer
            local integer i = Count()

            if i == 0 then
                call Inactive()
                return
            endif

            set i = i - 1
            loop
                if actors[i].IsValid() then
                    call PhysForce(actors[i])
                    call PhysVelocity(actors[i])
                    call PhysForce(actors[i])
                    call Work(actors[i])

                    if actors[i].velocityX == 0 and actors[i].velocityY == 0 and actors[i].velocityZ == 0 then
                        call Remove(actors[i])
                    endif
                else
                    call Remove(actors[i])
                endif
                set i = i - 1
                exitwhen i < 0
            endloop
        endmethod

        method Count takes nothing returns integer
            return actors.Size()
        endmethod

        method Active takes nothing returns nothing
            if isActive == true then
                return
            endif
            set isActive = true
            call tick.Run(true, function thistype.Update)
        endmethod

        method Inactive takes nothing returns nothing
            if isActive == false then
                return
            endif
            set isActive = false
            call TimerStart(tick.Value(), 0.0, false, null)
        endmethod

        method Add takes Actor inActor returns nothing
            local boolean Reactive = Count() == 0
            call actors.Push(inActor)
            set inActor.isPhysical = true
            if Reactive == true then
                call Active()
            endif
        endmethod

        method Remove takes Actor inActor returns nothing
            local integer i = 0
            loop
                exitwhen i == actors.Size()
                if inActor == actors[i] then
                    call actors.Erase(i, 1)
                    set inActor.isPhysical = false
                    exitwhen true
                endif
                set i = i + 1
            endloop
        endmethod
    endstruct


    private function UpdateAction takes nothing returns boolean
        local Actor actor
        local Room room
        local integer i = 0
        local boolean isFull = false

        loop
            exitwhen PhysicalQueue.IsEmpty()
            set actor = PhysicalQueue.Back()
            call PhysicalQueue.Pop()

            if actor.IsValid() == true then
                if actor.isPhysical == false then
                    set isFull = false
                    loop
                        if i == RoomCount then
                            set isFull = true
                            exitwhen true
                        endif
                        if Rooms[i].Count() < Capacity then
                            call Rooms[i].Add(actor)
                            exitwhen true
                        endif
                        set i = i + 1
                    endloop

                    if isFull == true then
                        set room = Room.create()
                        call room.Add(actor)
                    endif
                endif
            endif
        endloop

        if RemoveActorList.Size() > 0 then
            set actor = RemoveActorList.Back()
            call RemoveActorList.Pop()
            if actor.IsValid() == true then
                call RemoveActorList.Push(actor)
            endif
        endif
        return false
    endfunction

    private function OnEnterUnitAction takes nothing returns nothing
        local unit actor = GetTriggerUnit()
        local integer i = 0
        call Actor.RegisterUnit(GetTriggerUnit())
        set CreateUnitId = GetUnitTypeId(actor)
        loop
            exitwhen i >= CreateUnitEventList.Size()
            call CreateUnitEventList[i].Execute()
            set i = i + 1
        endloop
        set actor = null
    endfunction

    private function OnAllocateUnitCondition takes nothing returns boolean
        local unit actor = GetFilterUnit()
        local integer i = 0
        call Actor.RegisterUnit(GetFilterUnit())
        set CreateUnitId = GetUnitTypeId(actor)
        loop
            exitwhen i >= CreateUnitEventList.Size()
            call CreateUnitEventList[i].Execute()
            set i = i + 1
        endloop
        set actor = null
        return false
    endfunction

     private function OnPostAllocateTrigger takes nothing returns nothing
        local trigger trig = CreateTrigger()
        local region rectRegion = CreateRegion()
        call RegionAddRect(rectRegion, GetWorldBounds())
        call TriggerAddAction(trig, function OnEnterUnitAction)
        call TriggerRegisterEnterRegion(trig, rectRegion, null)
        set trig = null
        set rectRegion = null
    endfunction

    private function OnPreAllocateTrigger takes nothing returns nothing
        local group allocateGroup = CreateGroup()
        call GroupEnumUnitsInRect(allocateGroup, GetWorldBounds(), Filter(function OnAllocateUnitCondition))
        call DestroyGroup(allocateGroup)
        set allocateGroup = null
    endfunction

    private function OnUpdateActorTrigger takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerAddCondition(trig, function UpdateAction)
        call TriggerRegisterTimerEvent(trig, DeltaTime, true)
        set trig = null
    endfunction

    private function Start takes nothing returns nothing
        call OnUpdateActorTrigger()
        call OnPreAllocateTrigger()
        call OnPostAllocateTrigger()
    endfunction
endlibrary