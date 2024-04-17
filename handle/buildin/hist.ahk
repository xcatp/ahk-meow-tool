#Include ../../core/historyMgr.ahk
#Include ../baseHandle.ahk

class Hist extends baseHandle {

  static Handle(parsed) {
    switch parsed.target {
      case 'open': History.OpenFile()
      case 'clear': History.Clear()
      default: return this.Fail('无效的操作')
    }
    return this.Succ('ok')
  }
}