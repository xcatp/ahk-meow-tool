#Requires AutoHotkey v2.0

#Include ../baseHandle.ahk

class Echo extends baseHandle {
  static nullable := true

  static Handle(parsed) {
    for v in parsed.params
      t .= '-' v ' '
    for k, v in parsed.kvparams.OwnProps()
      IsArray(v) ? t .= Format('-{}=[{}]', k, v.Join()) : t .= Format('-{}={} ', k, v)
    t .= parsed.target
    if parsed.extra.Length
      t .= ' ' parsed.extra.join(A_Space)

    return this.Succ('>' t '<')
  }

  static Echo() => '
  (
    echo 内置命令。
    echo [target]
    回显输入。
  )'
}