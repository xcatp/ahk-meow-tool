#Include ../util/util.ahk

#Include ../handler/cmd_use.ahk
#Include ../handler/cmd_open.ahk
#Include ../handler/custom_memo.ahk
#Include ../handler/custom_ps.ahk
#Include ../handler/custom_tree.ahk
#Include ../handler/cmd_code.ahk

#Include ./globalVar.ahk

class Handler {

  static _Call(command, group) {
    Handler().Handle(command, group)
  }

  Handle(ori, group) {
    ReplaceAlias(&ori)
    res := Split(ori)
    switch group {
      case 'use': return this.Use(res)
      case 'open': return this.Open(res)
      case 'code': return this.Code(res)
      case 'hist': return this.Hist(res)
      case 'customize': return this.Customize(res)
    }
  }

  Use(source) {
    exitCode := _Use(source.target, source.params)
    return exitCode = 0
      ? Handler.Result.Success('exec ahk script: ' source.target, 'x')
      : Handler.Result.Error('bad execute')
  }

  Open(source) {
    if _Open(source.pAt)
      return Handler.Result.Success('open ' source.target, 'x')
    try {
      Run source.target
      return Handler.Result.Success('open ' source.target, 'x')
    }
    catch
      return Handler.Result.Error('can not run ' source.target)
  }

  Code(source) {
    res := _Code(source)
    return res.code
      ? Handler.Result.Success(res.msg, 'x')
      : Handler.Result.Error(res.msg)
  }

  Hist(source) {
    switch source.pAt {
      case '--edit': Run(Path.Join(A_WorkingDir, 'fs/history.txt'))
      case '--clear': History.Clear()
      case '--display': return Handler.Result.Success(History.GetHist(), , true)
      default: return Handler.Result.Error('unhandle ' source.cmd)
    }
    return Handler.Result.Success('ok', 'x')
  }

  Customize(source) {
    switch source.cmd {
      case 'ps': return Handler.Result.Success(_PS(source.pAt), , true)
      case 'exit': return Handler.Result.Success('Program will exit', 'x')
      case 'reload': return Handler.Result.Success('Program will reload', 'r')
      case 'echo': return Handler.Result.Success(source.pAt)
      case 'memo':
        Memo.appendText(source.pAt)
        return Handler.Result.Success('ok', 'x')
      case 'tree':
        res := _Tree(source)
        return res.flag
          ? Handler.Result.Success(res.result, , true)
          : Handler.Result.Error(res.result)
      default: return Handler.Result.Error('unhandle ' source.cmd)
    }
  }

  class Result {
    __New(flag, msg, special := '', needWindow := false) {
      this.flag := flag                                       ; success or failure
      this.msg := msg                                         ; message
      this.lineNum := needWindow ? 0 : LineNum(msg)           ; number of lines
      this.special := special                                 ; attach message
      this.needWindow := needWindow                           ; large output
    }

    static Success(msg, special := '', needWindow := false) {
      return Handler.Result(true, msg, special, needWindow)
    }

    static Error(msg) {
      prefix := '[Error]'
      return Handler.Result(false, prefix msg)
    }
  }
}