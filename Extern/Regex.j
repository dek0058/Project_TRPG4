library Regex

    globals
        private string Format = "{0}"
    endglobals

    //! textmacro RegexFunctionForInt takes VALUE
        static method Set$VALUE$ takes string OutMsg, integer inValue returns string
            local string msg = JNStringReplace(Format, "0", "$VALUE$-"+I2S(inValue))
            set OutMsg = OutMsg + msg
            return msg
        endmethod

        static method Get$VALUE$ takes string OutMsg returns integer
            local string regex = "\\{$VALUE$-.*?\\}"
            local string msg = JNStringTrimStart(JNStringTrimEnd(JNStringRegex(OutMsg, regex, 0)))
            local integer start = JNStringLength("{$VALUE$-")
            local integer end = JNStringLength(msg) - (start + 1)
            set msg = JNStringSub(msg, start, end)
            return S2I(msg)
        endmethod
    //! endtextmacro

    //! textmacro RegexFunctionForReal takes VALUE
        static method Set$VALUE$ takes string OutMsg, real inValue returns string
            local string msg = JNStringReplace(Format, "0", "$VALUE$-"+R2S(inValue))
            set OutMsg = OutMsg + msg
            return msg
        endmethod

        static method Get$VALUE$ takes string OutMsg returns real
            local string regex = "\\{$VALUE$-.*?\\}"
            local string msg = JNStringTrimStart(JNStringTrimEnd(JNStringRegex(OutMsg, regex, 0)))
            local integer start = JNStringLength("{$VALUE$-")
            local integer end = JNStringLength(msg) - (start + 1)
            set msg = JNStringSub(msg, start, end)
            return S2R(msg)
        endmethod
    //! endtextmacro

    //! textmacro RegexFunctionForString takes VALUE
        static method Set$VALUE$ takes string OutMsg, string inValue returns string
            local string msg = JNStringReplace(Format, "0", "$VALUE$-"+inValue)
            set OutMsg = OutMsg + msg
            return msg
        endmethod

        static method Get$VALUE$ takes string OutMsg returns string
            local string regex = "\\{$VALUE$-.*?\\}"
            local string msg = JNStringTrimStart(JNStringTrimEnd(JNStringRegex(OutMsg, regex, 0)))
            local integer start = JNStringLength("{$VALUE$-")
            local integer end = JNStringLength(msg) - (start + 1)
            set msg = JNStringSub(msg, start, end)
            return msg
        endmethod
    //! endtextmacro


    struct Regex

        //! runtextmacro RegexFunctionForInt("ClickData")

        //! runtextmacro RegexFunctionForReal("X")
        //! runtextmacro RegexFunctionForReal("Y")
    endstruct
endlibrary