#Requires AutoHotkey v2.0

#Include G:\AHK\gitee_ahk2\common\Extend.ahk

#Include keywords.ahk

Parse(cmd) {
  try ReplaceAlias(&cmd)
  catch as e
    return _fail(e.Message)
  parts := cmd.split(A_Space).filter(v => v)
  w := parts.shift(), p := [], kp := {}, idx := 0
  while ++idx <= parts.Length and (v := parts[idx])[1] = '-' {
    if v.Length = 1
      return _fail('无效的空参')
    if i := InStr(v, '=')
      kp[v.substring(2, i)] := v.substring(i + 1)
    else p.Push(v.substring(2))
  }
  if idx > parts.Length
    return _fail('缺少执行目标')
  t := parts[idx++], ep := ''
  loop parts.Length - idx + 1
    ep .= parts[idx++] A_Space
  parsed := { which: w, params: p, kvparams: kp, target: t, extra: RTrim(ep) }
  return _succ(w, parsed)

  _succ(w, o) => { valid: true, which: w, parsed: o }
  _fail(msg) => { valid: false, msg: msg }

}