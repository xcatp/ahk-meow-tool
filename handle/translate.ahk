#Include baseHandle.ahk

#Include g:\AHK\git-ahk-lib\util\Unicodes.ahk
#Include g:\AHK\git-ahk-lib\util\JSON.ahk
#Include g:\AHK\git-ahk-lib\Path.ahk
#Include g:\AHK\git-ahk-lib\RunCMD.ahk

class Trans extends baseHandle {

  static Handle(parsed) {
    if (o := DoRequest(data := parsed.target)).Get('errno') != 0
      return this.Fail('failure on' data)
    return this.Succ(!o.Get('data').Length ? 'no result' : ToString(o.Get('data')[1]['v']))
    DoRequest(body) {
      _p := Path.join(A_ScriptDir, '/cfg/translate/_.py')
      loop 5 {
        if JSON.Parse(StrReplace(res := RunCMD(Format('py {} {}', _p, body)), "'", '"'), true).Get('errno') = 0
          break
        Sleep 300
      }
      return JSON.parse(StrReplace(DecodeUniCodeString(res), "'", '"'), true)
    }
  }

  static Echo() => '
  (
    t
    t target
    翻译单词 
  )'

}

/* Python 使用AHK网络请求时常出错，而py十分稳定
  from requests import post
  import sys

  res = post("https://fanyi.baidu.com/sug", data={"kw": sys.argv[1]})
  print(res.json())
*/
