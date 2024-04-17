#Requires AutoHotkey v2.0

class History {

  static hist := [], cur := -1, histFilePath := './cfg/history.txt'

  static Get(last := true, reset?) {
    if !(l := History.hist.Length)
      return
    cur := History.cur
    if cur = 0 && !last
      return ';'
    cur += last ? 1 : -1
    cur := cur >= l ? l - 1 : cur, cur := cur <= 0 ? 0 : cur
    History.cur := cur
    return History.hist[l - cur]
  }

  static Add(content) {
    l := History.hist.Length
    if l && History.cur >= 0 && History.hist[l - History.cur] = content
      return
    if l && History.hist[l] = content
      return
    FileAppend(content '`r`n', History.histFilePath, 'utf-8')
    History.hist.Push(content), History.Reset()
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
  static OpenFile() => Run(History.histFilePath)
  static Clear() => (f := FileOpen(History.histFilePath, 'w', 'utf-8'), f.Close())

}
