#Include g:\AHK\git-ahk-lib\Extend.ahk
#Include ../../core/handleMgr.ahk
#Include ../baseHandle.ahk

class Meow extends baseHandle {

  static Handle(parsed) {
    switch parsed.target {
      case 'A': MsgBox(Mgr.h.Keys.Join(','))
      default: return this.Fail('不支持的操作')
    }
    return this.Succ('ok')
  }
}