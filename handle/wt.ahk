#Include g:\AHK\git-ahk-lib\util\WtRunner.ahk
#Include g:\AHK\git-ahk-lib\Path.ahk

#Include baseHandle.ahk

class Wt extends baseHandle {

  static Handle(parsed) {
    ts := parsed.raw.substring(3)
    cfs := MeowConf.Of('./cfg/wtFile.txt')
    i := WtRunner.Builder()

    StrSplit(ts, A_Space).filter(v => v).forEach(v => _process(v))
    _process(t) {
      if not r := cfs.Get(t)
        throw Error('无效的执行目标:' t)
      i.NewTab(r.tabName, , r.tabColor, r.execPath, r.command).Window(r.window)
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
