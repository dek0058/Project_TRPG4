library MainDefine initializer Start

    // @ Static Variable
    globals
        constant integer NULL = 0
        constant real DeltaTime = 0.04

        constant real MinHeight = 0.01
        constant real MaxHeight = 3000.00
        constant real WaterHeight = 38.4
        
        constant real MaxMoveSpeed = 522.00
    
        constant integer DefaultPlayerIndex = bj_MAX_PLAYER_SLOTS

        // @Memory
        private integer GameDll = NULL
    endglobals
    //

    // @ Setting Varaible
    globals
        constant integer MaxPlayerCount = 9

        real Gravity = -1087.9
    endglobals
    //

    // @ Global Array
    globals
        TArrayShotEvent ShotEventList
        TArrayShotEvent CreateUnitEventList
    endglobals

     // @ Dynamic Varaible
    globals
        integer CreateUnitId
        
        location DynamicLocation
        trigger DynamicTrigger
        group DynamicGroup

        private triggercondition PreviousAction = null

        // 로컬 플레이어 전용
        integer LocalPlayerIndex = 0
        integer SelectUnitRecKey = 0
    endglobals
    //

    // @로그
    function WriteLog takes string inType, string inParent, string inChild, string inValue returns nothing
        call JNWriteLog("[Shipping][" + inType + "][" + inParent + "][" + inChild +"]" + inValue)
    endfunction
    //! textmacro CreateLog takes STRUCT, VALUE
        debug call JNWriteLog("[Shipping]Create $STRUCT$ [" + I2S($VALUE$) + "]")
    //! endtextmacro
    //! textmacro RecyleLog takes STRUCT, VALUE
        debug call JNWriteLog("[Shipping]Recyle $STRUCT$ [" + I2S($VALUE$) + "]")
    //! endtextmacro
    //! textmacro DestroyLog takes STRUCT, VALUE
        debug call JNWriteLog("[Shipping]Destroy $STRUCT$ [" + I2S($VALUE$) + "]")
    //! endtextmacro
    //! textmacro MissingLog takes FUNCTION, TYPE
        debug call JNWriteLog("[Warning][$FUNCTION$]%TYPE% is missing value")
    //! endtextmacro
    //

    // @Pathable Functions
    function PathableWalking takes real inX, real inY returns boolean
        return not IsTerrainPathable(inX, inY, PATHING_TYPE_WALKABILITY)
    endfunction

    function PathableWater takes real inX, real inY returns boolean
        return not IsTerrainPathable(inX, inY, PATHING_TYPE_FLOATABILITY)
    endfunction

    function PathableNothing takes real inX, real inY returns boolean
        return IsTerrainPathable(inX, inY, PATHING_TYPE_WALKABILITY) and IsTerrainPathable(inX, inY, PATHING_TYPE_FLYABILITY)
    endfunction
    //

    // @Common Functions
    function OnCallback takes boolexpr inCallback returns nothing
        if PreviousAction == null then
            set PreviousAction = TriggerAddCondition(DynamicTrigger, inCallback)
        else
            call TriggerRemoveCondition(DynamicTrigger, PreviousAction)
            set PreviousAction = TriggerAddCondition(DynamicTrigger, inCallback)
        endif

        call TriggerEvaluate(DynamicTrigger)

        if PreviousAction != null then
            call TriggerRemoveCondition(DynamicTrigger, PreviousAction)
            set PreviousAction = null
        endif
    endfunction
    //

    // @Getter
    function GetFloor takes real inX, real inY returns real
        local real z = 0.00
        call MoveLocation(DynamicLocation, inX, inY)
        
        set z = (GetLocationZ(DynamicLocation) + MinHeight)
        if PathableWater(inX, inY) then
            set z = z - WaterHeight
        endif
        
        return z
    endfunction

    function GetGameDll takes nothing returns integer
        if GameDll == NULL then
            set GameDll = JNGetModuleHandle("Game.dll")
        endif
        return GameDll
    endfunction

    function GetLocalController takes nothing returns Controller
        return Controller.Get(LocalPlayerIndex)
    endfunction

    function IsSingleMode takes nothing returns boolean
        return ReloadGameCachesFromDisk() == true
    endfunction

    function IsBattleNetMode takes nothing returns boolean
        return JNUse()
    endfunction
    //

    private function Start takes nothing returns nothing
        set DynamicLocation = Location(0, 0)
        set DynamicTrigger = CreateTrigger()
        set DynamicGroup = CreateGroup()

        set ShotEventList = TArrayShotEvent.create()
        set CreateUnitEventList = TArrayShotEvent.create()
    endfunction
endlibrary