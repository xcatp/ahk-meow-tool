#Include g:\AHK\git-ahk-lib\util\config\CustomFS.ahk
#Include g:\AHK\git-ahk-lib\util\ExecAhk2Script.ahk
#Include g:\AHK\git-ahk-lib\Path.ahk

#Include baseHandle.ahk

class Use extends baseHandle {

  static Handle(parsed) {
    t := parsed.target
    if Path.IsAbsolute(t) {
      ExecScript(t, parsed.params.Join(A_Space), parsed.Extra)
    } else {
      cfs := CustomFs.Of('.\cfg\useFile.txt')
      if !r := cfs.Get(t)
        return this.Fail(JoinStr(, '[Error]', t, ' not found'))
      Run(cfs.Get(t))
    }
    return this.Succ('ok', 'x')
  }

}