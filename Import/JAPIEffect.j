library JAPIEffect

native EXSetEffectXY takes effect e, real x, real y returns nothing
native EXSetEffectZ takes effect e, real z returns nothing
native EXGetEffectX takes effect e returns real
native EXGetEffectY takes effect e returns real
native EXGetEffectZ takes effect e returns real
native EXSetEffectSize takes effect e, real size returns nothing
native EXGetEffectSize takes effect e returns real
native EXEffectMatRotateX takes effect e, real angle returns nothing
native EXEffectMatRotateY takes effect e, real angle returns nothing
native EXEffectMatRotateZ takes effect e, real angle returns nothing
native EXEffectMatScale takes effect e, real x, real y, real z returns nothing
native EXEffectMatReset takes effect e returns nothing
native EXSetEffectSpeed takes effect e, real speed returns nothing

function JNSetSpecialEffectScale takes effect whichEffect, real scale returns nothing
    call EXSetEffectSize(whichEffect, scale)
endfunction

function JNSetSpecialEffectPosition takes effect whichEffect, real x, real y, real z returns nothing
    call EXSetEffectXY(whichEffect, x, y)
    call EXSetEffectZ(whichEffect, z)
endfunction

function JNSetSpecialEffectHeight takes effect whichEffect, real height returns nothing
    call EXSetEffectZ(whichEffect, height)
endfunction

function JNSetSpecialEffectTimeScale takes effect whichEffect, real timeScale returns nothing
    call EXSetEffectSpeed(whichEffect, timeScale)
endfunction

function JNSetSpecialEffectOrientation takes effect whichEffect, real yaw, real pitch, real roll returns nothing
    call EXEffectMatRotateZ(whichEffect, yaw)
    call EXEffectMatRotateY(whichEffect, pitch)
    call EXEffectMatRotateX(whichEffect, roll)
endfunction

function JNSetSpecialEffectYaw takes effect whichEffect, real yaw returns nothing
    call EXEffectMatRotateZ(whichEffect, yaw)
endfunction

function JNSetSpecialEffectPitch takes effect whichEffect, real pitch returns nothing
    call EXEffectMatRotateY(whichEffect, pitch)
endfunction

function JNSetSpecialEffectRoll takes effect whichEffect, real roll returns nothing
    call EXEffectMatRotateX(whichEffect, roll)
endfunction

function JNSetSpecialEffectX takes effect whichEffect, real x returns nothing
    call EXSetEffectXY(whichEffect, x, EXGetEffectY(whichEffect))
endfunction

function JNSetSpecialEffectY takes effect whichEffect, real y returns nothing
    call EXSetEffectXY(whichEffect, EXGetEffectX(whichEffect), y)
endfunction

function JNSetSpecialEffectZ takes effect whichEffect, real z returns nothing
    call EXSetEffectZ(whichEffect, z)
endfunction

function JNSetSpecialEffectPositionLoc takes effect whichEffect, location loc returns nothing
    call EXSetEffectXY(whichEffect, GetLocationX(loc), GetLocationY(loc))
endfunction

function JNGetLocalSpecialEffectX takes effect whichEffect returns real
    return EXGetEffectX(whichEffect)
endfunction

function JNGetLocalSpecialEffectY takes effect whichEffect returns real
    return EXGetEffectY(whichEffect)
endfunction

function JNGetLocalSpecialEffectZ takes effect whichEffect returns real
    return EXGetEffectZ(whichEffect)
endfunction

function JNSetSpecialEffectMatrixScale takes effect whichEffect, real x, real y, real z returns nothing
    call EXEffectMatScale(whichEffect, x, y, z)
endfunction

function JNResetSpecialEffectMatrix takes effect whichEffect returns nothing
    call EXEffectMatReset(whichEffect)
endfunction
endlibrary