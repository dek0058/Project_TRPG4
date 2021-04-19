library Actor uses Alloc, Controller, FVector

    //! runtextmacro DEFINE_STRUCT_TARRAY("Actor", "Actor")

    globals
        private constant integer FLYING_ABILITY = 'Amrf'
    endglobals

    struct Actor extends array
        implement Alloc
        
        private unit gameUnit
        private Controller controller

        // Unit Status
        private FVector position
        private real scale


        static method create takes real inX, real inY, real inZ, real inFace, integer inId, player inPlayer returns thistype
            local thistype this = allocate()
            
            set position = FVector.create(inX, inY, inZ)

            set gameUnit = CreateUnit(inPlayer, inId, position.x, position.y, inFace)
            call UnitAddAbility(gameUnit, FLYING_ABILITY)
            call UnitRemoveAbility(gameUnit, FLYING_ABILITY)
            call SetUnitFlyHeight(gameUnit, position.z, 0.00)

            set controller = Controller.Get(inPlayer)
            call controller.RegisterUnit(gameUnit)

            return this
        endmethod

        method destroy takes nothing returns nothing
            set controller = 0
            call position.destroy()
            call deallocate()
        endmethod

        method Value takes nothing returns unit
            return gameUnit
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




    endstruct
endlibrary