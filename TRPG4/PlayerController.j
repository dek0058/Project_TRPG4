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
            if id >= 0 and id <= bj_MAX_PLAYER_SLOTS then
                return playerController[id]
            endif
            debug call ThrowError(true, "PlayerController", "[]", "PlayerController", playerController[id], "Player Id(" + I2S(id) + ")가 잘못되었습니다.")
            return -1
        endmethod

        static method Get takes integer inIndex returns thistype
            if inIndex >= 0 and inIndex <= bj_MAX_PLAYER_SLOTS then
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
            set rightSlotAbilityInfo = GetAbilityInfo(ABILITY_EMPTY)
           
            set AbilityInfoList = TArrayAbilityInfo.create()
            loop
                exitwhen i >= MaxSlot
                call AbilityInfoList.Push(GetAbilityInfo(ABILITY_EMPTY))
                set i = i + 1
            endloop
            return this
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
            exitwhen i > bj_MAX_PLAYER_SLOTS
            set playerController[i] = PlayerController.create()
            set i = i + 1
        endloop

        set trig = CreateTrigger()
        call TriggerAddCondition(trig, function OnClickAction)
        call JNTriggerRegisterSyncData(trig, SyncClickEvent, false)

        set trig = null
    endfunction
endlibrary