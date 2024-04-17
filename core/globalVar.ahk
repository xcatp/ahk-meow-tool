#Include g:\AHK\gitee_ahk2\common\Extend.ahk

globalPrefix := '$'
escapeChar := '\'

aliasMap := Map(
  'ahkRemote', 'G:\AHK\gitee_ahk2',
  'desktop', A_Desktop,
  'start', A_Startup
)

ReplaceAlias(&source) {
  list := []
  startPos := 1

  while (pos := InStr(source, globalPrefix, , startPos)) && source[pos - 1] != escapeChar {
    for k, v in aliasMap {
      if SubStr(source, pos + 1).beginWith(k) {
        list.Push(k)
        startPos := pos + k.Length
        break
      }
    }
  }

  for v in list
    source := StrReplace(source, globalPrefix v, aliasMap.Get(v))
}