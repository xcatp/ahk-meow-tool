#Include baseHandle.ahk

class RandomGen extends baseHandle {

  static Handle(parsed) {
    charset := '0123456789abcdefghijklmnopqrstuvwxyz'
    for v in parsed.params {
      switch v {
        case 'W': charset .= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        case 'u': charset .= '_'
      }
    }
    prefix := parsed.kvparams.HasProp('p') ? parsed.kvparams.p : ''
    loop parsed.target - (prefix ? prefix.Length : 0)
      s .= charset[Random(1, charset.Length)]
    A_Clipboard := s := (prefix s)
    return this.Succ(s, 'x')
  }

  static Echo() => '
  (
    r
    r [-u|W] [-p=?] target
    生成指定长度的随机串。
  )'

}