library Actor uses Alloc, Controller

    struct Actor extends array
        implement Alloc
        
        private unit gameUnit
        private Controller controller

        static method create takes real inX, real inY, real inFace, integer inId, player inPlayer returns thistype
            local thistype this = allocate()
            
            set gameUnit = CreateUnit(inPlayer, inId, inX, inY, inFace)
            set controller = Controller.Get(inPlayer)
            call controller.RegisterUnit(gameUnit)
            
            return this
        endmethod

        
        


    endstruct
endlibrary