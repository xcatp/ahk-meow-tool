#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

Esc:: ExitApp

#Include core\handleMgr.ahk
#Include core\historyMgr.ahk
#Include handle\index.ahk
#Include ui\main.ahk

Mgr
  .Register('exit', Exit_)
  .Register('echo', Echo)
  .Register('hist', Hist)
  .Register('meow', Meow)
  .Register('open', Open)
  .Register('code', Code)
  .Register('run', Run_)
  .Register('use', Use)
  .Register('wt', Wt)

History.Init(), MeowTool.Show()
OnMessage(0x0201, (*) => PostMessage(0xA1, 2))

!Space:: {
  static flag := true
  flag := !flag ? MeowTool.Resume() : MeowTool.Hide()
}