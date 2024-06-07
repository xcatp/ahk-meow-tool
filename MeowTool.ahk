#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

#Include core\historyMgr.ahk
#Include handle\index.ahk
#Include ui\main.ahk

History.Init(), MeowTool.Show()
OnMessage(0x0201, (*) => PostMessage(0xA1, 2))

!Space:: {
  static flag := true
  flag := !flag ? MeowTool.Resume() : MeowTool.Hide()
}
Esc:: ExitApp