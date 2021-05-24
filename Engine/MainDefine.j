library MainDefine initializer Start

    globals
        constant real DeltaTime = 0.04

        constant real MinHeight = 0.01
        constant real WaterHeight = 38.4
        
        real Gravity = -1087.9

        
        // Dynamic Variable
        location DynamicLocation
    endglobals

    
    function GetFloor takes real inX, real inY returns real
        call MoveLocation(DynamicLocation, inX, inY)
        return GetLocationZ(DynamicLocation) + MinHeight
    endfunction

    function IsPathable takes real inX, real inY, pathingtype inType returns boolean
        return IsTerrainPathable(inX, inY, inType)
    endfunction


    private function Start takes nothing returns nothing
        
        set DynamicLocation = Location(0, 0)

    endfunction

endlibrary