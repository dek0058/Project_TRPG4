library ActorThread initializer Start uses MainThread, Actor, FMath

    globals
        private constant integer MaxLoop = 24
        
        private integer Index = 0
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


    private function Update takes nothing returns nothing
        local integer i = 0
        local integer end = -1

        loop
            exitwhen i == MaxLoop or end == Index
            set i = i + 1
            if Index >= Actor.AllocCount() then
                set Index = 0
            endif

            if end == -1 then
                set end = Index
            endif

            if Actors[Index].IsValid() then
                call PhysForce(Actors[Index])
                call PhysVelocity(Actors[Index])
                call Actors[Index].physForce.Set(0.0, 0.0, 0.0)
            endif

            set Index = Index + 1
            if Index >= Actor.AllocCount() then
                set Index = 0
            endif
        endloop
    endfunction

    private function Start takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerAddAction(trig, function Update)
        call TriggerRegisterTimerEvent(trig, DeltaTime, true)
        set trig = null
    endfunction
endlibrary