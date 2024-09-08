#Include g:\AHK\git-ahk-lib\util\Fs.ahk
#Include baseHandle.ahk

class Code extends baseHandle {

  static Handle(parsed) {
    t := parsed.target, p := parsed.params.Length ? '-' parsed.params[1] : ''
    if p and (p != '-r' and p != '-n')
      return this.Fail('无效的参数：' p)
    cfs := MeowConf.Of('./cfg/codeFile.txt')
    if r := cfs.Get(parsed.target) {
      p := p || (Fs.IsDir(r) ? '-n' : '-r')  ; 如果没有指定，则根据是否为文件夹设置
      Run(A_ComSpec ' /c code ' JoinStr(A_Space, p, '"' r '"',' && exit'), , 'hide')
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