library Actor uses Alloc, Controller, FVector

    globals
        private constant integer FLYING_ABILITY = 'Amrf'
    endglobals

    struct Actor extends array
        implement Alloc
        
        private unit gameUnit
        private Controller controller
        private FVector position

        static method create takes real inX, real inY, real inZ, real inFace, integer inId, player inPlayer returns thistype
            local thistype this = allocate()
            
            set gameUnit = CreateUnit(inPlayer, inId, inX, inY, inFace)
            set controller = Controller.Get(inPlayer)
            call controller.RegisterUnit(gameUnit)

            call position.Set(inX, inY, inZ)

            return this
        endmethod

        
        


    endstruct
endlibrary