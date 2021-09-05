library AbilitySystem initializer Start uses Table, Alloc, FTick

    globals
        private Table AbilityMap
        private HashTable ActorAbilityMap

        private AbilityInfo LastAbilityInfo = NULL
        private FVector LastAbilityPosition
    endglobals

    //! runtextmacro DEFINE_STRUCT_TARRAY("AbilityInfo", "AbilityInfo")

    function GetLastAbilityInfo takes nothing returns AbilityInfo
        return LastAbilityInfo
    endfunction

    function GetAbilityPosition takes nothing returns FVector
        return LastAbilityPosition
    endfunction

    function AddAbilityInfo takes AbilityInfo inAbilityInfo returns nothing
        set AbilityMap.integer[inAbilityInfo.ID] = inAbilityInfo
    endfunction

    function GetAbilityInfo takes integer inId returns AbilityInfo
        local AbilityInfo abilityInfo = NULL
        if AbilityMap.integer.has(inId) == false then
            debug call WriteLog("TRPG4", "AbilitySystem", "GetAbilityInfo",  "저장된 스킬 정보가 없습니다.(" + I2S(inId) + ")")
            return abilityInfo
        else
            set abilityInfo = AbilityMap.integer[inId]
            return abilityInfo
        endif
    endfunction

    function ActorAddAbility takes integer inId, Actor inActor returns nothing
        local AbilityInfo abilityInfo
        
        if ActorAbilityMap[inActor.RecKey].integer.has(inId) == true then
            debug call WriteLog("TRPG4", "AbilitySystem", "ActorAddAbility",  "스킬 정보가 이미 있습니다.(" + I2S(inId) + ")")
        else
            set abilityInfo = AbilityInfo[inId]
            if abilityInfo != NULL and abilityInfo.Type != ABILITY_TYPE_DEFAULT then
                set ActorAbilityMap[inActor.RecKey].integer[inId] = abilityInfo
            endif
        endif
    endfunction

    function GetActorAbility takes integer inId, Actor inActor returns AbilityInfo
        local AbilityInfo abilityInfo = GetAbilityInfo(inId)
        if abilityInfo != NULL and abilityInfo.Type == ABILITY_TYPE_DEFAULT then
            return abilityInfo
        else
            set abilityInfo = NULL
        endif

        if ActorAbilityMap[inActor.RecKey].integer.has(inId) == true then
            set abilityInfo = ActorAbilityMap[inActor.RecKey].integer[inId]
        endif
        return abilityInfo
    endfunction

    function RemoveActorAbility takes integer inId, Actor inActor returns nothing
        if ActorAbilityMap[inActor.RecKey].integer.has(inId) == true then
            call ActorAbilityMap[inActor.RecKey].remove(inId)
        endif
    endfunction

    function ClearActorAbility takes Actor inActor returns nothing
        call ActorAbilityMap[inActor.RecKey].flush()
    endfunction
    
    function HasActorAbility takes integer inId, Actor inActor returns boolean
        local AbilityInfo abilityInfo = GetAbilityInfo(inId)
        if abilityInfo != NULL and abilityInfo.Type == ABILITY_TYPE_DEFAULT then
            return true
        endif
        return ActorAbilityMap[inActor.RecKey].integer.has(inId)
    endfunction

    // TODO 유닛이 삭제될 경우 맵에서 어빌리티 삭제 필요함

    struct AbilityInfo extends array
        implement Alloc

        private integer id
        private integer type

        // Status
        private integer level
        private real cooltime
        private FTick tick

        // Interface
        readonly string name
        readonly string icon

        // callback
        private trigger trig
        private triggercondition trigCondition
        private boolexpr callback

        private static method OnTimer takes nothing returns nothing
            local FTick expiredTick = FTick.GetTick()
            local thistype this = expiredTick.pointer
            call SetCoolTime(0.0)
        endmethod

        static method create takes integer inId, integer inType, integer inLevel, real inCooltime, string inName, string inIcon returns thistype
            local thistype this = allocate()
            set id = inId
            set type = inType
            
            // Status
            set level = inLevel
            set cooltime = inCooltime
            set tick = FTick.create(this, cooltime)

            //Interface
            set name = inName
            set icon = inIcon

            //callback
            set callback = null

            //! runtextmacro CreateLog("AbilityInfo", "this")
            return this
        endmethod

        static method operator [] takes integer inId returns thistype
            local thistype this = NULL
            local thistype copyObject = GetAbilityInfo(inId)
            if copyObject == NULL then
                // 없음..
            elseif copyObject.type == ABILITY_TYPE_DEFAULT then
                set this = copyObject
            else
                set this = create(copyObject.ID, copyObject.Type, copyObject.Level, copyObject.CoolTime, copyObject.name, copyObject.icon)
                call RegisterEvent(copyObject.callback)
            endif
            return this
        endmethod

        method operator ID takes nothing returns integer
            return id
        endmethod

        method operator Type takes nothing returns integer
            return type
        endmethod

        method operator Level= takes integer inValue returns nothing
            set level = inValue
        endmethod

        method operator Level takes nothing returns integer
            return level
        endmethod

        method operator CoolTime= takes real inValue returns nothing
            if inValue < 0.0 then
                set inValue = 0.0
            endif
            set tick.deltaTime = inValue
            set cooltime = inValue
        endmethod

        method operator CoolTime takes nothing returns real
            return cooltime
        endmethod
        
        method SetCoolTime takes real inValue returns nothing
            if inValue < 0.0 then
                set inValue = 0.0
            endif
            call tick.RunUniqueTime(inValue, false, function thistype.OnTimer)
        endmethod

        method GetCoolTime takes nothing returns real
            return tick.GetRemaining()
        endmethod

        method ReduceCoolTime takes real inPercent returns nothing
            local real value = CoolTime * inPercent
            set value = GetCoolTime() - value
            if value <= 0.0 then
                set value = 0.0
            endif
            call SetCoolTime(value)
        endmethod

        method RegisterEvent takes boolexpr inCallback returns nothing
            set callback = inCallback
            set trig = CreateTrigger()
            set trigCondition = TriggerAddCondition(trig, callback)
        endmethod

        method Evaluate takes real inX, real inY, real inZ returns boolean
            local boolean result = false
            if callback == null then
                return result
            endif
            
            if GetCoolTime() > 0 then
                return result
            endif

            set LastAbilityInfo = this
            call LastAbilityPosition.Set(inX, inY, inZ)
            set result = TriggerEvaluate(trig)

            if CoolTime > 0.0 then
                call tick.Run(false, function thistype.OnTimer)
            endif

            return result
        endmethod

        method destroy takes nothing returns nothing
            //! runtextmacro DestroyLog("AbilityInfo", "this")
            set id = 0
            set type = 0

            set level = 0
            set cooltime = 0.0
            call tick.destroy()

            set name = null
            set icon = null

            if callback != null then
                call TriggerRemoveCondition(trig, trigCondition)
                set trigCondition = null
                call DestroyTrigger(trig)
                set trig = null
                set callback = null
            endif

            call deallocate()
        endmethod
    endstruct

    private function Start takes nothing returns nothing
        local integer id = ABILITY_EMPTY
        local integer abilityType = ABILITY_TYPE_DEFAULT
        local real cooltime = 0.0
        local string name = "빈 슬롯"
        local string icon = ABILITY_ICON_NONE
        local AbilityInfo emptyAbility = AbilityInfo.create(ABILITY_EMPTY, abilityType, 0, cooltime, name, icon)

        set AbilityMap = Table.create()
        set ActorAbilityMap = HashTable.create()
        set LastAbilityPosition = FVector.create(0.0, 0.0, 0.0)

        call AddAbilityInfo(emptyAbility)
    endfunction
endlibrary