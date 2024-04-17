#Requires AutoHotkey v2.0

#Include parse.ahk
#Include ../handle/baseHandle.ahk

class Mgr {
  static h := Map()

  static Register(which, handler) {
    if not handler() is baseHandle
      throw TypeError('无效的处理器:' Type(handler()))
    if Mgr.h.Has(which)
      throw Error('duplicate key:' which)
    Mgr.h.Set(which, handler)
    return this
  }

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