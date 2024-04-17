#Include G:\AHK\gitee_ahk2\common\util\config\CustomFS.ahk
#Include G:\AHK\gitee_ahk2\common\Path.ahk

_Open(target) {
  cfs := CustomFs.Of(Path.Join(A_ScriptDir, '/handler/openFile.txt'))
  if res := cfs.Get(target) {
    Run res
    return true
  }
  return false
}
