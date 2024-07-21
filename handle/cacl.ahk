#Include baseHandle.ahk

class Cacl extends baseHandle {

  static Handle(parsed) {

    return this.Succ(ExecScript(parsed.raw.substring(5)))

    ExecScript(script) {
      script := Format('FileAppend({}, "*")', script)
      shell := ComObject("WScript.Shell")
      exec := shell.Exec("AutoHotkey.exe /ErrorStdOut *")
      exec.StdIn.Write(script)
      exec.StdIn.Close()
      return exec.StdOut.ReadAll()
    }
  }

  static Echo() => '
  (
    cacl
    cacl target
    计算表达式
  )'

}