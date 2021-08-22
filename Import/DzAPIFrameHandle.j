library DzAPIFrameHandle
globals
	constant integer JN_FRAMEPOINT_TOPLEFT                = 0
	constant integer JN_FRAMEPOINT_TOP                    = 1
	constant integer JN_FRAMEPOINT_TOPRIGHT               = 2
	constant integer JN_FRAMEPOINT_LEFT                   = 3
	constant integer JN_FRAMEPOINT_CENTER                 = 4
	constant integer JN_FRAMEPOINT_RIGHT                  = 5
	constant integer JN_FRAMEPOINT_BOTTOMLEFT             = 6
	constant integer JN_FRAMEPOINT_BOTTOM                 = 7
	constant integer JN_FRAMEPOINT_BOTTOMRIGHT            = 8

	constant integer JN_TEXT_JUSTIFY_TOP                  = 0
	constant integer JN_TEXT_JUSTIFY_MIDDLE               = 1
	constant integer JN_TEXT_JUSTIFY_BOTTOM               = 2
	constant integer JN_TEXT_JUSTIFY_LEFT                 = 3
	constant integer JN_TEXT_JUSTIFY_CENTER               = 4
	constant integer JN_TEXT_JUSTIFY_RIGHT                = 5

	constant integer JN_FRAMEEVENT_CONTROL_CLICK          = 1
	constant integer JN_FRAMEEVENT_MOUSE_ENTER            = 2
	constant integer JN_FRAMEEVENT_MOUSE_LEAVE            = 3
	constant integer JN_FRAMEEVENT_MOUSE_UP               = 4
	constant integer JN_FRAMEEVENT_MOUSE_DOWN             = 5
	constant integer JN_FRAMEEVENT_MOUSE_WHEEL            = 6
	constant integer JN_FRAMEEVENT_CHECKBOX_CHECKED       = 7
	constant integer JN_FRAMEEVENT_CHECKBOX_UNCHECKED     = 8
	constant integer JN_FRAMEEVENT_EDITBOX_TEXT_CHANGED   = 9
	constant integer JN_FRAMEEVENT_POPUPMENU_ITEM_CHANGED = 10
	constant integer JN_FRAMEEVENT_MOUSE_DOUBLECLICK      = 11
	constant integer JN_FRAMEEVENT_SPRITE_ANIM_UPDATE     = 12
	constant integer JN_FRAMEEVENT_SLIDER_VALUE_CHANGED   = 13
	constant integer JN_FRAMEEVENT_DIALOG_CANCEL          = 14
	constant integer JN_FRAMEEVENT_DIALOG_ACCEPT          = 15
    constant integer JN_FRAMEEVENT_EDITBOX_ENTER          = 16

    constant real JN_FRAME_MAX_WIDTH                      = 0.8
    constant real JN_FRAME_MAX_HEIGHT                     = 0.6

    constant real JN_FRAME_ITEM_BUTTON_SIZE               = 0.03125
    constant real JN_FRAME_ITEM_BUTTON_SPACING_WIDTH      = 0.00875
    constant real JN_FRAME_ITEM_BUTTON_SPACING_HEIGHT     = 0.0068625

    private hashtable Data = InitHashtable()
