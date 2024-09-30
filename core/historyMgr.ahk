#Include g:\AHK\git-ahk-lib\Path.ahk

class History {

  static hist := [], cur := -1, histFilePath := './cfg/history.txt'

  static Get(last := true, reset?) {
    if !(l := History.hist.Length)
      return
    cur := History.cur
    if cur <= 0 && !last {
      History.cur := -1
      return ';'
    }
    cur += last ? 1 : -1
    cur := cur >= l ? l - 1 : cur, cur := cur <= 0 ? 0 : cur
    History.cur := cur
    return History.hist[l - cur]
  }

  static Add(content) {
    l := History.hist.Length, History.Reset()
    if l && History.cur >= 0 && History.hist[l - History.cur] = content
      return
    if l && History.hist[l] = content
      return
    FileAppend(content '`r`n', History.histFilePath, 'utf-8')
    History.hist.Push(content)
  }

  static Init() {
    f := FileOpen(History.histFilePath, 'r', 'utf-8')
    while !f.AtEOF {
      if l := f.ReadLine()
        History.hist.Push(l)
    }
    f.Close()
  }

  static Reset() => History.cur := -1
  static OpenFile() => Run(Path.Join(A_ScriptDir, History.histFilePath))
  static Clear() => (f := FileOpen(History.histFilePath, 'w', 'utf-8'), f.Close())

}