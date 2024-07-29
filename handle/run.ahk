#Include baseHandle.ahk

; wapper native run
class Run_ extends baseHandle {

  static Handle(parsed) {
    try Run(Format('{}', parsed.target))
    catch
      return this.Fail('failure to run')
    return this.Succ('ok', 'x')
  }

  static Echo() => '
  (
    run
    run target
    包装原生Run方法，但仅接受执行目标。
    如：run wt
  )'

}