library JNCommon
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
    
    native JNProcessStart takes string fileName, string arguments returns boolean

function JNBitOr takes integer x, integer y returns integer
    return BitOr(x, y)
endfunction

function JNBitAnd takes integer x, integer y returns integer
    return BitAnd(x, y)
endfunction

function JNBitXor takes integer x, integer y returns integer
    return BitXor(x, y)
endfunction
endlibrary