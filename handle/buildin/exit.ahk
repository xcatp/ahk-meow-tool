#Include ../baseHandle.ahk

class Exit_ extends baseHandle {
  static nullable := true

  static Handle(*) => this.Succ('exit', 'x')

  static Echo() => '
  (
    exit
    exit
    退出脚本。
  )'
}