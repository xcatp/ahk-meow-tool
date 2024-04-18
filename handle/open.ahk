#Include g:\AHK\git-ahk-lib\util\config\CustomFS.ahk
#Include baseHandle.ahk

class Open extends baseHandle {

  static Handle(parsed) {
    cfs := CustomFS.Of('./cfg/openFile.txt')
    if res := cfs.Get(t := parsed.target) {
      Run res
      return this.Succ('ok', 'x')
    }
    return this.Fail(t ' not found')
  }

  static Echo() => '
  (
    open
    open target
    打开配置文件中配置的文件或目录；
    如果是命令行也可以运行。
  )'

}