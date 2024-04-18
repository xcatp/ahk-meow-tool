#Include ../../core/historyMgr.ahk
#Include ../baseHandle.ahk

class Hist extends baseHandle {

  static Handle(parsed) {
    switch parsed.target {
      case 'open': History.OpenFile()
      case 'clear': History.Clear()
      default: return this.Fail('无效的操作')
    }
    return this.Succ('ok', 'x')
  }

  static Echo() => '
  (
    hist 内置命令。
    hist [open|clear]
    open   打开历史命令文件。
    clear  清空历史命令。
  )'
}