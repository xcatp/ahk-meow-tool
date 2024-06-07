#Include ..\core\handleMgr.ahk

#Include buildin\hist.ahk
#Include buildin\meow.ahk
#Include buildin\exit.ahk
#Include buildin\echo.ahk
#Include open.ahk
#Include run.ahk
#Include use.ahk
#Include code.ahk
#Include wt.ahk
#Include translate.ahk

Mgr
  .Register('exit', Exit_)
  .Register('echo', Echo)
  .Register('hist', Hist)
  .Register('meow', Meow)
  .Register('open', Open)
  .Register('code', Code)
  .Register('run', Run_)
  .Register('use', Use)
  .Register('wt', Wt)
  .Register('t', Trans)