; ~Tab::
; ToggleToChinese()
; ToggleToChinese()
; return

; ~Esc::
; ToggleToEnglish()
; return

CapsLock::
KeyWait, CapsLock, T0.3
If ErrorLevel {
    Send, {Capslock}
    KeyWait, CapsLock
} 
else {
    if input_state{
        ToggleToEnglish()
        input_state = 0
        ; MsgBox %input_state%
    }
    else{
        ToggleToChinese()
        ToggleToChinese()   ; for some reason I have to call it twice
        input_state = 1
    }
}
Return

SwitchIME(dwLayout){
    HKL:=DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus,ctl,A
    SendMessage,0x50,0,HKL,%ctl%,A
}              


ToggleToEnglish() {
    SwitchIME(0x04090409)
}
ToggleToChinese() {
    SwitchIME(00000804)
    IME_SetConvMode(1025)
}

#include IME.ahk
