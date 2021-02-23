library test1 initializer Start

    globals
        private constant integer PC = 13

        // 여타 다른 객체들을 사용하지 않으므로 hashtable로 대체
        private hashtable hash = InitHashtable()
        private integer array NumberUnitIds
        private NumberUnitGroup NumberGroup;

        // 초기화 X, Y 좌표
        private constant real InitX = 0
        private constant real InitY = 0
    endglobals

    struct NumberUnit
        
        private boolean isShow
        private unit numberUnit

        static method create takes integer id returns thistype
            local this = allocate()
            set isShow = false
            set numberUnit = CreateUnit(Player(PC), id, InitX, InitY, 0.00)
            call ShowUnit(numberUnit, false)
            return this
        endmethod

        // [HACK] 없앤다는건 고려하지 않으므로 destroy는 구현하지 않음

        method Enable takes real inX, real inY, real inDur returns nothing
            call SetUnitPosition(numberUnit, inX, inY)
            call ShowUnit(numberUnit, true)
        endmethod

        method Dissable takes nothing returns nothing
            call SetUnitPosition(numberUnit, inX, inY)
            call ShowUnit(numberUnit, false)
        endmethod
    endstruct


    struct NumberUnitGroup

        private NumberUnit array Group0
        private NumberUnit array Group1
        private NumberUnit array Group2
        private NumberUnit array Group3
        private NumberUnit array Group4
        private NumberUnit array Group5
        private NumberUnit array Group6
        private NumberUnit array Group7
        private NumberUnit array Group8
        private NumberUnit array Group9


        static method create takes integer inCount returns thistype
            local thistype this = allocate()
            local integer i = 0

            loop
                exitwhen i == inCount
                set Group0[i] = NumberUnit.create(NumberUnitIds[0])
                set Group1[i] = NumberUnit.create(NumberUnitIds[1])
                set Group2[i] = NumberUnit.create(NumberUnitIds[2])
                set Group3[i] = NumberUnit.create(NumberUnitIds[3])
                set Group4[i] = NumberUnit.create(NumberUnitIds[4])
                set Group5[i] = NumberUnit.create(NumberUnitIds[5])
                set Group6[i] = NumberUnit.create(NumberUnitIds[6])
                set Group7[i] = NumberUnit.create(NumberUnitIds[7])
                set Group8[i] = NumberUnit.create(NumberUnitIds[8])
                set Group9[i] = NumberUnit.create(NumberUnitIds[9])
                set i = i + 1
            endloop

            return this
        endmethod
    endstruct


    private function OnInitailize takes nothing returns nothing
        

        // ID 초기화
        set NumberUnitIds[0] = 'AAA0'
        set NumberUnitIds[1] = 'AAA1'
        set NumberUnitIds[2] = 'AAA2'
        set NumberUnitIds[3] = 'AAA3'
        set NumberUnitIds[4] = 'AAA4'
        set NumberUnitIds[5] = 'AAA5'
        set NumberUnitIds[6] = 'AAA6'
        set NumberUnitIds[7] = 'AAA7'
        set NumberUnitIds[8] = 'AAA8'
        set NumberUnitIds[9] = 'AAA9'

        set NumberGroup = NumberUnitGroup.create()


    endfunction

    private function Start takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerAddAction(trig, function OnInitailize)
        call TriggerRegisterTimerEvent(trig, 0.01, true)
        set trig = null
    endfunction
endlibrary