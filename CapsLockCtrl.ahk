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


 
CapsLock::
KeyWait, CapsLock, T0.3
If ErrorLevel {
    Send, {Capslock}
    KeyWait, CapsLock
} 
else {
    if GetKeyState("CapsLock", "T") = 1{
        ; toggle to Chinese mode
        IME_SetConvMode(1025) 
        Send, {Capslock}
    }
    else
	    Send {Ctrl}	;send win + space in order to change input source
}
Return
#Include, IME.ahk