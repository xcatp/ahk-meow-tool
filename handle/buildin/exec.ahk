#Include ../baseHandle.ahk
#Include ../../core/handleMgr.ahk

class Exec extends baseHandle {

  static Handle(parsed) {
    if (r := Mgr.Check(parsed.target)).valid {
      if r.handler.Prototype.__Class = 'Exec'
        return this.Fail('Recursive calls')
      echo := Mgr.Call(r.handler, r.parsed)
      return this.Succ('done : ' echo.r)
    } else return this.Fail('Invalid target')
    return this.Succ('ok')
  }

  static Echo() => '
  (
    exec 内置命令。
    exit target
    执行一条注册命令，不可调用自己。
  )'
}