#Include g:\AHK\git-ahk-lib\Extend.ahk

#Include keywords.ahk
#Include alias.ahk

; MToString Parse("echo -'x p' -b='he lo' 'a \'d' b 'e f' ef")

Parse(cmd) {
  cmd := GetAlias(cmd) || cmd
  try ReplaceAlias(&cmd)
  catch as e
    return _fail(e.Message)
  _esc := '\', _qc := "'"
  args := [], switchs := [], p := [], kp := {}, _s := '', i := 1, _q := false
  while i <= cmd.Length {
    if (_c := cmd.charAt(i)) = _esc && i < cmd.length && cmd.charAt(i + 1) = _qc {
      _s .= _qc, i++
    } else if _c = _qc {
      if _q
        _push(_s), _s := ''
      _q := !_q
    } else if _c = A_Space && !_q {
      _push(_s), _s := ''
    } else _s .= _c
    i++
  }
  if _s.length > 0
    args.push(_s)
  return _succ(args.shift(), {
    params: p,
    kvparams: kp,
    target: args.Length ? args.shift() : '',
    extra: args,
    raw: cmd
  })

  _push(s) {
    if !s
      return
    if s[1] != '-' {
      args.push(s)
      return
    }
    if s.Length = 1
      return
    if _ := InStr(s, '=')
      kp[s.substring(2, _)] := s.substring(_ + 1)
    else p.Push(_s.substring(2))
  }
  _succ(w, o) => { valid: true, which: w, parsed: o }
  _fail(msg) => { valid: false, msg: msg }
}