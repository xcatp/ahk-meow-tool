#Requires AutoHotkey v2.0

#Include parse.ahk

class Mgr {

  static h := Map()

  static Register(which, handler) => Mgr.h.Has(which) ? MsgBox('duplicate key:' which) : Mgr.h.Set(which, handler)

  static Check(cmd) {
    if !(o := Parse(cmd)).valid
      return _fail(o.msg)
    if !Mgr.h.Has(o.which)
      return _fail('未注册的命令:' o.which)
    return _succ(Mgr.h.Get(o.which), o.parsed)

    _succ(h, o) => { valid: true, handler: h, parsed: o }
    _fail(msg) => { valid: false, msg: msg }
  }

  static Call(handler, parsed) => handler.handle(parsed)

}