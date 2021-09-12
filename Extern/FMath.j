library FMath/* v 1.2.0.0
    **********************************************************************************
    *
    *   Advanced Mathematics
    *   By looking_for_help aka eey
    *
    *   This system provides a large amount of standard mathematical functions that
    *   miss in standard Jass like logarithmic, hyperbolic, typecheck or rounding
    *   functions. It can be extended with various optional libraries.
    *
    ***********************************************************************************
    *
    *   Requirements
    *   */  uses ErrorMessage   /*  hiveworkshop.com/forums/jass-resources-412/snippet-error-message-239210/
    *
    ***********************************************************************************
    *
    *   Implementation
    *   To use this system, just copy this script to your trigger editor, then you
    *   can use it straight away. To see how the evaluation function works, compare
    *   the example IngameCalculator trigger.
    *
    **********************************************************************************
    *
    *   Available Plug-Ins and Extensions
    *       library MathParser
    *           - A library that allows you to parse string expressions. Compare the
    *             IngameCalculator Trigger for an example usage.
    *
    *       library Matrices
    *           - A library that allows you to perform Matrix and Vector operations
    *             like solving a System of Linear Equations, compute the inverse of
    *             a Matrix, perform Matrix multiplication and so on.
    *
    **********************************************************************************/
       
    globals
        /*************************************************************************
        *   Customizable globals
        *************************************************************************/
            
        // Do you want the system to store primes that were once detected?
        private constant boolean STORE_DETECTED_PRIMES = true
            
        /*************************************************************************
        *   End of customizable globals
        *************************************************************************/
        
        public hashtable h
        private constant real E_INV = 0.3678794
        private constant real LOG_02_FACTOR = 1.4429504
        private constant real LOG_10_FACTOR = 0.4342945
        private constant real LN_FACTOR = 1.2840254
        private constant real LN_FACTOR_INV = 0.7788008
    endglobals
       
    struct FMath //extends array
        // Constants
        static constant real Pi = 3.141593
        static constant real E = 2.718282
        static constant real Phi = 1.618034
        static constant real Inf = Pow(2.0, 128.0)
        static constant integer MinInt = -2147483648
        static constant integer MaxInt = 2147483647
        
        // Absolute value
        static method abs takes real r returns real
            if r < 0 then
                return -r
            endif
            return r
        endmethod
        
        // Signum
        static method sig takes real r returns real
            if r > 0 then
                return 1.0
            elseif r < 0 then
                return -1.0
            endif
            return 0.0
        endmethod
        
        // Min-Max
        static method max takes real r1, real r2 returns real
            if r1 < r2 then
                return r2
            endif
            return r1
        endmethod
        
        static method min takes real r1, real r2 returns real
            if r1 < r2 then
                return r1
            endif
            return r2
        endmethod

        static method clamp takes real min, real max, real value returns real
            if value < min then
                return min
            elseif value > max then
                return max
            endif
            return value
        endmethod
        
        // Modulus
        static method mod takes real r1, real r2  returns real
            local real modulus = r1 - I2R(R2I(r1/r2))*r2

            if modulus < 0 then
                set modulus = modulus + r2
            endif
            return modulus
        endmethod
        
        static method modInt takes integer n1, integer n2 returns integer
            local integer modulus = n1 - (n1/n2)*n2

            if modulus < 0 then
                set modulus = modulus + n2
            endif
            return modulus
        endmethod

        static method multiMod takes integer n1, integer n2, integer mod returns integer
            local integer factor1 = R2I(floor(n1/mod))
            local integer factor2 = R2I(floor(n2/mod))
            local integer modulus

            if factor1 == 0 then
                set factor1 = 1
            endif
            if factor2 == 0 then
                set factor2 = 1
            endif
            
            if n1 > mod/2 and n2 > mod/2 then
                set n1 = (n1 - factor1*mod)*(n2 - factor2*mod)
            else
                set n1 = n1*n2
            endif
            set n2 = mod
                
            set modulus = n1 - (n1/n2)*n2
            if modulus < 0 then
                set modulus = modulus + n2
            endif

            return modulus
        endmethod
        
        static method expMod takes integer x, integer n, integer modulo returns integer
            local string exponent = ""
            local integer result = 1
            local integer stringLen
            local integer i = 0
            
            loop
                if modInt(n, 2) == 1 then
                    set exponent = "1"+exponent
                else
                    set exponent = "0"+exponent
                endif
                set n = n/2
                    
                exitwhen n < 1
            endloop

            set stringLen = StringLength(exponent)
            loop
                exitwhen i >= stringLen
                set result = multiMod(result, result, modulo)
                if SubString(exponent, i, i + 1) == "1" then
                    set result = multiMod(result, x, modulo)
                endif
                set i = i + 1
            endloop

            return result
        endmethod
        
        // Digits
        static method digits takes real r returns integer
            local string s = R2S(r)
            local integer i = 0
            loop
                exitwhen SubString(s, i, i + 1) == "."
                set i = i + 1
            endloop
            if r < 0 then
                return i - 1
            endif
            return i
        endmethod

        // Logarithms
        static method ln takes real r returns real
            local real sum = 0.0
            local real sign = 1.0
            debug if r < 0.0 then
                debug call ThrowError(true, "FMath", "ln", "FMath", 0, "Logarithm of negative number is undefined!")
            debug endif
            if r < 1.0 then
                set r = 1.0/r
                set sign = -1.0
            endif
            loop
                exitwhen r < E
                set r = r*E_INV
                set sum = sum + 1.0
            endloop
            loop
                exitwhen r < LN_FACTOR
                set r = r*LN_FACTOR_INV
                set sum = sum + 0.25
            endloop

            return sign*(sum + 0.125*(r - 1.0)*(1 + 9.0/(2.0 + r) + 4.5/(0.5 + r) + 1.0/r))
        endmethod
        
        static method log2 takes real r returns real
            return LOG_02_FACTOR*ln(r)
        endmethod
        
        static method log10 takes real r returns real
            return LOG_10_FACTOR*ln(r)
        endmethod
        
        static method log takes real base, real arg returns real
            return ln(arg)/ln(base)
        endmethod
        
        // Hyperbolic functions
        static method sinh takes real r returns real
            return 0.5*(Pow(E, r) - Pow(E, -r))
        endmethod
        
        static method cosh takes real r returns real
            return 0.5*(Pow(E, r) + Pow(E, -r))
        endmethod
        
        static method tanh takes real r returns real
            return sinh(r)/cosh(r)
        endmethod
        
        static method asinh takes real r returns real
            return ln(r + SquareRoot(r*r + 1))
        endmethod
        
        static method acosh takes real r returns real
            return ln(r + SquareRoot(r*r - 1))
        endmethod
        
        static method atanh takes real r returns real
            return 0.5*ln((1 + r)/(1 - r))
        endmethod
        
        // Rounding
        static method floor takes real r returns real
            if r < 0 then
                return -I2R(R2I(-r))
            endif
            return I2R(R2I(r))
        endmethod
        
        static method ceil takes real r returns real
            if floor(r) == r then
                return r
            elseif r < 0 then
                return -(I2R(R2I(-r)) + 1.0)
            endif
            return I2R(R2I(r)) + 1.0
        endmethod
        
        static method round takes real r returns real
            if r > 0 then
                return I2R(R2I(r + 0.5))
            endif
            return I2R(R2I(r - 0.5))
        endmethod

        static method fractional takes real r returns real
            return r - floor(r)
        endmethod
        
        static method mergeFloat takes real r returns real
            local real afterC = fractional(r)
            local real beforeC = floor(r)
            local string beforeComma = R2S(beforeC)
            local string afterComma = R2S(afterC)
            local string subString
            local integer i = 0
            local integer stringLen = StringLength(beforeComma)
            local integer endPosition = 0
            
            if afterC == 0 then
                return beforeC
            endif
            loop
                exitwhen SubString(beforeComma, i, i + 1) == "."
                set i = i + 1
            endloop
            set beforeComma = SubString(beforeComma, 0, i)
            set i = StringLength(afterComma)
            loop
                set subString = SubString(afterComma, i, i + 1)
                exitwhen subString == "."
                if endPosition == 0 and subString != "0" and subString != "" then
                    set endPosition = i
                endif
                set i = i - 1
            endloop

            return S2R(beforeComma+SubString(afterComma, i + 1, endPosition + 1))
        endmethod
        
        // Type checks
        static method isDigit takes string s returns boolean
            return not (StringLength(s) != 1 or S2R(s) == 0 and s != "0")
        endmethod
        
        static method isInteger takes real r returns boolean
            return I2R(R2I(r)) == r
        endmethod
        
        static method isEven takes real r returns boolean
            return mod(r, 2.0) == 0
        endmethod
        
        static method isPrime takes integer n returns boolean
            local integer s
            local integer d
            local integer a = 2
            local integer temp
            local integer counter
            local integer dSave
            local integer modulus
            local boolean firstTest = false
            local boolean secondTest = false

            if n == 2 or n == 7 or n == 61 then
                return true
            elseif isEven(n) or n < 2 then
                return false
            endif
            
            static if STORE_DETECTED_PRIMES then
                if LoadBoolean(h, n, 0) then
                    return LoadBoolean(h, n, 1)
                endif
            endif

            if n < 157 then
                set a = n
                loop
                    exitwhen a == 1
                    if modInt(n, a) == 0 and a != n then
                        static if STORE_DETECTED_PRIMES then
                            call SaveBoolean(h, n, 0, true)
                            call SaveBoolean(h, n, 1, false)
                        endif
                        return false
                    endif
                    set a = a - 1
                endloop
                static if STORE_DETECTED_PRIMES then
                    call SaveBoolean(h, n, 0, true)
                    call SaveBoolean(h, n, 1, true)
                endif
                return true
            endif
            
            set s = R2I(floor(log2(n - 1)))
            loop
                set temp = R2I(Pow(2, I2R(s)))
                exitwhen modInt(n - 1, temp) == 0
                set s = s - 1
            endloop

            set d = (n - 1)/(R2I(Pow(2, I2R(s))))
            set dSave = d
            set a = 2
            set counter = 0
            loop
                exitwhen counter > s
                set modulus = expMod(a, d, n)
                if (counter == 0 and modulus == 1) or (counter > 0 and modulus - n == -1) then
                    set firstTest = true
                    exitwhen true
                endif
                set d = 2*d

                set counter = counter + 1
                if counter == 1 then
                    set d = dSave
                endif
            endloop

            if not firstTest then
                static if STORE_DETECTED_PRIMES then
                    call SaveBoolean(h, n, 0, true)
                    call SaveBoolean(h, n, 1, false)
                endif
                return false
            endif
            
            set a = 7
            set d = dSave
            set counter = 0
            loop
                exitwhen counter > s
                set modulus = expMod(a, d, n)
                if (counter == 0 and modulus == 1) or (counter > 0 and modulus - n == -1) then
                    if firstTest then
                        set secondTest = true
                        exitwhen true
                    endif
                endif
                set d = 2*d

                set counter = counter + 1
                if counter == 1 then
                    set d = dSave
                endif
            endloop

            if not secondTest then
                static if STORE_DETECTED_PRIMES then
                    call SaveBoolean(h, n, 0, true)
                    call SaveBoolean(h, n, 1, false)
                endif
                return false
            endif
            
            set a = 61
            set d = dSave
            set counter = 0
            loop
                exitwhen counter > s
                set modulus = expMod(a, d, n)
                if (counter == 0 and modulus == 1) or (counter > 0 and modulus - n == -1) then
                    if secondTest then
                        static if STORE_DETECTED_PRIMES then
                            call SaveBoolean(h, n, 0, true)
                            call SaveBoolean(h, n, 1, true)
                        endif
                        return true
                    endif
                endif
                set d = 2*d
                
                set counter = counter + 1
                if counter == 1 then
                    set d = dSave
                endif
            endloop
                
            static if STORE_DETECTED_PRIMES then
                call SaveBoolean(h, n, 0, true)
                call SaveBoolean(h, n, 1, false)
            endif
            return false
        endmethod
        
        // Factorial
        static method factorial takes real r returns real
            local real z = 1.0
            if floor(r) == r then
                debug if r < 0 then
                    debug call ThrowError(true, "FMath", "factorial", "FMath", 0, "Factorial of negative number is not defined!")
                debug endif
                if r == 0 then
                    return 1.0
                endif
                loop
                    exitwhen r == 0.0
                    set z = z*r
                    set r = r - 1.0
                endloop
                return z
            endif
            set r = r + 1.0
            return SquareRoot((2.0*Pi)/(r))*Pow(((1.0/E)*(r + 1.0/(12.0*r - 1.0/(10.0*r)))), r)
        endmethod

        static method distance takes real x1, real y1, real x2, real y2 returns real
            local real dx = x2 - x1
            local real dy = y2 - y1
            return SquareRoot((dx * dx) + (dy * dy))
        endmethod
    endstruct
    
    private module Init
        private static method onInit takes nothing returns nothing
            set h = InitHashtable()
        endmethod
    endmodule
    
    private struct Inits extends array
        implement Init
    endstruct
endlibrary