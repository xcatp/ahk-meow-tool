#Include baseHandle.ahk

class Open extends baseHandle {

  static Handle(parsed) {
    cfs := MeowConfEx.Of('./cfg/openFile.txt')
    if parsed.params.findIndex(_ => _ = 'a') {
     if cfs.Add(parsed.target, parsed.extra, parsed.kvparams.c, , false) {
       cfs.Sync()
       return this.Succ('ok', 'x')
     } else return this.Fail('duplicate key:' parsed.target)
    }
    if res := cfs.Get(t := parsed.target) {
      Run res
      return this.Succ('ok', 'x')
    }
    return this.Fail(t ' not found')
  }

  static Echo() => '
  (
    open
    open [-a] target
    打开配置文件中配置的文件或目录；
    如果是命令行也可以运行。
  )'

}