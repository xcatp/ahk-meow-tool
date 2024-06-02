#Include g:\AHK\git-ahk-lib\util\config\CustomFS.ahk
#Include g:\AHK\git-ahk-lib\util\WtRunner.ahk
#Include g:\AHK\git-ahk-lib\Path.ahk

#Include baseHandle.ahk

class Wt extends baseHandle {

  static Handle(parsed) {
    ts := parsed.raw.substring(parsed.which.length + 1)
    cfs := CustomFS.Of('./cfg/wtFile.txt')
    i := WtRunner.Builder().Window(-1)

    StrSplit(ts, A_Space).filter(v => v).forEach(v => _process(v))
    _process(t) {
      if not r := cfs.Get(t)
        throw Error('无效的执行目标:' t)
      i.NewTab(r.tabName, , r.tabColor, r.execPath, r.command)
    }
    i.Build().RunCmd()
    return this.Succ('ok', 'x')
  }

  static Echo() => '
    (
      wt
      wt target
      使用终端打开配置文件中的exe
    )'

}

; example config
; redis :    # run redis server
; + tabName  : redis-server
; + tabColor : #97d1f3
; + execPath : E:\_Program\Redis-x64-5.0.14.1
; + command  : '.\redis-server.exe redis.windows.conf'
