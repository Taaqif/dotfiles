#Requires AutoHotkey v2.0.2
#SingleInstance Force

Komorebic(cmd) {
    RunWait(format("komorebic.exe {}", cmd), , "Hide")
}

#HotIf GetKeyState("Alt", "P") and !GetKeyState("Shift", "P")

; Alt + z
  z & q::Komorebic("close")
  z & m::Komorebic("minimize")

  ; Focus windows
  z & h::Komorebic("focus left")
  z & j::Komorebic("focus down")
  z & k::Komorebic("focus up")
  z & l::Komorebic("focus right")

  ; Stack windows
  z & Left::Komorebic("stack left")
  z & Down::Komorebic("stack down")
  z & Up::Komorebic("stack up")
  z & Right::Komorebic("stack right")
  z & `;::Komorebic("unstack")
  z & [::Komorebic("cycle-stack previous")
  z & ]::Komorebic("cycle-stack next")
  z & `::Komorebic("cycle-layout next")

  ; Manipulate windows
  z & t::Komorebic("toggle-float")
  z & f::Komorebic("toggle-monocle")

  ; Workspaces
  z & 1::Komorebic("focus-workspace 0")
  z & 2::Komorebic("focus-workspace 1")
  z & 3::Komorebic("focus-workspace 2")
  z & 4::Komorebic("focus-workspace 3")
  z & 5::Komorebic("focus-workspace 4")
  z & 6::Komorebic("focus-workspace 5")
  z & 7::Komorebic("focus-workspace 6")
  z & 8::Komorebic("focus-workspace 7")

  ; Window manager options
  z & p::Komorebic("toggle-pause")

  ; Resize
  z & =::Komorebic("resize-axis horizontal increase")
  z & _::Komorebic("resize-axis horizontal decrease")

; Shift + Alt + z
#HotIf GetKeyState("Alt", "P") and GetKeyState("Shift", "P")
  ; Move windows across workspaces
  z & 1::Komorebic("move-to-workspace 0")
  z & 2::Komorebic("move-to-workspace 1")
  z & 3::Komorebic("move-to-workspace 2")
  z & 4::Komorebic("move-to-workspace 3")
  z & 5::Komorebic("move-to-workspace 4")
  z & 6::Komorebic("move-to-workspace 5")
  z & 7::Komorebic("move-to-workspace 6")
  z & 8::Komorebic("move-to-workspace 7")

  ;Move windows
  z & h::Komorebic("move left")
  z & j::Komorebic("move down")
  z & k::Komorebic("move up")
  z & l::Komorebic("move right")

  ; Window manager options
  z & r::Komorebic("retile")

  ; Resize
  z & =::Komorebic("resize-axis vertical increase")
  z & _::Komorebic("resize-axis vertical decrease")

