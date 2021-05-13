library ActorThread initializer Start uses MainThread, Actor, FMath, FTick

    globals
        private constant integer Capacity = 12
        
        private integer Index = 0

        private Room array Rooms
        private integer RoomCount = 0
    endglobals


    function PhysForce takes Actor inActor returns nothing
        local real x = 0.0
        local real y = 0.0
        local real z = 0.0
        
        if inActor.imass == 0 then
            return
        endif

        if inActor.physForce.Squared() > 0 then
            set x = (inActor.physForce.x * inActor.imass) * (DeltaTime / 2)
            set y = (inActor.physForce.y * inActor.imass) * (DeltaTime / 2)
        endif
        
        if not NearToFloor(GetUnitFlyHeight(inActor.Value())) then
            set z = ((inActor.physForce.z * inActor.imass) + Gravity) * (DeltaTime / 2)
        endif
        
        call inActor.velocity.Add(x, y, z)
    endfunction

    function PhysVelocity takes Actor inActor returns nothing
        local real x = 0
        local real y = 0
        local real z = 0
        local real size = inActor.velocity.Squared()
        local FVector pos
        local real frictionMag = 0

        if size == 0 then
            return
        endif

        if inActor.velocity.z <= 0 and NearToFloor(GetUnitFlyHeight(inActor.Value())) then
            set inActor.velocity.z = 0.0
        endif

        set pos = inActor.GetPosition()
        
        set x = pos.x + (inActor.velocity.x * DeltaTime)
        set y = pos.y + (inActor.velocity.y * DeltaTime)
        set z = pos.z + (inActor.velocity.z * DeltaTime)
        call inActor.SetPositionXYZ(x, y, z)

        set size = inActor.velocity.Size()
        if size != 0 then
            set frictionMag = inActor.locFriction * (inActor.mass * -Gravity) * -1
            
            set x = (inActor.velocity.x / size) * frictionMag
            set y = (inActor.velocity.y / size) * frictionMag
            set z = (inActor.velocity.z / size) * frictionMag

            call inActor.physForce.Add(x, y, z)
        endif
        call PhysForce(Actors[Index])
    endfunction


    struct Room extends array
        implement GlobalAlloc

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
            local thistype this = FTick.GetTick()
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
                    call Actors[iter].physForce.Set(0.0, 0.0, 0.0)
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