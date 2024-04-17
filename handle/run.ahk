#Include baseHandle.ahk

; wapper native run
class Run_ extends baseHandle {

  static Handle(parsed) {
    try Run(parsed.target)
    catch
      return this.Fail('[Error]failure to run')
    return this.Succ('ok', 'x')
  }

}