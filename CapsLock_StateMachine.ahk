; This program forces Windows PC language setting behaves like Mac with only English and Chinese settings
;管理员运行
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%" 
   ExitApp
}
 
;无环境变量
#NoEnv
 
SetCapsLockState, AlwaysOff  
SetStoreCapslockMode,Off
 
;高进程
Process Priority,,High

input_state := 0 ; 0 for English, 1 for Chinese

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
    IME_SetConvMode(1025)   ; make sure that the input mode is also in chinese
}
#Include, IME.ahk
