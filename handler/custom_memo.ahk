class Memo {
  static memoFilePath := A_Desktop '/next.txt'

  static appendText(content) {
    FileAppend(content '`r`n', Memo.memoFilePath, 'utf-8')
  }
}