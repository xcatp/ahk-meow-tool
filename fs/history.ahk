class History {
  static hist := []
  static cur := -1
  static histFilePath := './fs/history.txt'

  __New() {
    History.Init()
  }

  Get(last := true, reset?) {
    l := History.hist.Length
    if !l
      return
    cur := History.cur
    if cur = 0 && !last {
      return ';'
    }
    cur += last ? 1 : -1
    cur := cur >= l ? l - 1 : cur
    cur := cur <= 0 ? 0 : cur
    History.cur := cur
    return History.hist[l - cur]
  }

  static Reset() {
    History.cur := -1
  }

  AddHist(content) {
    l := History.hist.Length
    if l && History.cur >= 0 && History.hist[l - History.cur] = content
      return
    if l && History.hist[l] = content
      return
    FileAppend(content '`r`n', History.histFilePath, 'utf-8')
    History.hist.Push(content)
    History.Reset()
  }

  static Init() {
    f := FileOpen(History.histFilePath, 'r', 'utf-8')
    while !f.AtEOF {
      if l := f.ReadLine()
        History.hist.Push(l)
    }
    f.Close()
  }

  static GetHist() {
    return FileRead(History.histFilePath, 'utf-8')
  }

  static Clear() {
    f := FileOpen(History.histFilePath, 'w', 'utf-8')
    f.Close()
  }
}