#Include g:\AHK\gitee_ahk2\common\Extend.ahk

LineNum(text) {
  if !text
    return 0
  texts := text.split('`n')
  count := 0
  for v in texts {
    if !v
      continue
    count += v.Length // 20
  }
  return count + texts.Length
}

Split(text) {
  res := Object()
  splitStart := InStr(text, A_Space, , 1)
  splitEnd := InStr(text, A_Space, , -1)
  res.raw := text
  res.cmd := splitStart ? SubStr(text, 1, splitStart - 1) : text
  res.params := (splitStart == splitEnd) ? '' : SubStr(text, splitStart + 1, splitEnd - splitStart - 1)
  res.target := splitStart ? SubStr(text, splitEnd + 1) : ''
  res.pAt := SubStr(text, splitStart + 1)
  return res
}

TruncatedString(text, maxLen) {
  return StrLen(text) > maxLen
    ? SubStr(text, 1, maxLen) . '...'
    : text
}