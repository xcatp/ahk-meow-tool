#Include g:\AHK\gitee_ahk2\common\Util.ahk

_Tree(source) {
  param := source.params
  target := source.target

  getRetObj(flag, result) => { flag: flag, result: result }

  if !target
    return getRetObj(false, 'target should not be null')
  recursive := false
  switch param {
    case '-r': recursive := true
  }
  tree := GetDirectoryTree(target, recursive, true)
  return getRetObj(true, tree.FormatTree(4))
}