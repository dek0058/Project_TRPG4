//=====================================================================
/*
    MUI 유닛인덱서 3.0.0.3
    
    지원하는 함수
    
        local integer 유닛번호 = IndexUnit( 유닛 )
            ＋해당 유닛의 고유 번호를 가져옵니다. 고유 번호가 없다면, 설정합니다.
            －만약 0이 반환되었다면, null 또는 이미 제거된 유닛을 넣어서 그렇습니다. 
            
        local integer 유닛번호 = GetUnitIndex( 유닛 )
            ＋해당 유닛의 고유 번호를 가져옵니다. 고유 번호가 없다면, 0이 반환됩니다.
            －만약 0이 반환되었다면, null 또는 이미 제거된 유닛이거나. 인덱싱 하지 않은 유닛입니다. 
        
        if IsUnitIndexed( 유닛 ) then
            ＋해당 유닛이 고유 번호를 가지고 있는지/없는지의 여부를 true/false로 반환합니다.
            －false가 반환되는 경우는. null 또는 이미 제거된 유닛이거나, 인덱싱 하지 않은 유닛입니다. 
        
        local real 점유율 = GetIndexRate()
            ＋시스템 최대 수용량인 8191에 대한 인덱싱된 유닛의 점유율을 %로 구해줍니다.
            
        local trigger 트리거 = GetUnitRemoveTrigger(유닛)
            ＋인덱싱된 유닛에 대한 '유닛 제거됨' 이벤트에 대응되는 트리거 핸들을 빌려옵니다.
            －만약 null이 반환되었다면. null 또는 이미 제거되었거나, 인덱싱 하지 않은 유닛입니다. 
        
        local integer 유닛번호 = GetTriggerIndex()
            ＋GetUnitRemoveTrigger()의 유닛 제거 이벤트에 대응하는, 제거된 유닛의 고유번호입니다.
            －주의! GetUnitRemoveTrigger() 액션을 제외한 다른 이벤트의 액션에서는 0으로 작동합니다
*/
//=====================================================================
library UnitIndexer initializer main
    globals
        private hashtable H = InitHashtable()
        private integer M = 0
        private integer array S
        private integer array I
        private unit array U
        private integer Z = 0
    endglobals
    //=========================================
    //  +a. 성능 평가
    //=========================================
    globals
        private integer C = 0
    endglobals
    function GetIndexRate takes nothing returns real
        return C / 8191.00
    endfunction
    //=========================================
    //  디인덱스 이벤트
    //=========================================
    globals
        private integer V = 0
        private trigger array E
    endglobals
    function GetTriggerIndex takes nothing returns integer
        return V
    endfunction
    function GetUnitRemoveTrigger takes unit u returns trigger
        return E[LoadInteger(H,0,GetHandleId(u))]
    endfunction
    //=========================================
    //  1/3. 디인덱서
    //=========================================
    private function Deindex takes integer id returns nothing
        local integer pi = V
        set V = id
        call TriggerExecute(E[id])
        set V = pi
        call DestroyTrigger(E[id])
        call RemoveSavedInteger(H,0,I[id])
        set E[id] = null
        set U[id] = null
        set I[id] = 0
        set S[Z] = id
        set Z = Z + 1
        set C = C - 1
    endfunction
    //=========================================
    //  2/3. MUI화된 인덱서 리프레셔
    //=========================================
        globals
            private real array R
            private timer array T
            private trigger array T1
            private triggeraction array T1A
        endglobals
        private function DRef takes integer id returns nothing
            call RemoveSavedInteger(H,0,GetHandleId(T[id]))
            call RemoveSavedInteger(H,0,GetHandleId(T1[id]))
            call DestroyTimer(T[id])
            set T[id] = null
            call TriggerRemoveAction(T1[id],T1A[id])
            set T1A[id] = null
            call DestroyTrigger(T1[id])
            set T1[id] = null
        endfunction
        private function ORem takes nothing returns nothing
            local integer id = LoadInteger(H,0,GetHandleId(GetExpiredTimer()))
            if GetUnitTypeId(U[id]) != 0 then
                if IsUnitType(U[id],UNIT_TYPE_DEAD) then
                    set R[id] = R[id] + 1.00
                    call TimerStart(T[id],R[id],false,function ORem)
                    return
                endif
                return
            endif
            call DRef(id)
            call Deindex(id)
        endfunction
        private function ODea takes nothing returns nothing
            local integer id = LoadInteger(H,0,GetHandleId(GetTriggeringTrigger()))
            set R[id] = 1.00
            call TimerStart(T[id],R[id],false,function ORem)
        endfunction
        private function ARef takes unit u, integer id returns nothing
            set T[id] = CreateTimer()
            call SaveInteger(H,0,GetHandleId(T[id]),id)
            set T1[id] = CreateTrigger()
            set T1A[id] = TriggerAddAction(T1[id], function ODea)
            call SaveInteger(H,0,GetHandleId(T1[id]),id)
            call TriggerRegisterUnitEvent(T1[id],u,EVENT_UNIT_DEATH)
            if IsUnitType(u,UNIT_TYPE_DEAD) then
                set R[id] = 1.00
                call TimerStart(T[id],R[id],false,function ORem)
            endif
        endfunction
    //=========================================
    //  3/3. 인덱서
    //=========================================
    function GetUnitIndex takes unit u returns integer
        return LoadInteger(H,0,GetHandleId(u))
    endfunction
    function IsUnitIndexed takes unit u returns boolean
        return HaveSavedInteger(H,0,GetHandleId(u))
    endfunction
    function IndexUnit takes unit u returns integer
        local integer id = LoadInteger(H,0,GetHandleId(u))
        if id == 0 then
            if GetUnitTypeId(u) == 0 then
                return 0
            endif
            if Z == 0 then
                set M = M + 1
                set id = M
            else
                set Z = Z - 1
                set id = S[Z]
            endif
            set C = C + 1
            set U[id] = u
            set I[id] = GetHandleId(u)
            set E[id] = CreateTrigger()
            call SaveInteger(H,0,GetHandleId(u),id)
            call ARef( u, id )
        endif
        return id
    endfunction
    //=========================================
    //  +a. 프리인덱서/포스트인덱서
    //=========================================
    private function OnAllocateCondition takes nothing returns boolean
        return not HaveSavedInteger(H,0,GetHandleId(GetTriggerUnit()))
    endfunction
    private function OnAllocateAction takes nothing returns nothing
        call IndexUnit(GetTriggerUnit())
    endfunction
    private function PostAllocate takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerAddAction(t, function OnAllocateAction)
        call TriggerAddCondition(t, Condition(function OnAllocateCondition))
        call TriggerRegisterEnterRectSimple(t, GetWorldBounds())
        set t = null
    endfunction
    private function EnumPreAllocate takes nothing returns boolean
        call IndexUnit( GetFilterUnit() )
        return false
    endfunction
    private function PreAllocate takes nothing returns nothing
        local group g = CreateGroup()
        call GroupEnumUnitsInRect(g,GetWorldBounds(),Filter(function EnumPreAllocate))
        call DestroyGroup( g )
        set g = null
    endfunction
    private function main takes nothing returns nothing
        call PreAllocate()
        call PostAllocate()
    endfunction
endlibrary