endglobals

    native DzFrameHideInterface takes nothing returns nothing
    native DzFrameEditBlackBorders takes real upperHeight, real bottomHeight returns nothing
    native DzFrameGetPortrait takes nothing returns integer
    native DzFrameGetMinimap takes nothing returns integer
    native DzFrameGetCommandBarButton takes integer row, integer column returns integer
    native DzFrameGetHeroBarButton takes integer buttonId returns integer
    native DzFrameGetHeroHPBar takes integer buttonId returns integer
    native DzFrameGetHeroManaBar takes integer buttonId returns integer
    native DzFrameGetItemBarButton takes integer buttonId returns integer
    native DzFrameGetMinimapButton takes integer buttonId returns integer
    native DzFrameGetUpperButtonBarButton takes integer buttonId returns integer
    native DzFrameGetTooltip takes nothing returns integer
    native DzFrameGetChatMessage takes nothing returns integer
    native DzFrameGetUnitMessage takes nothing returns integer
    native DzFrameGetTopMessage takes nothing returns integer
    native DzGetColor takes integer a, integer r, integer g, integer b returns integer
    native DzFrameSetUpdateCallback takes string func returns nothing
    native DzFrameSetUpdateCallbackByCode takes code funcHandle returns nothing
    native DzFrameShow takes integer frame, boolean enable returns nothing
    native DzCreateFrame takes string frame, integer parent, integer id returns integer
    native DzCreateSimpleFrame takes string frame, integer parent, integer id returns integer
    native DzDestroyFrame takes integer frame returns nothing
    native DzLoadToc takes string fileName returns nothing
    native DzFrameSetPoint takes integer frame, integer point, integer relativeFrame, integer relativePoint, real x, real y returns nothing
    native DzFrameSetAbsolutePoint takes integer frame, integer point, real x, real y returns nothing
    native DzFrameClearAllPoints takes integer frame returns nothing
    native DzFrameSetEnable takes integer name, boolean enable returns nothing
    native DzFrameSetScript takes integer frame, integer eventId, string func, boolean sync returns nothing
    native DzFrameSetScriptByCode takes integer frame, integer eventId, code funcHandle, boolean sync returns nothing
    native DzGetTriggerUIEventPlayer takes nothing returns player
    native DzGetTriggerUIEventFrame takes nothing returns integer
    native DzFrameFindByName takes string name, integer id returns integer
    native DzSimpleFrameFindByName takes string name, integer id returns integer
    native DzSimpleFontStringFindByName takes string name, integer id returns integer
    native DzSimpleTextureFindByName takes string name, integer id returns integer
    native DzGetGameUI takes nothing returns integer
    native DzClickFrame takes integer frame returns nothing
    native DzSetCustomFovFix takes real value returns nothing
    native DzEnableWideScreen takes boolean enable returns nothing
    native DzFrameSetText takes integer frame, string text returns nothing
    native DzFrameGetText takes integer frame returns string
    native DzFrameSetTextSizeLimit takes integer frame, integer size returns nothing
    native DzFrameGetTextSizeLimit takes integer frame returns integer
    native DzFrameSetTextColor takes integer frame, integer color returns nothing
    native DzGetMouseFocus takes nothing returns integer
    native DzFrameSetAllPoints takes integer frame, integer relativeFrame returns boolean
    native DzFrameSetFocus takes integer frame, boolean enable returns boolean
    native DzFrameSetModel takes integer frame, string modelFile, integer modelType, integer flag returns nothing
    native DzFrameGetEnable takes integer frame returns boolean
    native DzFrameSetAlpha takes integer frame, integer alpha returns nothing
    native DzFrameGetAlpha takes integer frame returns integer
    native DzFrameSetAnimate takes integer frame, integer animId, boolean autocast returns nothing
    native DzFrameSetAnimateOffset takes integer frame, real offset returns nothing
    native DzFrameSetTexture takes integer frame, string texture, integer flag returns nothing
    native DzFrameSetScale takes integer frame, real scale returns nothing
    native DzFrameSetTooltip takes integer frame, integer tooltip returns nothing
    native DzFrameCageMouse takes integer frame, boolean enable returns nothing
    native DzFrameGetValue takes integer frame returns real
    native DzFrameSetMinMaxValue takes integer frame, real minValue, real maxValue returns nothing
    native DzFrameSetStepValue takes integer frame, real step returns nothing
    native DzFrameSetValue takes integer frame, real value returns nothing
    native DzFrameSetSize takes integer frame, real w, real h returns nothing
    native DzCreateFrameByTagName takes string frameType, string name, integer parent, string template, integer id returns integer
    native DzFrameSetVertexColor takes integer frame, integer color returns nothing
    //native DzOriginalUIAutoResetPoint takes boolean enable returns nothing    // DoNothing
    native DzFrameSetPriority takes integer frame, integer priority returns nothing
    native DzFrameSetParent takes integer frame, integer parent returns nothing
    native DzFrameGetHeight takes integer frame returns real
    native DzFrameSetFont takes integer frame, string fileName, real height, integer flag returns nothing
    native DzFrameGetParent takes integer frame returns integer
    native DzFrameSetTextAlignment takes integer frame, integer align returns nothing
    native DzFrameGetName takes integer frame returns string

function JNHideOriginFrames takes nothing returns nothing
    call DzFrameHideInterface()
endfunction

function JNGetGameUI takes nothing returns integer
    return DzGetGameUI()
endfunction

function JNFrameGetCommandBarButton takes integer x, integer y returns integer
    return DzFrameGetCommandBarButton(y, x)
endfunction

function JNFrameGetHeroBarButton takes integer buttonId returns integer
    return DzFrameGetHeroBarButton(buttonId)
endfunction

function JNFrameGetHeroHPBar takes integer buttonId returns integer
    return DzFrameGetHeroHPBar(buttonId)
endfunction

function JNFrameGetHeroManaBar takes integer buttonId returns integer
    return DzFrameGetHeroManaBar(buttonId)
endfunction

function JNFrameGetItemBarButton takes integer buttonId returns integer
    return DzFrameGetItemBarButton(buttonId)
endfunction

