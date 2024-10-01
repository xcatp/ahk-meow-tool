; 需要使用 aly 的机器翻译服务
#Include baseHandle.ahk
#Include buildin/exec.ahk

#Include g:\AHK\git-ahk-lib\util\Unicodes.ahk
#Include g:\AHK\git-ahk-lib\util\JSON.ahk
#Include g:\AHK\git-ahk-lib\Path.ahk
#Include g:\AHK\git-ahk-lib\RunCMD.ahk

class Trans2 extends baseHandle {

  static Handle(parsed) {

    source_text := parsed.target (parsed.extra.Length ? ' ' parsed.extra.join(A_Space) : '')
    guess := IsZH(source_text) ; 也可以购买语种识别服务
    source_lang := parsed.kvparams['sl'] || (guess ? 'zh' : 'en')
    target_lang := parsed.kvparams['tl'] || (guess ? 'en' : 'zh')

    if (InStr(source_text, A_Space))
      source_text := '"' source_text '"'

    if (o := DoRequest()).Get('Code') != 200
      return this.Fail('failure on' source_text '`ncuz:' o.Get('Message'))

    echo := Exec.Handle({ target: 't ' source_text })

    Record(source_text, r := o.Get('Data').Get('Translated'))
    return this.Succ(r '`n|`n' echo.r)

    DoRequest() {
      _p := Path.join(A_ScriptDir, '/cfg/translate/aly.py')

      res := RunCMD(l := Format('py {} {} {} {}', _p, source_text, source_lang, target_lang))

      return JSON.parse(StrReplace(res, "'", '"'), true)
    }

    IsZH(str) => !str.toCharArray().every(v => !IsHan(v))
    Record(k, v) => FileAppend('`n' k ' : ' v, './cfg/dict.txt', 'utf-8')
  }

  static Echo() => '
  (
    tt
    tt target
    翻译单词或句子
  )'

}