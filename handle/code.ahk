#Include g:\AHK\git-ahk-lib\util\config\CustomFS.ahk
#Include baseHandle.ahk

class Code extends baseHandle {

  static Handle(parsed) {
    t := parsed.target, p := parsed.params.Length ? '-' parsed.params[1] : '-r'
    if p and (p != '-r' and p != '-n')
      return this.Fail('无效的参数：' p)
    cfs := CustomFS.Of('./cfg/codeFile.txt')
    if r := cfs.Get(parsed.target) {
      Run(A_ComSpec ' /c code ' JoinStr(A_Space, p, r, ' && exit'), , 'min')
      return this.Succ('ok, open custom file', 'x')
    }
    if FileExist(t) {
      Run(A_ComSpec ' /c code ' t ' && exit', , 'min')
      return this.Succ('ok', 'x')
    }
    return this.Fail('无效的执行目标')
  }

  static Echo() => '
  (
    code
    code [-r|-n] target
    使用vscode打开指定目标。
  )'
}