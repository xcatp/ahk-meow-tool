#Requires AutoHotkey v2.0

#Include ../baseHandle.ahk

class Echo extends baseHandle {
  static nullable := true

  static Handle(parsed) {
    return this.Succ(LTrim(parsed.raw.substring(5)))
  }

  static Echo() => '
  (
    echo 内置命令。
    echo [target]
    回显输入。
  )'
}