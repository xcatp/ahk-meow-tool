#Include ../baseHandle.ahk

class Exit_ extends baseHandle {
  static nullable := true

  static Handle(*) => this.Succ('exit', 'x')

  static Echo() => '
  (
    exit 内置命令。
    exit []
    退出脚本。
  )'
}