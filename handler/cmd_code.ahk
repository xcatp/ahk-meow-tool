_Code(source) {

  getRetObj(code, msg) => { code: code, msg: msg }

  if source.params {
    supportParamRE := 'i)-[r|n]'
    if not source.params ~= supportParamRE
      return getRetObj(0, 'param error or unsupport')
    else param := source.params
  } else param := '-r'

  if source.target {
    targetMap := Map('main', 'g:\AHK\gitee_ahk2\scripts\main.ahk'
      , 'this', 'G:\AHK\gitee_ahk2\MeowTool'
      , 'test', 'G:\AHK\gitee_ahk2\_DEV\Test\_.ahk'
      , 'lc', 'G:\leeCode'
      , 'home', 'G:\Donwpour')
    target := source.target

    if targetMap.Has(target)
      target := targetMap.Get(target)
    else if !CheckTarget(target)
      return getRetObj(0, 'target error')
    target := Path.Normalize(target)
    if FileExist(target) = 'D' && param = '-r'              ; directory should use param -n (not force)
      param := '-n'
    msg := 'exec CODE via cmd'
  } else param := '', target := '', msg := 'open last window'
  Run A_ComSpec ' /c code ' JoinStr(A_Space, param, target, ' && exit'), , 'min'
  return getRetObj(1, msg)
}

#Include 'G:\AHK\gitee_ahk2\common\Path.ahk'

CheckTarget(target) {
  return Path.IsAbsolute(target) && FileExist(target)
}