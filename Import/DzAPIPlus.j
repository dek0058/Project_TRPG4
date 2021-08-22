library DzAPIPlus
    native DzDestructablePosition takes destructable d, real x, real y returns nothing
    native DzSetUnitPosition takes unit whichUnit, real x, real y returns nothing
    native DzExecuteFunc takes string funcName returns nothing
    native DzGetUnitUnderMouse takes nothing returns unit
    native DzSetUnitTexture takes unit whichUnit, string path, integer texId returns nothing
    native DzSetMemory takes integer address, real value returns nothing
    native DzSetUnitID takes unit whichUnit, integer id returns nothing
    native DzSetUnitModel takes unit whichUnit, string path returns nothing
    native DzSetWar3MapMap takes string map returns nothing
    native DzGetLocale takes nothing returns string

function JNGetMouseFocusUnit takes nothing returns unit
    return DzGetUnitUnderMouse()
endfunction

function JNChangeMinimapTerrainTex takes string texFile returns nothing
    call DzSetWar3MapMap(texFile)
endfunction

function JNGetLocale takes nothing returns string
    return DzGetLocale()
endfunction
endlibrary