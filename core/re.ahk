#Include ../util/util.ahk

Class Re {
  static customCmd := Array(
    'i)^exit$',
    'i)^reload$',
    'i)^echo\s.*$',
    'i)^memo\s.*$',
    'i)^ps',
    'i)^tree'
  )

  static cmds := Map(
    'use', 'i)^use',
    'open', 'i)^open',
    'code', 'i)^code',
    'hist', 'i)^hist\s--(clear|display|edit)$',
    '*', Re.customCmd
  )

  static CheckVaild(text) {

    checkLegal(text) => text ~= 'i)^\w+([\s-\w+]*[\s--\w+]*)*(\s.*)?$'

    if not checkLegal(text)
      return Re.Result.Error('unlegal command')

    spacePos := InStr(text, A_Space)
    cmd := SubStr(text, 1, spacePos ? spacePos - 1 : unset)

    if Re.cmds.Has(cmd) {
      regex := Re.cmds.Get(cmd)
      if (text ~= regex)
        return Re.Result.Success(cmd, TruncatedString(text, 20))
      return Re.Result.Error('unmatching command')
    }

    regex := Re.cmds.Get('*')
    for k, v in regex
      if (text ~= v)
        return Re.Result.Success('customize', TruncatedString(text, 20))
    return Re.Result.Error('invalid command')
  }

  class Result {
    __New(flag, value, msg) {
      this.flag := flag                   ; success or failure
      this.value := value                 ; the group of cmd
      this.msg := msg                     ; message
    }
  
    static Success(value, msg) {
      return Re.Result(true, value, msg)
    }
  
    static Error(msg) {
      return Re.Result(false, '', msg)
    }
  }
  
}