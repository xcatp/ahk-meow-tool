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
      if !parsed.extra.Length
        return this.Succ(cfs.Get(_t).join('`n'))
      for k, in parsed.extra
        cfs.Append(_t, k)
      return (cfs.Sync(), this.Succ('appended!'))
    } else {
      if !parsed.extra.Length
        return this.Fail('val can not be null')
      cfs.Add(_t, parsed.extra.Join(','))
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
    todo : 打开 todo 文件
    todo key :查看 key 内容
    todo key val : 向 key 添加 vals
  )'

}