library Actor uses Alloc, Controller

    struct Actor extends array
        implement Alloc
        
        private unit gameUnit
        
        static method create takes real inX, real inY, real inFace, integer inId, Controller inController returns thistype
            local thistype this = allocate()
            
            //set gameUnit = CreateUnit(inController, inId, inX, inY, inFace)

            return this
        endmethod

    endstruct

endlibrary