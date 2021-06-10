library ActorThread initializer Start uses MainThread, Actor, FMath, FTick

    globals
        private constant integer Capacity = 96
        private constant real ApproximatelyZero = 0.001
        private constant real HalfDeltaTime = (DeltaTime / 2.0)

        private Room array Rooms
        private integer RoomCount = 0

        private real LocalVelocityX = 0.0
        private real LocalVelocityY = 0.0
        private real LocalVelocityZ = 0.0
    endglobals

    //! textmacro IsNearZero takes Value
    if ($Value$ > 0 and $Value$ <= ApproximatelyZero) or ($Value$ < 0 and $Value$ >= -ApproximatelyZero) then
        set $Value$ = 0
    endif
    //! endtextmacro

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
    endfunction

    private function PhysVelocity takes Actor inActor returns nothing
        local real x
        local real y
        local real z
        local real unitX = inActor.X
        local real unitY = inActor.Y
        local real unitZ = inActor.Z
        local real locZ = GetFloor(unitX, unitY)
        local real frictionMag
        local real size


        // 땅에 착지된 상태라면 의미가 없음으로 속도를 0으로 맞춘다.
        if inActor.velocityZ < 0 and unitZ <= MinHeight then
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

    private function Run takes Actor inActor returns nothing
        local real x = inActor.X
        local real y = inActor.Y
        local real z = inActor.Z
        local real locZ
        local real result
        local boolean isFalling = false
        local real height = inActor.heightZ

        set inActor.forceX = 0.0
        set inActor.forceY = 0.0
        set inActor.forceZ = 0.0

        if LocalVelocityX != 0.0 then
            set result = x + LocalVelocityX
            
            if not PathableNothing(result, y) then
                if not inActor.IsFly() then
                    set locZ = GetFloor(result, y)

                    if not PathableWalking(result, y) and height > locZ then
                        
                    else if not PathableWalking(result, y) and height < locZ then

                    else if height > locZ then
                        set isFalling = true

                    else if height < locZ then

                    endif

                    if height < locZ then
                        set result = x
                    endif
                endif
                set inActor.X = result
            endif
        endif

        if LocalVelocityY != 0.0 then
            set result = y + LocalVelocityY
            
            if not PathableNothing(x, result) then
                if not inActor.IsFly() then
                    set locZ = GetFloor(x, result)
                    if inActor.heightZ < locZ then
                        set result = y
                    endif
                endif
                set inActor.Y = result
            endif
        endif

        if LocalVelocityZ != 0.0 then
            set result = z + LocalVelocityZ

            if result > MaxHeight then
                set result = z
            endif
            set inActor.Z = result
        endif
    endfunction

    struct Room extends array
        implement Alloc

        private integer start
        private FTick tick

        static method Create takes integer inStart returns nothing
            local thistype this = allocate()
            
            set Rooms[RoomCount] = this
            set RoomCount = RoomCount + 1

            set start = inStart
            
            set tick = FTick.Start(this, DeltaTime, true, function thistype.Update)
        endmethod

        private static method Update takes nothing returns nothing
            local FTick expiredTick = FTick.GetTick()
            local thistype this = expiredTick.pointer
            local integer count = Actor.AllocCount()
            local integer totalCapacity = RoomCount * Capacity
            local integer i = 0
            local integer iter

            loop
                exitwhen i == Capacity
                set i = i + 1
                set iter = start + (i - 1)
                
                exitwhen iter >= count
                if Actors[iter].IsValid() then
                    call PhysForce(Actors[iter])
                    call PhysVelocity(Actors[iter])
                    call PhysForce(Actors[iter])
                    call Run(Actors[iter])
                endif
            endloop

            if count > totalCapacity then
                call Create(totalCapacity)
            endif
        endmethod
    endstruct
    

    globals
        private trigger OnceTrigger
        private triggeraction OnceAction
    endglobals

    private function Once takes nothing returns nothing
        call Room.Create(0)

        call TriggerRemoveAction(OnceTrigger, OnceAction)
        set OnceAction = null
        call DestroyTrigger(OnceTrigger)
        set OnceTrigger = null
    endfunction

    private function Start takes nothing returns nothing
        set OnceTrigger = CreateTrigger()
        set OnceAction = TriggerAddAction(OnceTrigger, function Once)
        call TriggerRegisterTimerEvent(OnceTrigger, 1.0, false)
    endfunction
endlibrary