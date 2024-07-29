#Include ..\core\handleMgr.ahk

#Include buildin\hist.ahk
#Include buildin\meow.ahk
#Include buildin\exit.ahk
#Include buildin\echo.ahk
#Include buildin\exec.ahk
#Include open.ahk
#Include run.ahk
#Include use.ahk
#Include code.ahk
#Include wt.ahk
#Include translate.ahk
#Include random.ahk
#Include cacl.ahk
#Include oqm.ahk
#Include todo.ahk
#Include sequence.ahk

Mgr
  .Register('exit', Exit_)
  .Register('echo', Echo)
  .Register('hist', Hist)
  .Register('meow', Meow)
  .Register('exec', Exec)
  .Register('open', Open)
  .Register('code', Code)
  .Register('run', Run_)
  .Register('use', Use)
  .Register('wt', Wt)
  .Register('t', Trans)
  .Register('r', RandomGen)
  .Register('cacl', Cacl)
  .Register('oqm', Oqm)
  .Register('todo', Todo)
  .Register('seq', Sequence)