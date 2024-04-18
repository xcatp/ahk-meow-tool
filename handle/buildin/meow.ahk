#Include g:\AHK\git-ahk-lib\Extend.ahk
#Include ../../core/handleMgr.ahk
#Include ../baseHandle.ahk

class Meow extends baseHandle {
  static nullable := true

  static Handle(parsed) {
    if Mgr.h.Has(parsed.target) {
      MsgBox(Mgr.h.Get(parsed.target).Echo())
      return this.Succ('ok')
    }
    switch parsed.target {
      case '': MsgBox(Mgr.h.Keys.Join(' '))
      default: return this.Fail('不支持的操作')
    }
    return this.Succ('ok')
  }

  static Echo() => '
  (
    meow 内置命令。
    meow [cmd]
    无目标将回显所有注册命令；
    否则，显示目标帮助文档。
  )'
}