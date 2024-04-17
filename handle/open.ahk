#Requires AutoHotkey v2.0

#Include G:\AHK\gitee_ahk2\common\util\config\CustomFS.ahk

#Include baseHandle.ahk

class Open extends baseHandle {

  static Handle(parsed) {
    cfs := CustomFS.Of('./cfg/openFile.txt')
    if res := cfs.Get(t := parsed.target) {
      Run res
      return this.Succ('ok', 'x')
    }
    return this.Fail(JoinStr(, '[Error]', t, ' not found'))
  }

}