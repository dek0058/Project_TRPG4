library AbilitySystem initializer Start uses Table, Alloc

    globals
        private boolean AbilityMapInitialize = false
        private Table AbilityMap

        private boolean ActorAbilityMapInitialize = false
        private HashTable ActorAbilityMap

        private constant string EmptyAbilityName = "빈 슬롯"
        private constant string EmptyAbilityIcon = "빈 슬롯"
    endglobals

    globals
        // ABILITY TYPE
        constant integer ABILITY_TYPE_EMPTY = 0
        constant integer ABILITY_TYPE_ACTIVE = 1
        constant integer ABILITY_TYPE_PASSIVE = 2

    endglobals

    //! runtextmacro DEFINE_STRUCT_TARRAY("AbilityInfo", "AbilityInfo")

    struct AbilityInfo extends array
        implement Alloc

        private integer id
        private integer type

        // Status
        private integer level
        private real cooltime

        // Dynamic
        real currentCoolTime

        // Interface
        readonly string name
        readonly string icon

        // callback
        private trigger trig
        private triggercondition trigCondition
        private boolexpr callback

        static method create takes integer inId, integer inType, integer inLevel, real inCooltime, string inName, string inIcon returns thistype
            local thistype this = allocate()
            set id = inId
            set type = inType
            set level = inLevel
            
            // Status
            set cooltime = inCooltime
            
            // Dynamic
            set currentCoolTime = 0.0

            //Interface
            set name = inName
            set icon = inIcon

            //callback
            set callback = null

            //! runtextmacro CreateLog("AbilityInfo", "this")
            return this
        endmethod

        static method operator [] takes integer inId returns thistype
            local thistype this = 0
            local thistype copyObject
            if AbilityMap.integer.has(inId) == false then
                debug call WriteLog("TRPG4", "AbilitySystem", "[]",  "저장된 스킬 정보가 없습니다.(" + I2S(inId) + ")")
                return 0
            else
                set copyObject = AbilityMap.integer[inId]
                return create(copyObject.ID, copyObject.Type, copyObject.Level, copyObject.CoolTime, copyObject.name, copyObject.icon)
            endif
        endmethod

        method operator ID takes nothing returns integer
            return id
        endmethod

        method operator Type takes nothing returns integer
            return type
        endmethod

        method operator Level takes nothing returns integer
            return level
        endmethod

        method operator CoolTime takes nothing returns real
            return cooltime
        endmethod

        method RegisterEvent takes boolexpr inCallback returns nothing
            set callback = inCallback
            set trig = CreateTrigger()
            set trigCondition = TriggerAddCondition(trig, callback)
        endmethod

        method Evaluate takes nothing returns boolean
            local boolean result = false
            if callback == null then
                return result
            endif
            
            if currentCoolTime > 0 then
                return result
            endif

            set result = TriggerEvaluate(trig)

            if CoolTime > 0.0 then
                // TODO 쿨타임 Tick 돌리기
            endif

            return result
        endmethod

        method destroy takes nothing returns nothing
            //! runtextmacro DestroyLog("AbilityInfo", "this")
            set id = 0
            set type = 0
            set level = 0
            set cooltime = 0.0

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
    
    function AddAbilityInfo takes AbilityInfo inAbilityInfo returns nothing
        if AbilityMapInitialize == false then
            set AbilityMapInitialize = true
            set AbilityMap = Table.create()
        endif
        set AbilityMap.integer[inAbilityInfo.ID] = inAbilityInfo
    endfunction

    function GetAbilityInfo takes integer inId returns AbilityInfo
        local AbilityInfo abilityInfo = 0
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
        if ActorAbilityMapInitialize == false then
            set ActorAbilityMapInitialize = true
            set ActorAbilityMap = HashTable.create()
        endif
        if ActorAbilityMap[inActor].integer.has(inId) == true then
            debug call WriteLog("TRPG4", "AbilitySystem", "ActorAddAbility",  "스킬 정보가 이미 있습니다.(" + I2S(inId) + ")")
        else
            set abilityInfo = AbilityInfo[inId]
            if abilityInfo != 0 then
                set ActorAbilityMap[inActor].integer[inId] = abilityInfo
            endif
        endif
    endfunction

    function GetActorAbility takes integer inId, Actor inActor returns AbilityInfo
        local AbilityInfo abilityInfo = 0
        if ActorAbilityMap[inActor].integer.has(inId) == true then
            set abilityInfo = ActorAbilityMap[inActor].integer[inId]
        endif
        return abilityInfo
    endfunction

    function HasActorAbility takes integer inId, Actor inActor returns boolean
        return ActorAbilityMap[inActor].integer.has(inId)
    endfunction

    private function Start takes nothing returns nothing
        local AbilityInfo emptyAbility = AbilityInfo.create(ABILITY_EMPTY, ABILITY_TYPE_EMPTY, 0, 0.0, EmptyAbilityName, EmptyAbilityIcon)
        call AddAbilityInfo(emptyAbility)
    endfunction
endlibrary