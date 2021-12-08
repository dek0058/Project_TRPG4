/*
    DZ Client API FrameHandler(UI) 라이브러리
*/
library DZFrameHandle
    
    globals
        
    endglobals

    struct FrameHandleAnchor
        // Point
        static constant integer POINT_TOP_LEFT                = 0
        static constant integer POINT_TOP                     = 1
        static constant integer POINT_TOP_RIGHT               = 2
        static constant integer POINT_LEFT                    = 3
        static constant integer POINT_CENTER                  = 4
        static constant integer POINT_RIGHT                   = 5
        static constant integer POINT_BOTTOM_LEFT             = 6
        static constant integer POINT_BOTTOM                  = 7
        static constant integer POINT_BOTTOM_RIGHT            = 8

        // Text Justif
        static constant integer JUSTIFY_TOP                   = 0
        static constant integer JUSTIFY_MIDDLE                = 1
        static constant integer JUSTIFY_BOTTOM                = 2
        static constant integer JUSTIFY_LEFT                  = 3
        static constant integer JUSTIFY_CENTER                = 4
        static constant integer JUSTIFY_RIGHT                 = 5

        // Event
        static constant integer EVENT_CONTROL_CLICK           = 1
        static constant integer EVENT_MOUSE_ENTER             = 2
        static constant integer EVENT_MOUSE_LEAVE             = 3
        static constant integer EVENT_MOUSE_UP                = 4
        static constant integer EVENT_MOUSE_DOWN              = 5
        static constant integer EVENT_MOUSE_WHEEL             = 6
        static constant integer EVENT_CHECKBOX_CHECKED        = 7
        static constant integer EVENT_CHECKBOX_UNCHECKED      = 8
        static constant integer EVENT_EDITBOX_TEXT_CHANGED    = 9
        static constant integer EVENT_POPUPMENU_ITEM_CHANGED  = 10
        static constant integer EVENT_MOUSE_DOUBLECLICK       = 11
        static constant integer EVENT_SPRITE_ANIM_UPDATE      = 12
        static constant integer EVENT_SLIDER_VALUE_CHANGED    = 13
        static constant integer EVENT_DIALOG_CANCEL           = 14
        static constant integer EVENT_DIALOG_ACCEPT           = 15
        static constant integer EVENT_EDITBOX_ENTER           = 16

        // Scale
        static constant real MAX_WIDTH                        = 0.8
        static constant real MAX_HEIGHT                       = 0.6
        static constant real CENTER_X                         = MAX_WIDTH / 2.0
        static constant real CENTER_Y                         = MAX_HEIGHT / 2.0

        /*
        constant real JN_FRAME_ITEM_BUTTON_SIZE               = 0.03125
        constant real JN_FRAME_ITEM_BUTTON_SPACING_WIDTH      = 0.00875
        constant real JN_FRAME_ITEM_BUTTON_SPACING_HEIGHT     = 0.0068625
        */

    endstruct

    //隐藏界面元素
    native DzFrameHideInterface takes nothing returns nothing

    //修改游戏世界窗口位置
    native DzFrameEditBlackBorders takes real upperHeight, real bottomHeight returns nothing

    //头像
    native DzFrameGetPortrait takes nothing returns integer

    //小地图
    native DzFrameGetMinimap takes nothing returns integer

    //技能按钮
    native DzFrameGetCommandBarButton takes integer row, integer column returns integer

    //英雄按钮
    native DzFrameGetHeroBarButton takes integer buttonId returns integer

    //英雄血条
    native DzFrameGetHeroHPBar takes integer buttonId returns integer

    //英雄蓝条
    native DzFrameGetHeroManaBar takes integer buttonId returns integer

    //道具按钮
    native DzFrameGetItemBarButton takes integer buttonId returns integer

    //小地图按钮
    native DzFrameGetMinimapButton takes integer buttonId returns integer

    //左上菜单按钮
    native DzFrameGetUpperButtonBarButton takes integer buttonId returns integer

    //鼠标提示
    native DzFrameGetTooltip takes nothing returns integer

    //聊天信息
    native DzFrameGetChatMessage takes nothing returns integer

    //unit message
    native DzFrameGetUnitMessage takes nothing returns integer

    //top message
    native DzFrameGetTopMessage takes nothing returns integer

    //取rgba色值
    native DzGetColor takes integer r, integer g, integer b, integer a returns integer

    //设置界面更新回调（非同步）
    native DzFrameSetUpdateCallback takes string func returns nothing

    native DzFrameSetUpdateCallbackByCode takes code func returns nothing

    //显示/隐藏Frame
    native DzFrameShow takes integer frame, boolean enable returns nothing

    //创建frame
    native DzCreateFrame takes string frame, integer parent, integer id returns integer

    //创建SimpleFrame
    native DzCreateSimpleFrame takes string frame, integer parent, integer id returns integer

    //销毁frame
    native DzDestroyFrame takes integer frame returns nothing

    //加载toc
    native DzLoadToc takes string fileName returns nothing

    //设置frame相对位置
    native DzFrameSetPoint takes integer frame, integer point, integer relativeFrame, integer relativePoint, real x, real y returns nothing

    //设置frame绝对位置
    native DzFrameSetAbsolutePoint takes integer frame, integer point, real x, real y returns nothing

    //清空frame锚点
    native DzFrameClearAllPoints takes integer frame returns nothing

    //设置frame禁用/启用
    native DzFrameSetEnable takes integer name, boolean enable returns nothing

    //注册UI事件回调
    native DzFrameSetScript takes integer frame, integer eventId, string func, boolean sync returns nothing

    native DzFrameSetScriptByCode takes integer frame, integer eventId, code func, boolean sync returns nothing

    //获取触发ui的玩家
    native DzGetTriggerUIEventPlayer takes nothing returns player

    native DzGetTriggerUIEventFrame takes nothing returns integer

    //查找frame
    native DzFrameFindByName takes string name, integer id returns integer

    //查找SimpleFrame
    native DzSimpleFrameFindByName takes string name, integer id returns integer

    //查找String
    native DzSimpleFontStringFindByName takes string name, integer id returns integer

    //查找Texture
    native DzSimpleTextureFindByName takes string name, integer id returns integer

    //获取game ui
    native DzGetGameUI takes nothing returns integer


    //点击frame
    native DzClickFrame takes integer frame returns nothing

    //自定义屏幕比例
    native DzSetCustomFovFix takes real value returns nothing

    //使用宽屏模式
    native DzEnableWideScreen takes boolean enable returns nothing

    //设置文字（支持EditBox, TextFrame, TextArea, SimpleFontString、GlueEditBoxWar3、SlashChatBox、TimerTextFrame、TextButtonFrame、GlueTextButton）
    native DzFrameSetText takes integer frame, string text returns nothing

    //获取文字（支持EditBox, TextFrame, TextArea, SimpleFontString）
    native DzFrameGetText takes integer frame returns string

    //设置字数限制（支持EditBox）
    native DzFrameSetTextSizeLimit takes integer frame, integer size returns nothing

    //获取字数限制（支持EditBox）
    native DzFrameGetTextSizeLimit takes integer frame returns integer

    //设置文字颜色（支持TextFrame, EditBox）
    native DzFrameSetTextColor takes integer frame, integer color returns nothing

    //获取鼠标所在位置的ui控件指针
    native DzGetMouseFocus takes nothing returns integer

    //设置所有锚点到目标frame上
    native DzFrameSetAllPoints takes integer frame, integer relativeFrame returns boolean

    //设置焦点
    native DzFrameSetFocus takes integer frame, boolean enable returns boolean

    //设置模型（支持Sprite、Model、StatusBar）
    native DzFrameSetModel takes integer frame, string modelFile, integer modelType, integer flag returns nothing

    //获取控件是否启用
    native DzFrameGetEnable takes integer frame returns boolean

    //设置透明度（0-255）
    native DzFrameSetAlpha takes integer frame, integer alpha returns nothing

    //获取透明度
    native DzFrameGetAlpha takes integer frame returns integer

    //设置动画
    native DzFrameSetAnimate takes integer frame, integer animId, boolean autocast returns nothing

    //设置动画进度（autocast为false是可用）
    native DzFrameSetAnimateOffset takes integer frame, real offset returns nothing

    //设置texture（支持Backdrop、SimpleStatusBar）
    native DzFrameSetTexture takes integer frame, string texture, integer flag returns nothing

    //设置缩放
    native DzFrameSetScale takes integer frame, real scale returns nothing

    //设置tooltip
    native DzFrameSetTooltip takes integer frame, integer tooltip returns nothing

    //鼠标限制在ui内
    native DzFrameCageMouse takes integer frame, boolean enable returns nothing

    //获取当前值（支持Slider、SimpleStatusBar、StatusBar）
    native DzFrameGetValue takes integer frame returns real

    //设置最大最小值（支持Slider、SimpleStatusBar、StatusBar）
    native DzFrameSetMinMaxValue takes integer frame, real minValue, real maxValue returns nothing

    //设置Step值（支持Slider）
    native DzFrameSetStepValue takes integer frame, real step returns nothing

    //设置当前值（支持Slider、SimpleStatusBar、StatusBar）
    native DzFrameSetValue takes integer frame, real value returns nothing

    //设置frame大小
    native DzFrameSetSize takes integer frame, real w, real h returns nothing

    //根据tag创建frame
    native DzCreateFrameByTagName takes string frameType, string name, integer parent, string template, integer id returns integer

    //设置颜色（支持SimpleStatusBar）
    native DzFrameSetVertexColor takes integer frame, integer color returns nothing

    native DzOriginalUIAutoResetPoint takes boolean flag returns nothing

    native DzFrameSetPriority takes integer frame, integer priority returns nothing

    native DzFrameSetParent takes integer frame, integer parent returns nothing

    native DzFrameGetHeight takes integer frame returns real

    native DzFrameSetFont takes integer frame, string fileName, real height, integer flag returns nothing

    native DzFrameGetParent takes integer frame returns integer

    native DzFrameSetTextAlignment takes integer frame, integer align returns nothing

    native DzFrameGetName takes integer frame returns string


endlibrary