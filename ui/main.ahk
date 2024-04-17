#Requires AutoHotkey v2.0

#Include g:\AHK\gitee_ahk2\common\Extend.ahk
#Include g:\AHK\gitee_ahk2\common\Theme.ahk
#Include g:\AHK\gitee_ahk2\common\util\Animation.ahk

#Include ../core/handleMgr.ahk
#Include ../core/historyMgr.ahk

up:: MeowTool.SetContent(History.Get())
down:: MeowTool.SetContent(History.Get(false))

class MeowTool extends Gui {

  static ins := MeowTool(), exitFlag := 'x', reoladFlag := 'r'

  __New() {
    super.__New('+AlwaysOnTop +ToolWindow -Caption +Border')
    this.SetFont('s16', 'Consolas')
    this.AddButton('w0 h0 xs Default').OnEvent('click', (*) => this.Handle())
    this.edit := this.AddEdit('ym w300 h30 -Multi')
    this.fontPixel := 21, this.maxMsg := 30, this.SetFont('s12'), Theme.Light(this)
  }

  static SetContent(content) => content && MeowTool.ins.edit.Text := content
  static Hide() => MeowTool.ins.Hide()
  static Resume() => MeowTool.ins.Show()

  static Show() {
    Animation.RollDown(MeowTool.ins, Noop, (*) => MeowTool.ins.Move(, A_ScreenHeight / 4))
    static _ := MeowTool.ins.AddText('xm+5 h800 w400 vHis c811a1a')
    ControlFocus MeowTool.ins.edit.Hwnd, "A"
  }

  _Exit() => (Sleep(1000), Animation.RollUp(MeowTool.ins), ExitApp())
  _Reolad() => (Sleep(1000), Reload())
  _Clear() => this.edit.Text := ''

  Handle() {
    cmd := this.edit.Text
    if !cmd
      return this.AddHistory(false, '')
    if cmd.beginWith(';')
      doHist := false, cmd := cmd.substring(2)
    this.AddHistory(true, _truncatedString(cmd, 30))
    if (r := Mgr.Check(cmd)).valid {
      echo := Mgr.Call(r.handler, r.parsed)
      this.AddHistory(false, echo.r)
      if !IsSet(doHist) and echo.flag
        History.Add(cmd)
      switch echo.extra {
        case MeowTool.reoladFlag: return this._Reolad()
        case MeowTool.exitFlag: return this._Exit()
      }
    } else {
      this.AddHistory(false, r.msg '---' _truncatedString(cmd, 10))
    }
    this._Clear()

    _truncatedString(text, maxLen) => text.Length > maxLen ? (text.substring(1, maxLen) '...') : text

  }

  AddHistory(isInput, text) {
    this['His'].Value .= (isInput ? '<< ' : '>> ') text '`n'
    _fit(this.fontPixel), _autoClearHistory()

    _autoClearHistory() {
      static cnt := 0
      if ++cnt >= this.maxMsg
        this['His'].Text := '', Sleep(300), _fit(this.fontPixel * cnt, false), cnt := 0
    }

    _fit(pixel, inc := true) {
      this.GetClientPos(, , , &ch)
      if !inc {
        if ch - pixel <= 50
          pixel := ch - 55
        loop pixel
          this.Move(, , , ch - A_Index)
      } else loop pixel
        this.Move(, , , ch + A_Index)
    }
  }

}