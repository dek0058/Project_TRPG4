library PlayerController initializer Start uses AbilitySystem

    globals
        private PlayerController array playerController
    endglobals
    struct PlayerController extends array
        implement GlobalAlloc

        readonly Controller controller
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
            set controller = NULL
            set character = NULL

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
            set controller = inController
        endmethod

        private method Reset takes nothing returns nothing
            local integer i = 0
            set rightSlotAbilityInfo = GetAbilityInfo(ABILITY_EMPTY)
            set leftSlotAbilityInfo = GetAbilityInfo(ABILITY_EMPTY)
            loop
                exitwhen i >= AbilityInfoList.Size()
                set AbilityInfoList[i] = GetAbilityInfo(ABILITY_EMPTY)
                set i = i + 1
            endloop
        endmethod

        method operator RightClickInfo takes nothing returns AbilityInfo
            return rightSlotAbilityInfo
        endmethod

        method operator RightClickInfo= takes integer inAbilityId returns nothing
            if ExistCharacter() == false then
                return
            endif

            if HasActorAbility(inAbilityId, GetCharacter()) == false then
                return
            endif
            set rightSlotAbilityInfo = GetActorAbility(inAbilityId, GetCharacter())
        endmethod

        method operator LeftClickInfo takes nothing returns AbilityInfo
            return leftSlotAbilityInfo
        endmethod

        method operator LeftClickInfo= takes integer inAbilityId returns nothing
            if ExistCharacter() == false then
                return
            endif
            if HasActorAbility(inAbilityId, GetCharacter()) == false then
                return
            endif
            set leftSlotAbilityInfo = GetActorAbility(inAbilityId, GetCharacter())
        endmethod

        method GetAbilitySlot takes integer inIndex returns AbilityInfo
            if inIndex < 0 and inIndex >= AbilityMaxSlot then
                // TODO 에러
                return AbilityInfoList[0]
            endif
            return AbilityInfoList[inIndex]
        endmethod

        method SetAbilitySlot takes integer inIndex, AbilityInfo inAbilityId returns nothing
            if ExistCharacter() == false then
                return
            endif
            if HasActorAbility(inAbilityId, GetCharacter()) == false then
                return
            endif
            if inIndex < 0 and inIndex >= AbilityMaxSlot then
                // TODO 에러
                return
            endif
            set AbilityInfoList[inIndex] = GetActorAbility(inAbilityId, GetCharacter())
        endmethod

        method SetCharacter takes Actor inActor returns nothing
            if inActor != NULL and inActor.IsValid() == true then
                set character = inActor
                call Reset()
            endif
        endmethod

        method GetCharacter takes nothing returns Actor
            return character
        endmethod

        method ExistCharacter takes nothing returns boolean
            return (character != NULL) and (character.IsValid() == true)
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
        local PlayerController pController = PlayerController[JNGetTriggerSyncPlayer()]

        if clickData == SyncRightClickData then
            call pController.RightClickInfo.Evaluate(x, y, I2R(pController.GetCharacter().RecKey))
        elseif clickData == SyncLeftClickData then
            call pController.LeftClickInfo.Evaluate(x, y, I2R(pController.GetCharacter().RecKey))
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