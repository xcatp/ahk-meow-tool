#Include g:\AHK\git-ahk-lib\util\config\CustomFSEx.ahk
#Include baseHandle.ahk

class Todo extends baseHandle {
  static nullable := true

  static Handle(parsed) {
    _p := '.\cfg\todoFile.txt'
    cfs := CustomFSEx.Of(_p)
    if !(_t := parsed.target) {
      Run _p
      return this.Succ('ok', 'x')
    }
    if cfs.Has(_t) {
      if !parsed.extra
        return this.Succ(cfs.Get(_t).join('`n'))
      return cfs.Append(_t, parsed.extra)
        ? (cfs.Sync(), this.Succ('appended!'))
        : this.Fail('key does not exsit')
    } else {
      if !parsed.extra
        return this.Fail('val can not be null')
      cfs.Add(_t, StrSplit(parsed.extra, ','))
      cfs.Sync()
      return this.Succ('created!')
    }
    return this.Fail('failured for unknow reason')
  }

  static Echo() => '
  (
    todo
    todo [target]
    添加或显示todos
  )'

}