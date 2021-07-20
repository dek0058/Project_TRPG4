library Main initializer Start uses MainDefine


    // @게임 초기화 함수
    function Main takes nothing returns nothing
        debug call WriteLog("TRPG4", "Main", "Main", "Calling")
        call InitCommandManager.evaluate()
    endfunction


    private function Start takes nothing returns nothing
    endfunction
endlibrary