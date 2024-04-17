#Requires AutoHotkey v2.0
#SingleInstance Force

#Include ./ui/main.ahk

#Include g:\AHK\gitee_ahk2\common\Util.ahk
#Include g:\AHK\gitee_ahk2\common\Extend.ahk

#NoTrayIcon

!9:: Reload
Esc:: ExitApp()
!Space:: {
  static flag := true
  if flag
    PlanEGui.Hide()
  else
    PlanEGui.Resume()
  flag := !flag
}

args := GetArgs()
themeType := args.Length ? args[1].split('=')[2] : 'Light'

PlanEGui.Show({ theme:  themeType})
OnMessage(0x0201, (*) => PostMessage(0xA1, 2))