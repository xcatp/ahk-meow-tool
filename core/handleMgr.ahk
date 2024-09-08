#Include ../handle/baseHandle.ahk
#Include parse.ahk

class Mgr {
  static h := Map()

  static Register(which, handler) {
    if not handler() is baseHandle
      throw TypeError('无效的处理器:' handler.Prototype.__Class)
    if Mgr.h.Has(which)
      throw Error('注册重复的命令:' which)
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

  static Call(handler, parsed) {
    if !handler.nullable && !parsed.target
      return handler.Fail('目标不可为空')
    ; try
    r := handler.Handle(parsed)
    ; catch as e {
    ; return handler.Fail('ERROR:' handler.Prototype.__Class ':' e.Message)
    ; }
    return r
  }

}