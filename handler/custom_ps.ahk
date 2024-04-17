#Include g:\AHK\gitee_ahk2\common\ShellRun.ahk

_PS(cmd) {
  result := ShellRun.RunWaitOne_PS(cmd)
  return result
}