library JNCommon
static if REFORGED_MODE then
    native BlzBitOr takes integer x, integer y returns integer
    native BlzBitAnd takes integer x, integer y returns integer
    native BlzBitXor takes integer x, integer y returns integer
else
    native BitOr takes integer x, integer y returns integer
    native BitAnd takes integer x, integer y returns integer
    native BitXor takes integer x, integer y returns integer
    native JNI2R takes integer i returns real
    native JNR2I takes real r returns integer
        
    native JNWriteLog takes string str returns nothing
    native JNWriteLogReal takes real r returns nothing
    native JNGetLocalDateTime takes nothing returns string
    native JNGetLocalUnixTime takes nothing returns integer
    native JNGetMaxAttackSpeed takes nothing returns real
    native JNSetMaxAttackSpeed takes real speed returns nothing
    native IsReplayMode takes nothing returns boolean
    native IsHostPlayer takes nothing returns boolean 
    native JNGetSyncDelay takes nothing returns integer
    native JNSetSyncDelay takes integer delay returns nothing
    native JNGetConnectionState takes nothing returns integer

    native JNGetModuleHandle takes string moduleName returns integer
    native JNFindModuleHandle takes integer offset, integer signature returns integer
    native JNMemoryGetByte takes integer offset returns integer
    native JNMemorySetByte takes integer offset, integer value returns nothing
    native JNMemoryGetInteger takes integer offset returns integer
    native JNMemorySetInteger takes integer offset, integer value returns nothing
    native JNMemoryGetReal takes integer offset returns real
    native JNMemorySetReal takes integer offset, real value returns nothing

    native JNStopwatchCreate takes nothing returns integer
    native JNStopwatchStart takes integer id returns nothing
    native JNStopwatchPause takes integer id returns nothing
    native JNStopwatchReset takes integer id returns nothing
    native JNStopwatchDestroy takes integer id returns nothing
    native JNStopwatchElapsedMS takes integer id returns integer
    native JNStopwatchElapsedSecond takes integer id returns integer
    native JNStopwatchElapsedMinute takes integer id returns integer
    native JNStopwatchElapsedHour takes integer id returns integer
    native JNStopwatchTick takes integer id returns real

    native JNStringPos takes string str, string sub returns integer
    native JNStringReverse takes string str returns string
    native JNStringTrim takes string str returns string
    native JNStringTrimStart takes string str returns string
    native JNStringTrimEnd takes string str returns string
    native JNStringRegex takes string str, string regex, integer index returns string
    native JNStringCount takes string str, string sub returns integer
    native JNStringContains takes string str, string sub returns boolean
    native JNStringSplit takes string str, string sub, integer index returns string
    native JNStringReplace takes string str, string old, string newstr returns string
    native JNStringInsert takes string str, integer index, string val returns string
    native JNStringSub takes string str, integer start, integer length returns string
    native JNStringLength takes string str returns integer
    native JNStringCalcLines takes string str, integer length returns integer
endif

function JNBitOr takes integer x, integer y returns integer
static if REFORGED_MODE then
    return BlzBitOr(x, y)
else
    return BitOr(x, y)
endif
endfunction

function JNBitAnd takes integer x, integer y returns integer
static if REFORGED_MODE then
    return BlzBitAnd(x, y)
else
    return BitAnd(x, y)
endif
endfunction

function JNBitXor takes integer x, integer y returns integer
static if REFORGED_MODE then
    return BlzBitXor(x, y)
else
    return BitXor(x, y)
endif
endfunction
endlibrary