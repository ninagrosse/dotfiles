#Requires AutoHotkey v2.0

; Remap CapsLock to behave as AltGr (Right Alt)
CapsLock::
{
    SetCapsLockState("Off")      ; Ensure CapsLock functionality is disabled
    Send("{Blind}{RAlt Down}")   ; Press and hold AltGr
    KeyWait("CapsLock")          ; Wait until CapsLock is released
    Send("{Blind}{RAlt Up}")     ; Release AltGr
    return
}

; Use Shift + CapsLock for the normal CapsLock functionality
+CapsLock::
{
    if GetKeyState("CapsLock", "T")
        SetCapsLockState("Off")
    else
        SetCapsLockState("On")
    return
}

