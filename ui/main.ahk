#Requires AutoHotkey v2.0

#Include g:\AHK\git-ahk-lib\Extend.ahk
#Include g:\AHK\git-ahk-lib\Theme.ahk
#Include g:\AHK\git-ahk-lib\util\Animation.ahk

#Include ../core/handleMgr.ahk
#Include ../core/historyMgr.ahk

up:: MeowTool.SetContent(History.Get())
down:: MeowTool.SetContent(History.Get(false))

class MeowTool extends Gui {

  static ins := MeowTool(), exitFlag := 'x', reoladFlag := 'r', maxMsg := 30, maxLen := 30

  class Green extends Theme.Themes {
    __New() {
      super.__New()
      this.window_Bgc := '#eff6da', this.default_Fc := '#426800'
      this.edit_Fc := '#264b0c', this.edit_Bgc := '#fafff4'
    }
  }

  __New() {
    super.__New('+AlwaysOnTop +ToolWindow -Caption +Border')
    this.SetFont('s16', 'Consolas')
    this.AddButton('w0 h0 xs Default').OnEvent('click', (*) => this.Handle())
    this.edit := this.AddEdit('ym w300 h30 -Multi')
    this.fontPixel := 21, this.SetFont('s12'), this.fc := Theme.Custom(this, MeowTool.Green()).default_Fc
  }

  static SetContent(content) => content && MeowTool.ins.edit.Text := content
  static Hide() => MeowTool.ins.Hide()
  static Resume() => MeowTool.ins.Show()

  static Show() {
    Animation.RollDown(MeowTool.ins, Noop, (*) => MeowTool.ins.Move(, A_ScreenHeight / 4))
    static _ := MeowTool.ins.AddText('xm h800 w300 vHis c' MeowTool.ins.fc)
    ControlFocus(MeowTool.ins.edit.Hwnd, "A"), FrameShadow(MeowTool.ins.Hwnd)

    FrameShadow(hwnd) {
      DllCall("dwmapi\DwmIsCompositionEnabled", "int*", &enabled := 0)
      if !enabled
        DllCall("SetClassLong", "uint", hwnd, "int", -26, "int", 0x20000)
      else {
        DllCall("dwmapi\DwmExtendFrameIntoClientArea", "ptr", hwnd, "ptr", Buffer(16, 0))
        DllCall("dwmapi\DwmSetWindowAttribute", "ptr", hwnd, "uint", 2, "int*", 2, "uint", 4)
      }
    }
  }

  _Exit() => (Sleep(1000), Animation.RollUp(MeowTool.ins), ExitApp())
  _Reolad() => (Sleep(1000), Reload())
  _Clear() => this.edit.Text := ''

  Handle() {
    cmd := Trim(this.edit.Text)
    if !cmd
      return this.AddHistory(false, '')
    if cmd.beginWith(';')
      doHist := false, cmd := cmd.substring(2)
    this.AddHistory(true, _truncatedString(cmd, 27))
    if (r := Mgr.Check(cmd)).valid {
      echo := Mgr.Call(r.handler, r.parsed)
      this.AddHistory(false, echo.r, echo.flag)
      if !IsSet(doHist) and echo.flag
        History.Add(cmd)
      switch echo.extra {
        case MeowTool.reoladFlag: return this._Reolad()
        case MeowTool.exitFlag: return this._Exit()
      }
    } else this.AddHistory(false, r.msg '---' _truncatedString(cmd, 10))
    this._Clear()

    _truncatedString(text, maxLen) => text.Length > maxLen ? (text.substring(1, maxLen) '...') : text
  }

  AddHistory(isInput, text, succ := true) {
    this['His'].Value .= (isInput ? '<< ' : succ ? '>> ' : '>| ') _slice(text, (ml := MeowTool.maxLen) - 1) '`n'
    _fit(this.fontPixel * _cacl(text)), _autoClearHistory()

    _slice(t, l) {
      return StrSplit(t, '`n').reduce((acc, cur) => acc . _c(cur, 1), '').RTrim('`n').replace('`n', '`n---')
      _c(v, i) => _t(v) - i <= l ? SubStr(v, i) '`n' : SubStr(v, i, _l := _s(v, i)) '`n' _c(v, i + _l)
      _t(str) => str.toCharArray().reduce((acc, cur) => acc += IsHan(cur) ? 2 : 1, 0)
      _s(v, i) => _t(a := SubStr(v, i, l)) <= l ? l : (j := 0, Array.from(a).findIndex(c => (j += IsHan(c) ? 2 : 1) >= l))
    }
    _cacl(t) => StrSplit(t, '`n').reduce((acc, cur) => ((cur.Length + ml - 1) // ml + acc), 0)

    _autoClearHistory() {
      static cnt := 0
      if ++cnt >= MeowTool.maxMsg
        this['His'].Text := '', Sleep(300), _fit(this.fontPixel * cnt, false), cnt := 0
    }

    _fit(pixel, inc := true) {
      this.GetClientPos(, , , &ch)
      if !inc {
        if ch - pixel <= 54
          pixel := ch - 54
        loop pixel
          this.Move(, , , ch - A_Index)
      } else loop pixel
        this.Move(, , , ch + A_Index)
    }
  }

}