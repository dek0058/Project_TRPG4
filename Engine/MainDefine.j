library MainDefine initializer Start

    globals
        constant real DeltaTime = 0.04

        constant real MinHeight = 0.01
        constant real MaxHeight = 3000.00
        constant real WaterHeight = 38.4
        
        constant real MaxMoveSpeed = 522.00

        real Gravity = -1087.9

        
        // Dynamic Variable
        location DynamicLocation
    endglobals

    // @로그
    //! textmacro CreateLog takes STRUCT, VALUE
        debug call JNWriteLog("Create $STRUCT$ [" + I2S($VALUE$) + "]")
    //! endtextmacro
    //! textmacro RecyleLog takes STRUCT, VALUE
        debug call JNWriteLog("Recyle $STRUCT$ [" + I2S($VALUE$) + "]")
    //! endtextmacro
    //! textmacro DestroyLog takes STRUCT, VALUE
        debug call JNWriteLog("Destroy $STRUCT$ [" + I2S($VALUE$) + "]")
    //! endtextmacro
    //@

    // @Pathable Functions
    function PathableWalking takes real inX, real inY returns boolean
        return not IsTerrainPathable(inX, inY, PATHING_TYPE_WALKABILITY)
    endfunction

    function PathableWater takes real inX, real inY returns boolean
        return not IsTerrainPathable(inX, inY, PATHING_TYPE_FLOATABILITY)
    endfunction

    function PathableNothing takes real inX, real inY returns boolean
        return IsTerrainPathable(inX, inY, PATHING_TYPE_WALKABILITY) and IsTerrainPathable(inX, inY, PATHING_TYPE_FLYABILITY)
    endfunction
    //

    // @Getter
    function GetFloor takes real inX, real inY returns real
        local real z = 0.00
        call MoveLocation(DynamicLocation, inX, inY)
        
        set z = (GetLocationZ(DynamicLocation) + MinHeight)
        if PathableWater(inX, inY) then
            set z = z - WaterHeight
        endif
        
        return z
    endfunction
    //

    private function Start takes nothing returns nothing
        
        set DynamicLocation = Location(0, 0)

    endfunction

endlibrary