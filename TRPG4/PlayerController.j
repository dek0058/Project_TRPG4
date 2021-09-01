library PlayerController initializer Start uses Controller, AbilitySystem

    globals
        private PlayerController array playerController
    endglobals
    struct PlayerController extends array
        implement GlobalAlloc

        private Controller controller
        private Actor character

        private AbilityInfo rightSlotAbilityInfo
        private AbilityInfo leftSlotAbilityInfo
        
        private TArrayAbilityInfo AbilityInfoList

        static method operator [] takes player inPlayer returns thistype
            local integer id = GetPlayerId(inPlayer)
            if id >= 0 and id <= PlayerMaxSlot then
                return playerController[id]
            endif
            debug call ThrowError(true, "PlayerController", "[]", "PlayerController", playerController[id], "Player Id(" + I2S(id) + ")가 잘못되었습니다.")
            return -1
        endmethod

        static method Get takes integer inIndex returns thistype
            if inIndex >= 0 and inIndex <= PlayerMaxSlot then
                return playerController[inIndex]
            endif
            debug call ThrowError(true, "PlayerController", "Get", "PlayerController", playerController[inIndex], "Player Id(" + I2S(inIndex) + ")가 잘못되었습니다.")
            return -1
        endmethod

        static method create takes nothing returns thistype
            local thistype this = allocate()
            local integer i = 0            

            //! runtextmacro CreateLog("PlayerController", "this")
            set rightSlotAbilityInfo = GetAbilityInfo(ABILITY_EMPTY)
            set leftSlotAbilityInfo = GetAbilityInfo(ABILITY_EMPTY)
           
            set AbilityInfoList = TArrayAbilityInfo.create()
            loop
                exitwhen i >= AbilityMaxSlot
                call AbilityInfoList.Push(GetAbilityInfo(ABILITY_EMPTY))
                set i = i + 1
            endloop
            return this
        endmethod

        method OnInitialize takes Controller inController returns nothing
            if inController == -1 then
                debug call ThrowError(true, "PlayerController", "OnInitialize", "PlayerController", this, "Controller가 없습니다.")
                return
            endif
            set controller= inController
        endmethod

        method operator RightClickInfo takes nothing returns AbilityInfo
            return rightSlotAbilityInfo
        endmethod

        method operator LeftClickInfo takes nothing returns AbilityInfo
            return leftSlotAbilityInfo
        endmethod

        method GetSlot takes integer inIndex returns AbilityInfo
            return AbilityInfoList[inIndex]
        endmethod

    endstruct
    
    function InitPlayerController takes nothing returns nothing
        local integer i = 0
        loop
            exitwhen i >= PlayerMaxSlot
            call PlayerController.Get(i).OnInitialize(Controller.Get(i))
            set i = i + 1
        endloop
    endfunction

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
        local integer i = 0

        loop
            exitwhen i > PlayerMaxSlot
            set playerController[i] = PlayerController.create()
            set i = i + 1
        endloop

        set trig = CreateTrigger()
        call TriggerAddCondition(trig, function OnClickAction)
        call JNTriggerRegisterSyncData(trig, SyncClickEvent, false)

        set trig = null
    endfunction
endlibrary