function JNFrameGetMinimap takes nothing returns integer
    return DzFrameGetMinimap()
endfunction

function JNFrameGetMinimapButton takes integer buttonId returns integer
    return DzFrameGetMinimapButton(buttonId)
endfunction

function JNFrameGetUpperButtonBarButton takes integer buttonId returns integer
    return DzFrameGetUpperButtonBarButton(buttonId)
endfunction

function JNFrameGetTooltip takes nothing returns integer
    return DzFrameGetTooltip()
endfunction

function JNFrameGetChatMessage takes nothing returns integer
    return DzFrameGetChatMessage()
endfunction

function JNFrameGetUnitMessage takes nothing returns integer
    return DzFrameGetUnitMessage()
endfunction

function JNFrameGetTopMessage takes nothing returns integer
    return DzFrameGetTopMessage()
endfunction

function JNFrameGetPortrait takes nothing returns integer
    return DzFrameGetPortrait()
endfunction

function JNConvertColor takes integer a, integer r, integer g, integer b returns integer
    return DzGetColor(a, r, g, b)
endfunction

function JNLoadTOCFile takes string TOCFile returns nothing
    call DzLoadToc(TOCFile)
endfunction

function JNCreateFrame takes string name, integer owner, integer priority, integer createContext returns integer
    local integer i = DzCreateFrame(name, owner, createContext)
    call DzFrameSetPriority(i, priority)
    return i
endfunction

function JNCreateSimpleFrame takes string name, integer owner, integer createContext returns integer
    return DzCreateSimpleFrame(name, owner, createContext)
endfunction

function JNCreateFrameByType takes string typeName, string name, integer owner, string inherits, integer createContext returns integer
    return DzCreateFrameByTagName(typeName, name, owner, inherits, createContext)
endfunction

function JNDestroyFrame takes integer frame returns nothing
    call DzDestroyFrame(frame)
endfunction

function JNFrameSetPoint takes integer frame, integer point, integer relative, integer relativePoint, real x, real y returns nothing
    call DzFrameSetPoint(frame, point, relative, relativePoint, x, y)
endfunction

function JNFrameSetAbsPoint takes integer frame, integer point, real x, real y returns nothing
    call DzFrameSetAbsolutePoint(frame, point, x, y)
endfunction

function JNFrameClearAllPoints takes integer frame returns nothing
    call DzFrameClearAllPoints(frame)
endfunction

function JNFrameSetAllPoints takes integer frame, integer relative returns nothing
    call DzFrameSetAllPoints(frame, relative)
endfunction

function JNFrameSetVisible takes integer frame, boolean enable returns nothing
    call DzFrameShow(frame, enable)
    if enable then
        if HaveSavedBoolean(Data, frame, 0) then
            call RemoveSavedBoolean(Data, frame, 0)
        endif
    else
        if not HaveSavedBoolean(Data, frame, 0) then
            call SaveBoolean(Data, frame, 0, true)
        endif
    endif
endfunction

function JNFrameIsVisible takes integer frame returns boolean
    return not HaveSavedBoolean(Data, frame, 0)
endfunction

function JNGetFrameByName takes string name, integer createContext returns integer
    local integer frame = DzFrameFindByName(name, createContext)
    if frame == 0 then
        set frame = DzSimpleFrameFindByName(name, createContext)
    endif
    if frame == 0 then
        set frame = DzSimpleFontStringFindByName(name, createContext)
    endif
    if frame == 0 then
        set frame = DzSimpleTextureFindByName(name, createContext)
    endif
    return frame
endfunction

function JNFrameGetName takes integer frame returns string
    return DzFrameGetName(frame)
endfunction

function JNFrameClick takes integer frame returns nothing
    call DzClickFrame(frame)
endfunction

function JNFrameSetText takes integer frame, string text returns nothing
    call DzFrameSetText(frame, text)
endfunction

function JNFrameGetText takes integer frame returns string
    return DzFrameGetText(frame)
endfunction

function JNFrameAddText takes integer frame, string text returns nothing
    call DzFrameSetText(frame, DzFrameGetText(frame) + text)
endfunction

function JNFrameSetTextSizeLimit takes integer frame, integer size returns nothing
    call DzFrameSetTextSizeLimit(frame, size)
endfunction

function JNFrameGetTextSizeLimit takes integer frame returns integer
    return DzFrameGetTextSizeLimit(frame)
endfunction

function JNFrameSetTextColor takes integer frame, integer color returns nothing
    call DzFrameSetTextColor(frame, color)
endfunction

function JNFrameSetFocus takes integer frame, boolean flag returns nothing
    call DzFrameSetFocus(frame, flag)
endfunction

