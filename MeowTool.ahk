#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

Esc:: ExitApp

#Include core\handleMgr.ahk
#Include core\historyMgr.ahk
#Include handle\open.ahk
#Include handle\run.ahk
#Include handle\use.ahk
#Include ui\main.ahk

History.Init()
Mgr.Register('open', Open)
Mgr.Register('run', Run_)
Mgr.Register('use', Use)

MeowTool.Show()
OnMessage(0x0201, (*) => PostMessage(0xA1, 2))

!Space::
{
  static flag := true
  flag := !flag ? MeowTool.Resume() : MeowTool.Hide()
}