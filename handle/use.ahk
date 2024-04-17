#Include G:\AHK\gitee_ahk2\common\Path.ahk
#Include G:\AHK\gitee_ahk2\common\util\config\CustomFS.ahk
#Include G:\AHK\gitee_ahk2\common\util\ExecAhk2Script.ahk

#Include baseHandle.ahk

class Use extends baseHandle {

  static Handle(parsed) {
    t := parsed.target
    if Path.IsAbsolute(t) {
      ExecScript(t, parsed.params.Join(A_Space), parsed.Extra)
    } else {
      cfs := CustomFs.Of('G:\AHK\gitee_ahk2\_self\_game\index.txt')
      if !r := cfs.Get(t)
        return this.Fail(JoinStr(, '[Error]', t, ' not found'))
      Run(cfs.Get(t))
    }
    return this.Succ('ok')
  }

}