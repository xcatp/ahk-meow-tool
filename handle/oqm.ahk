#Requires AutoHotkey v2.0

#Include ./baseHandle.ahk

#Include g:\AHK\git-ahk-lib\util\Unicodes.ahk
#Include g:\AHK\git-ahk-lib\util\JSON.ahk
#Include g:\AHK\git-ahk-lib\Path.ahk
#Include g:\AHK\git-ahk-lib\RunCMD.ahk

class Oqm extends baseHandle {

  static Handle(parsed) {
    searchWord := parsed.target
    _p := Path.join(A_ScriptDir, '/cfg/oqm/_.py')
    res := RunCMD(Format('py {} {}', _p, searchWord), A_ScriptDir '/cfg/oqm')
    o := JSON.Parse(DecodeUniCodeString(StrReplace(res, "'", '"')))
    _r := Format('{}`n拆分:{}`n首末:{} {}`n编码:{} {}',
      o.list_dz[1][1], ; 总
      o.list_dz[1][2], ; 拆分
      o.list_dz[1][3], ; 首
      o.list_dz[1][4], ; 末
      o.list_dz[1][5], ; 编码
      o.list_dz[1][6]
    )
    return this.Succ(_r)
  }

  static Echo() => '
  (
    oqm
    oqm target
    小鹤查形
  )'
}