function JNFrameSetModel takes integer frame, string modelFile, integer cameraIndex returns nothing
    call DzFrameSetModel(frame, modelFile, cameraIndex, 0)
endfunction

function JNFrameSetEnable takes integer frame, boolean enabled returns nothing
    call DzFrameSetEnable(frame, enabled)
endfunction

function JNFrameGetEnable takes integer frame returns boolean
    return DzFrameGetEnable(frame)
endfunction

function JNFrameSetAlpha takes integer frame, integer alpha returns nothing
    call DzFrameSetAlpha(frame, alpha)
endfunction

function JNFrameGetAlpha takes integer frame returns integer
    return DzFrameGetAlpha(frame)
endfunction

// TODO : JNFrameSetSpriteAnimate

function JNFrameSetTexture takes integer frame, string texFile, integer flag returns nothing
    call DzFrameSetTexture(frame, texFile, flag)
endfunction

function JNFrameSetScale takes integer frame, real scale returns nothing
    call DzFrameSetScale(frame, scale)
endfunction

function JNFrameSetTooltip takes integer frame, integer tooltip returns nothing
    call DzFrameSetTooltip(frame, tooltip)
endfunction

function JNFrameCageMouse takes integer frame, boolean enable returns nothing
    call DzFrameCageMouse(frame, enable)
endfunction

function JNFrameSetValue takes integer frame, real value returns nothing
    call DzFrameSetValue(frame, value)
endfunction

function JNFrameGetValue takes integer frame returns real
    return DzFrameGetValue(frame)
endfunction

function JNFrameSetMinMaxValue takes integer frame, real minValue, real maxValue returns nothing
    call DzFrameSetMinMaxValue(frame, minValue, maxValue)
endfunction

function JNFrameSetStepSize takes integer frame, real stepSize returns nothing
    call DzFrameSetStepValue(frame, stepSize)
endfunction

function JNFrameSetSize takes integer frame, real width, real height returns nothing
    call DzFrameSetSize(frame, width, height)
endfunction

function JNFrameSetVertexColor takes integer frame, integer color returns nothing
    call DzFrameSetVertexColor(frame, color)
endfunction

function JNFrameSetLevel takes integer frame, integer level returns nothing
    call DzFrameSetPriority(frame, level)
endfunction

function JNFrameSetParent takes integer frame, integer parent returns nothing
    call DzFrameSetParent(frame, parent)
endfunction

function JNFrameGetParent takes integer frame returns integer
    return DzFrameGetParent(frame)
endfunction

function JNFrameGetHeight takes integer frame returns real
    return DzFrameGetHeight(frame)
endfunction

function JNFrameGetWidth takes integer frame returns real
    return 0. // Unsupport
endfunction

function JNFrameSetFont takes integer frame, string fileName, real height, integer flags returns nothing
    call DzFrameSetFont(frame, fileName, height, flags)
endfunction

function JNFrameSetTextAlignment takes integer frame, integer vert, integer horz returns nothing
    // SimpleFontString / SimpleMessageFrame / TextFrame
    local integer align = 0
    if vert == JN_TEXT_JUSTIFY_TOP then
        set align = 1
    elseif vert == JN_TEXT_JUSTIFY_MIDDLE then
        set align = 2
    elseif vert == JN_TEXT_JUSTIFY_BOTTOM then
        set align = 4
    endif
    if horz == JN_TEXT_JUSTIFY_LEFT then
        set align = align + 8
    elseif horz == JN_TEXT_JUSTIFY_CENTER then
        set align = align + 16
    elseif horz == JN_TEXT_JUSTIFY_RIGHT then
        set align = align + 32
    endif
    call DzFrameSetTextAlignment(frame, align)
endfunction

function JNFrameEditBlackBorders takes real upperHeight, real bottomHeight returns nothing
// Default bottomHeight = 0.13
    call DzFrameEditBlackBorders(upperHeight, bottomHeight)
endfunction

function JNTriggerRegisterFrameEvent takes trigger whichTrigger, integer frame, integer eventId returns nothing
    //Use JNFrameSetScript function
endfunction

function JNFrameSetScript takes integer frame, integer eventId, code funcHandle, boolean sync returns nothing
    call DzFrameSetScriptByCode(frame, eventId, funcHandle, sync)
endfunction

function JNEnableWideScreen takes boolean enable returns nothing
    call DzEnableWideScreen(enable)
endfunction

function JNGetTriggerUIEventPlayer takes nothing returns player
    return DzGetTriggerUIEventPlayer()
endfunction

function JNGetTriggerUIEventFrame takes nothing returns integer
    // boolean sync must false
    return DzGetTriggerUIEventFrame()
endfunction
endlibrary