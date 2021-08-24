library PlayerController initializer Start uses Controller, AbilityInfo

    globals


    endglobals
    
    struct PlayerController extends array
        implement GlobalAlloc

        readonly Actor Chatacter

        readonly AbilityInfo rightSlotAbilityInfo
        readonly AbilityInfo leftSlotAbilityInfo
        
        readonly TArrayAbilityInfo AbilityInfoList

        static method create takes Controller inController returns thistype
            local thistype this = allocate()
            local integer i = 0            

            // set rightSlotAbilityInfo = AbilityInfo.create()
            // set leftSlotAbilityInfo = AbilityInfo.create()
            set AbilityInfoList = TArrayAbilityInfo.create()
            loop
                exitwhen i >= MaxSlot
                //call AbilityInfoList.Push(AbilityInfo.create())
                set i = i + 1
            endloop
            return this
        endmethod
    endstruct


    private function OnClickAction takes nothing returns boolean
        local string syncData = JNGetTriggerSyncData()
        local real x = Regex.GetX(syncData)
        local real y = Regex.GetY(syncData)
        local integer clickData = Regex.GetClickData(syncData)
        local Controller controller = Controller[JNGetTriggerSyncPlayer()]

        if clickData == SyncRightClickData then
            call MainPlayerActors[controller].OrderPoint(Order.smart, x, y)
        elseif clickData == SyncLeftClickData then
            call MainPlayerActors[controller].OrderPoint(Order.smart, x, y)
        endif

        return false
    endfunction


    private function Start takes nothing returns nothing
        local trigger trig

        set trig = CreateTrigger()
        call TriggerAddCondition(trig, function OnClickAction)
        call JNTriggerRegisterSyncData(trig, SyncClickEvent, false)

        set trig = null
    endfunction
endlibrary