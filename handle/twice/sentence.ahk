#Include ../buildin/exec.ahk
#Include ../baseHandle.ahk

#Include g:\AHK\git-ahk-lib\util\JSON.ahk

class Http_Sentense extends baseHandle {

  static nullable := true

  static Handle(parsed) {
    echo := Exec.Handle({ target: 'http ' parsed.target })
    if echo.flag {
      if (o := JSON.Parse(echo.r)).code != 200
        return this.Fail(o.msg)
      return this.Succ(o.result.content '`n-' o.result.source '`n' o.result.note)
    }
    return this.Fail(echo.r)
  }

  static Echo() => '
  (
    sentence
    调用句子API。
  )'

}