#Include G:\AHK\gitee_ahk2\common\util\ExecAhk2Script.ahk 
#Include G:\AHK\gitee_ahk2\common\util\config\CustomFS.ahk
#Include G:\AHK\gitee_ahk2\common\Path.ahk

_Use(target, args := []) {
  if Path.IsAbsolute(target) {
    target := Path.Normalize(target)
    arg := IsString(args) ? args.split(A_Space) : args
    ExecScript(target, , arg)
    return 0
  } else {
    cfs := CustomFs.Of('G:\AHK\gitee_ahk2\_self\_game\index.txt')
    Run(cfs.Get(target))
    return 0  
  }
  return 1
}