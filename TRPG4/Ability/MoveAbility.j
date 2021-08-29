library MoveAbility initializer Start uses AbilitySystem


    /*
        method OnConditionRightClick takes nothing returns nothing
            local real x = JNGetTriggerPlayerMouseX()
            local real y = JNGetTriggerPlayerMouseY()
            local string packet = ""

            set packet = packet + Regex.SetX(x)
            set packet = packet + Regex.SetY(y)
            set packet = packet+ Regex.SetClickData(SyncRightClickData)

            call JNSendSyncData(SyncClickEvent, packet)
        endmethod

        method OnConditionLeftClick takes nothing returns nothing
            local real x = JNGetTriggerPlayerMouseX()
            local real y = JNGetTriggerPlayerMouseY()
            local string packet = ""

            set packet = packet + Regex.SetX(x)
            set packet = packet + Regex.SetY(y)
            set packet = packet + Regex.SetClickData(SyncLeftClickData)

            call JNSendSyncData(SyncClickEvent, packet)
        endmethod
    */

    private function Start takes nothing returns nothing
        //local AbilityInfo moveAbility = AbilityInfo.create()
        
        //call AddAbilityInfo(moveAbility)
    endfunction
endlibrary