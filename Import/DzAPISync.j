library DzAPISync
    native DzTriggerRegisterSyncData takes trigger trig, string prefix, boolean server returns nothing
    native DzSyncData takes string prefix, string data returns nothing
    native DzGetTriggerSyncData takes nothing returns string
    native DzGetTriggerSyncPlayer takes nothing returns player

    // prefix length maximum is 9
    function JNTriggerRegisterSyncData takes trigger whichTrigger, string prefix, boolean fromServer returns nothing
        call DzTriggerRegisterSyncData(whichTrigger, prefix, fromServer)
    endfunction

    // prefix length maximum is 9, data length maximum is 998
    function JNSendSyncData takes string prefix, string data returns nothing
        call DzSyncData(prefix, data)
    endfunction

    function JNGetTriggerSyncData takes nothing returns string
        return DzGetTriggerSyncData()
    endfunction

    function JNGetTriggerSyncPlayer takes nothing returns player
        return DzGetTriggerSyncPlayer()
    endfunction
endlibrary