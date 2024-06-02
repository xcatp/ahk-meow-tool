#Include g:\AHK\git-ahk-lib\util\config\CustomFS.ahk
#Include g:\AHK\git-ahk-lib\util\ExecAhk2Script.ahk
#Include g:\AHK\git-ahk-lib\Path.ahk

#Include baseHandle.ahk

class Use extends baseHandle {

  static Handle(parsed) {
    t := parsed.target
    if Path.IsAbsolute(t) {
      ExecScript(t, parsed.params.Join(A_Space), parsed.Extra)
    } else {
      cfs := CustomFs.Of('.\cfg\useFile.txt')
      if !r := cfs.Get(t)
        return this.Fail(t ' not found')
      Run(r)
    }
    return this.Succ('ok', 'x')
  }

  static Echo() => '
    (
      use
      use target
      如果目标是绝对路径，将传入的开关与参数组合成命令行由AHK运行。
      否则，从配置文件中读取并运行。
    )'

}