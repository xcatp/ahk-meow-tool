#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

Esc:: ExitApp

#Include core\handleMgr.ahk
#Include core\historyMgr.ahk
#Include handle\buildin\hist.ahk
#Include handle\buildin\meow.ahk
#Include handle\open.ahk
#Include handle\run.ahk
#Include handle\use.ahk
#Include handle\code.ahk
#Include ui\main.ahk

History.Init()
Mgr.Register('hist', Hist)
Mgr.Register('meow', Meow)
Mgr.Register('open', Open)
Mgr.Register('code', Code)
Mgr.Register('run', Run_)
Mgr.Register('use', Use)

MeowTool.Show()
OnMessage(0x0201, (*) => PostMessage(0xA1, 2))

!Space::
{
  static flag := true
  flag := !flag ? MeowTool.Resume() : MeowTool.Hide()
}