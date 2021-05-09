library MainDefine initializer Start

    globals
        constant real DeltaTime = 0.01

        constant real MinHeight = 0.01
        real Gravity = -1087.9
    endglobals

    function NearToFloor takes real inFlying returns boolean
        return inFlying <= MinHeight
    endfunction


    private function Start takes nothing returns nothing
        
    endfunction

endlibrary