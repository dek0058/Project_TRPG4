library Controller initializer Start uses UnitGroup, ErrorMessage
    
    globals
        private Controller array controller

        // Vision
        constant integer VISION_MASTER =  2147483647
    endglobals
    
    struct Controller extends array
        implement GlobalAlloc

        private player gamePlayer
        private UnitGroup unitGroup
        private UnitGroup selectGroup

        private string id
        //private string nickname

        // @State
        readonly boolean isLeftClick
        readonly boolean isRightClick
        

        // fogmodifier 
        private fogmodifier MasterVision
        

        static method operator [] takes player inPlayer returns thistype
            local integer id = GetPlayerId(inPlayer)
            if id >= 0 and id <= DefaultPlayerIndex then
                return controller[id]
            endif
            debug call ThrowError(true, "Controller", "[]", "Controller", controller[id], "Player Id(" + I2S(id) + ")가 잘못되었습니다.")
            return -1
        endmethod

        static method Get takes integer inIndex returns thistype
            if inIndex >= 0 and inIndex <= DefaultPlayerIndex then
                return controller[inIndex]
            endif
            debug call ThrowError(true, "Controller", "Get", "Controller", controller[inIndex], "Player Id(" + I2S(inIndex) + ")가 잘못되었습니다.")
            return -1
        endmethod

        static method create takes integer inIndex returns thistype
            local thistype this = allocate()

            set gamePlayer = Player(inIndex)
            set unitGroup = UnitGroup.create()
            set selectGroup = UnitGroup.create()

            // Vision
            set MasterVision = null

            // 플레이어마다 인덱스 번호가 다름
            if IsLocalPlayer() == true then
                set LocalPlayerIndex = inIndex
            endif

            if IsPlayerPlaying() == true then

            endif

            return this
        endmethod

        method Value takes nothing returns player
            return gamePlayer
        endmethod

        // @Player State
        method IsLocalPlayer takes nothing returns boolean
            return GetLocalPlayer() == gamePlayer
        endmethod
        
        method IsPlayerPlaying takes nothing returns boolean
            return GetPlayerController(gamePlayer) == MAP_CONTROL_USER and GetPlayerSlotState(gamePlayer) == PLAYER_SLOT_STATE_PLAYING
        endmethod

        method IsComputer takes nothing returns boolean
            return GetPlayerController(gamePlayer) != MAP_CONTROL_USER 
        endmethod

        method IsPlayerLeft takes nothing returns boolean
            return GetPlayerSlotState(gamePlayer) == PLAYER_SLOT_STATE_LEFT
        endmethod

        method SetClickState takes boolean inRightClick, boolean inValue returns nothing
            if inRightClick == true then
                set isRightClick = inValue
            else
                set isLeftClick = inValue
            endif
        endmethod
        //

        method GetUnitGroup takes nothing returns UnitGroup
            return unitGroup
        endmethod

        method GetSelectedUnitGroup takes nothing returns UnitGroup
            return selectGroup
        endmethod

        method RegisterUnit takes unit inUnit returns nothing
            call unitGroup.Add(inUnit)
        endmethod

        method UnregisterUnit takes unit inUnit returns nothing
            call unitGroup.Remove(inUnit)
        endmethod

        method ExecuteUnitGroup takes code inCallback returns nothing
            call unitGroup.Execute(inCallback)
        endmethod
        
        method UpdateSelectedUnitGroup takes nothing returns nothing
            call selectGroup.UpdateSelectedUnit(gamePlayer)
        endmethod
    
        method SetVision takes integer inType, boolean inShow returns nothing
            local fogmodifier target = null

            if inType == VISION_MASTER then
                if MasterVision == null then
                    set MasterVision = CreateFogModifierRect(gamePlayer, FOG_OF_WAR_VISIBLE, bj_mapInitialPlayableArea, false, false)
                endif
                set target = MasterVision
            else
                // runtextmacro MissingLog("SetVision", "inType")
            endif

            if target == null then
                // runtextmacro MissingLog("SetVision", "target")
                return
            endif

            if inShow == true then
                call FogModifierStart(target)
            else
                call FogModifierStop(target)
            endif

            set target = null
        endmethod

        // JN
        // @Chat 플레이어 채팅 이벤트를 발생시킵니다.
        method SendChat takes integer inRecipient, string inMsg returns nothing
            call JNDisplayChatMessage(gamePlayer, inRecipient, inMsg)
        endmethod
        method SendChatAll takes string inMsg returns nothing
            call SendChat(CHAT_RECIPIENT_ALL, inMsg)
        endmethod
        method SendChatAllies takes string inMsg returns nothing
            call SendChat(CHAT_RECIPIENT_ALLIES, inMsg)
        endmethod
        method SendChatObservers takes string inMsg returns nothing
            call SendChat(CHAT_RECIPIENT_OBSERVERS, inMsg)
        endmethod
        method SendChatPrivate takes string inMsg returns nothing
            call SendChat(CHAT_RECIPIENT_PRIVATE, inMsg)
        endmethod

        method IsDoingChat takes nothing returns boolean
            return JNMemoryGetByte(GetGameDll() + 0xD04FEC) == 1
        endmethod
        //

    endstruct

    private function SelectedAction takes nothing returns boolean
        if Controller.Get(LocalPlayerIndex).IsLocalPlayer() == true then
            set SelectUnitRecKey = Actor[GetFilterUnit()].RecKey
            call ClearSelection()
        endif
        return false
    endfunction

    private function LeftClickAction takes nothing returns boolean
        local Controller gameController = Controller[DzGetTriggerKeyPlayer()]
        // if gameController.IsLocalPlayer() == true then
        //     call OnLeftClick.evaluate()
        // endif
        call gameController.SetClickState(false, true)
        return false
    endfunction

    private function LeftClickReleaseAction takes nothing returns boolean
        local Controller gameController = Controller[DzGetTriggerKeyPlayer()]
        call gameController.SetClickState(false, false)
        return false
    endfunction

    private function RightClickAction takes nothing returns boolean
        local Controller gameController = Controller[DzGetTriggerKeyPlayer()]
        call gameController.SetClickState(true, true)
        // if gameController.IsLocalPlayer() == true then
        //     call OnRightClick.evaluate()
        // endif
        return false
    endfunction

    private function RightClickReleaseAction takes nothing returns boolean
        local Controller gameController = Controller[DzGetTriggerKeyPlayer()]
        call gameController.SetClickState(true, false)
        return false
    endfunction

    private function Start takes nothing returns nothing
        local trigger trig
        local integer i = 0

        loop
            exitwhen i > DefaultPlayerIndex
            set controller[i] = Controller.create(i)
            if controller[i].IsPlayerPlaying() == true then
                set trig = CreateTrigger()
                call TriggerRegisterPlayerUnitEvent(trig, Player(i), EVENT_PLAYER_UNIT_SELECTED, Filter(function SelectedAction))
            endif
            set i = i + 1
        endloop

        set trig = CreateTrigger()
        call TriggerAddCondition(trig, function LeftClickAction)
        call DzTriggerRegisterMouseEventByCode(trig, JN_OSKEY_LBUTTON, 1, true, null)

        set trig = CreateTrigger()
        call TriggerAddCondition(trig, function LeftClickReleaseAction)
        call DzTriggerRegisterMouseEventByCode(trig, JN_OSKEY_LBUTTON, 0, true, null)
        
        set trig = CreateTrigger()
        call TriggerAddCondition(trig, function RightClickAction)
        call DzTriggerRegisterMouseEventByCode(trig, JN_OSKEY_RBUTTON, 1, true, null)

        set trig = CreateTrigger()
        call TriggerAddCondition(trig, function RightClickReleaseAction)
        call DzTriggerRegisterMouseEventByCode(trig, JN_OSKEY_RBUTTON, 0, true, null)

        set trig = null
    endfunction
endlibrary