#Requires AutoHotkey v2.0

keywords := Map(
  'start', A_Startup,
  'desktop', A_Desktop,
  '_', A_UserName
)
for k, v in MeowConf.Of('./cfg/keywords.txt').data {
  keywords.Set(k, v)
}

ReplaceAlias(&source) {
  global keywords
  static rc := '$', ec := '``'
  cs := source.toCharArray(), i := 1, r := ''
  while i <= cs.Length {
    esc := false
    if cs[i] = ec
      esc := true, i++
    else if !esc and cs[i] = rc {
      _i := ++i, _jumpToChar(cs, rc, &i), _k := source.substring(_i, i)
      try _v := keywords.Get(_k)
      catch
        throw Error('引用不存在的键')
      r .= _v
    }
    r .= cs[i], i++
  }
  source := r

  _jumpToChar(_chars, _char, &_idx) {
    while _idx <= _chars.Length and _chars[_idx] != _char
      _idx++
    if _idx > _chars.Length
      throw Error('未找到成对的引用符')
  }
}