#Include baseHandle.ahk
#Include buildin/exec.ahk

#Include g:\AHK\git-ahk-lib\util\config\CustomFS.ahk

class Sequence extends baseHandle {

  static Handle(parsed) {
    cfs := CustomFS.Of('./cfg/seqFile.txt')
    if !r := cfs.Get(parsed.target)
      return this.Fail(parsed.target ' not found')
    total := r.Length, successed := 0
    for i, v in r {
      if (echo := Exec.Handle({ target: v })).flag
        successed++, output .= '`n' i '-' echo.r
      else fr .= '`n' i '-' echo.r
    }
    return this.Succ(
      Format('done! successed:{}, failured:{}`noutput:{}`nreason:{}',
        successed, total - successed,
        output, fr
      )
    )
  }

  static Echo() => '
  (
    seq
    seq target
    执行一系列命令。  
  )'

}