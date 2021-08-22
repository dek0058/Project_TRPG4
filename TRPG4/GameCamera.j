library GameCamera


    function SetFixedCamera takes boolean inValue returns nothing
        //if GetLocalController().IsLocalPlayer() == true then
        set FixedCamera = inValue
        //endif
    endfunction

    function SetTargetUnit takes Controller inController, Actor inActor returns nothing
    endfunction


endlibrary