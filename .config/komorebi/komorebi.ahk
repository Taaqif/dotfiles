#Requires AutoHotkey v2.0.2
#SingleInstance Force

global z_is_modifier := false
Komorebic(cmd) {
    RunWait(format("komorebic.exe {}", cmd), , "Hide")
}

; Handle Z as a modifier
z:: {
	global
    z_is_modifier := true
}

z up:: {
	global
    if z_is_modifier {
        z_is_modifier := false
        Send("z") ; Send Z if Z was tapped alone
    }
}

; Define custom key combinations
z & q::Komorebic("close")
z & m::Komorebic("minimize")

; Focus windows
z & h::Komorebic("focus left")
z & j::Komorebic("focus down")
z & k::Komorebic("focus up")
z & l::Komorebic("focus right")

; !z & [::Komorebic("cycle-focus previous")
; !z & ]::Komorebic("cycle-focus next")

; Move windows
#HotIf GetKeyState("Alt")
z & h::Komorebic("move left")
z & j::Komorebic("move down")
z & k::Komorebic("move up")
z & l::Komorebic("move right")
#HotIf

; Stack windows
z & Left::Komorebic("stack left")
z & Down::Komorebic("stack down")
z & Up::Komorebic("stack up")
z & Right::Komorebic("stack right")
z & `;::Komorebic("unstack")
z & [::Komorebic("cycle-stack previous")
z & ]::Komorebic("cycle-stack next")

; Resize
z & =::Komorebic("resize-axis horizontal increase")
z & -::Komorebic("resize-axis horizontal decrease")
#HotIf GetKeyState("Alt")
z & =::Komorebic("resize-axis vertical increase")
z & _::Komorebic("resize-axis vertical decrease")
#HotIf

; Manipulate windows
z & t::Komorebic("toggle-float")
z & f::Komorebic("toggle-monocle")

; Window manager options
#HotIf GetKeyState("Alt")
z & r::Komorebic("retile")
#HotIf
z & p::Komorebic("toggle-pause")

; Layouts
z & x::Komorebic("flip-layout horizontal")
z & y::Komorebic("flip-layout vertical")

; Workspaces
z & 1::Komorebic("focus-workspace 0")
z & 2::Komorebic("focus-workspace 1")
z & 3::Komorebic("focus-workspace 2")
z & 4::Komorebic("focus-workspace 3")
z & 5::Komorebic("focus-workspace 4")
z & 6::Komorebic("focus-workspace 5")
z & 7::Komorebic("focus-workspace 6")
z & 8::Komorebic("focus-workspace 7")

; Move windows across workspaces
#HotIf GetKeyState("Alt")
z & 1::Komorebic("move-to-workspace 0")
z & 2::Komorebic("move-to-workspace 1")
z & 3::Komorebic("move-to-workspace 2")
z & 4::Komorebic("move-to-workspace 3")
z & 5::Komorebic("move-to-workspace 4")
z & 6::Komorebic("move-to-workspace 5")
z & 7::Komorebic("move-to-workspace 6")
z & 8::Komorebic("move-to-workspace 7")
#HotIf

; Allow Shift+Z and Ctrl+Z to pass through
+z::Send("{Shift Down}z{Shift Up}")
^z::Send("{Ctrl Down}z{Ctrl Up}")
