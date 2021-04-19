library JNServer
static if not REFORGED_MODE then
    native JNUse takes nothing returns boolean
    native JNPVPUse takes string MapId, string SecretKey returns nothing
    native JNOpenBrowser takes string uri returns nothing
    native JNServerTime takes string Format returns string
    native JNServerUnixTime takes nothing returns integer
    native JNPVPLog takes string UserId, string Log returns nothing
    native JNPVPCharacter takes string UserId, string Character returns nothing
    native JNPVPKill takes string UserId returns nothing
    native JNPVPDeath takes string UserId returns nothing
    native JNPVPAssist takes string UserId returns nothing
    native JNPVPWin takes string UserId, boolean Win returns nothing
    native JNSetPVPLog takes string MapId, string UserId, string SecretKey, string Character, boolean Win, integer Kill, integer Death, integer Assist, string Loging returns string
    native JNSetSaveCode takes string MapId, string UserId, string SecretKey, string Character, string Code returns string
    native JNGetLoadCode takes string MapId, string UserId, string SecretKey, string Character returns string
    native JNSetLog takes string MapId, string UserId, string SecretKey, string Character, string Version, string Loging returns string
    native JNGlobalInitUserObject takes string MapId, string UserId, string SecretKey, string Character returns integer
    native JNGlobalSaveUserObject takes string MapId, string UserId, string SecretKey, string Character returns string
    native JNGlobalSetInt takes string UserId, string field, integer value returns nothing
    native JNGlobalGetInt takes string UserId, string field returns integer
    native JNGlobalSetReal takes string UserId, string field, real value returns nothing
    native JNGlobalGetReal takes string UserId, string field returns real
    native JNGlobalSetString takes string UserId, string field, string value returns nothing
    native JNGlobalGetString takes string UserId, string field returns string
    native JNGlobalSetBoolean takes string UserId, string field, boolean value returns nothing
    native JNGlobalGetBoolean takes string UserId, string field returns boolean
    native JNGlobalRemoveField takes string UserId, string field returns nothing
    native JNGlobalClearField takes string UserId returns nothing
    native JNInitUserObject takes string MapId, string UserId, string SecretKey, string Character returns integer
    native JNSaveUserObject takes string MapId, string UserId, string SecretKey, string Character returns string
    native JNUseEndGameSave takes string MapId, string UserId, string SecretKey, string Character returns nothing
    native JNSetInt takes string UserId, string field, integer value returns nothing
    native JNGetInt takes string UserId, string field returns integer
    native JNSetReal takes string UserId, string field, real value returns nothing
    native JNGetReal takes string UserId, string field returns real
    native JNSetString takes string UserId, string field, string value returns nothing
    native JNGetString takes string UserId, string field returns string
    native JNSetBoolean takes string UserId, string field, boolean value returns nothing
    native JNGetBoolean takes string UserId, string field returns boolean
    native JNSetScore takes string UserId, integer value returns nothing
    native JNResetScore takes string UserId returns nothing
    native JNRemoveField takes string UserId, string field returns nothing
    native JNClearField takes string UserId returns nothing
    native JNGetCharacterCount takes string MapId, string UserId, string SecretKey returns integer
    native JNGetCharacterNameByIndex takes string UserId, integer Index returns string
    native JNPopGlobalMessage takes nothing returns string
    native JNSendGlobalMessage takes string message returns nothing
    native JNUseUserRoleItem takes string MapId, string SecretKey, string UserId, string Character, string ItemName returns boolean
endif
endlibrary