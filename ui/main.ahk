#Requires AutoHotkey v2.0

#Include g:\AHK\git-ahk-lib\Extend.ahk
#Include g:\AHK\git-ahk-lib\Tip.ahk
#Include g:\AHK\git-ahk-lib\util\Cursor.ahk
#Include g:\AHK\git-ahk-lib\Theme.ahk
#Include g:\AHK\git-ahk-lib\util\Animation.ahk
#Include g:\AHK\git-ahk-lib\util\config\MeowConf.ahk
#Include g:\AHK\git-ahk-lib\util\config\MeowConfEx.ahk

#Include ../core/handleMgr.ahk
#Include ../core/historyMgr.ahk

~up:: MeowTool.SetContent(History.Get())
~down:: MeowTool.SetContent(History.Get(false))
^Right:: MeowTool.ins._DisplayExtraArea()
^Left::MeowTool.ins._HideExtraArea()

class MeowTool extends Gui {

  static ins := MeowTool(), exitFlag := 'x', reoladFlag := 'r', extraFlag := 'e'
    , maxMsg := 20, maxLen := 30, maxH := 800

  class Green extends Theme.Themes {
    __New() {
      super.__New()
      this.window_Bgc := '#eff6da', this.default_Fc := '#003711'
      this.edit_Fc := '#264b0c', this.edit_Bgc := '#fafff4'
    }
  }

  __New() {
    super.__New('+AlwaysOnTop +ToolWindow -Caption +Border')
    this.SetFont('s16', 'Consolas')
    this.AddButton('w0 h0 xs Default').OnEvent('click', (*) => this.Handle())
    this.edit := this.AddEdit('section xm ym w300 h30 -Multi')
    this.sbtn := this.AddText('yp w25 ym+3 x+2', '·')
    this.sbtn.OnEvent('ContextMenu', (*) => this._ToggleExtraArea())
    this.h := 65, this.hh := 55, this.l := [], this.SetFont('s13')
    this.extra := this.AddEdit('w300 h30 yp-3 x+2 Multi'), this.extra.Visible := false
    this.SetFont('s12'), this.fc := Theme.Custom(this, MeowTool.Green()).default_Fc
  }

  static SetContent(content) => content && MeowTool.ins.edit.Text := content
  static Hide() => MeowTool.ins.Hide()
  static Resume() => MeowTool.ins.Show()

  static Show() {
    Animation.RollDown(MeowTool.ins, Noop, (*) => MeowTool.ins.Move(A_ScreenWidth / 2 - 171, A_ScreenHeight / 4, 342, 55))
    ControlFocus(MeowTool.ins.edit.Hwnd, "A"), FrameShadow(MeowTool.ins.Hwnd)

    FrameShadow(hwnd) {
      DllCall("dwmapi\DwmExtendFrameIntoClientArea", "ptr", hwnd, "ptr", Buffer(16, 0))
      DllCall("dwmapi\DwmSetWindowAttribute", "ptr", hwnd, "uint", 2, "int*", 2, "uint", 4)
    }
  }

  _DisplayExtraArea() => (this._ChangeW(672), this.sbtn.Text := '<<', this.extra.Visible := true)
  _HideExtraArea() => (this._ChangeW(342), this.sbtn.Text := '·', this.extra.Visible := false)
  _SetExtraAreaContent(v) => v && this.extra.Value := v
  _ToggleExtraArea() => this.extra.Visible ? this._HideExtraArea() : this._DisplayExtraArea()


  _ChangeW(_w) {
    this.GetPos(, , &w)
    loop Abs(_w - w)
      this.Move(, , w + A_Index * (_w > w ? 1 : -1))
  }

  _Exit() => (Sleep(1000), Animation.RollUp(MeowTool.ins), ExitApp())
  _Reolad() => (Sleep(1000), Reload())
  _Clear() => this.edit.Text := ''

  Handle() {
    cmd := Trim(this.edit.Text)
    if cmd.beginWith(';')
      doHist := false, cmd := cmd.substring(2)
    if !cmd {
      this.AddHistory(false, '')
      return
    }

    this.AddHistory(true, _truncatedString(cmd, 27))
    if (r := Mgr.Check(cmd)).valid {
      echo := Mgr.Call(r.handler, r.parsed)
      if !IsSet(doHist) and echo.flag
        History.Add(cmd)
      switch echo.extra {
        case MeowTool.reoladFlag: return this._Reolad()
        case MeowTool.exitFlag: return this._Exit()
        case MeowTool.extraFlag:
          this._DisplayExtraArea(), this._SetExtraAreaContent(echo.r)
          this.AddHistory(false, 'see extra.', echo.flag)
        default: this.AddHistory(false, echo.r, echo.flag)
      }
    } else this.AddHistory(false, r.msg '---' _truncatedString(cmd, 10))
    this._Clear()

    _truncatedString(text, maxLen) => text.Length > maxLen ? (text.substring(1, maxLen) '...') : text
  }

  OnCopy(g, *) {
    A_Clipboard := g.raw
    Tip.ShowTip('copied!', Cursor.x + 10, Cursor.y + 10, 2000)
  }

  AddHistory(isInput, text, succ := true) {
    t := _slice(text, (ml := MeowTool.maxLen) - 1), this._SetExtraAreaContent(text)

    tb := this.AddText('h20 xs y' this.hh + 2 ' Background' (isInput ? 'b6e8b6' : succ ? 'b4d4e1' : 'e8bfbf')
      , (isInput ? '<< ' : succ ? '>> ' : '>| ') . '`n---'.repeat(t.count('`n')))

    ta := this.AddText('Backgroundcfe6bc w271 x+2 c' this.fc, t)
    ta.OnEvent('ContextMenu', (v, *) => this.OnCopy(v)), ta.GetPos(, &y, , &h)
    this.hh += (h + 2), this.l.push(ta, tb), ta.raw := text

    _autoClearHistory(h)

    _slice(t, l) {
      return StrSplit(t, '`n').reduce((acc, cur) => acc . _c(cur, 1), '').RTrim('`n')
      _c(v, i) => _t(v) - i <= l ? SubStr(v, i) '`n' : SubStr(v, i, _l := _s(v, i)) '`n' _c(v, i + _l)
      _t(str) => str.toCharArray().reduce((acc, cur) => acc += IsHan(cur) ? 2.2 : 1, 0)
      _s(v, i) => _t(a := SubStr(v, i, l)) <= l ? l : (j := 0, Array.from(a).findIndex(c => (j += IsHan(c) ? 2.2 : 1) >= l))
    }

    _autoClearHistory(_h) {
      if this.l.Length > MeowTool.maxMsg * 2
        _doDelete()
      else _doFit(_h)

      _h := 0
      while this.h > MeowTool.maxH && this.l.Length > 2
        _doDelete()

      _doFit(_h, incr := true) {
        ch := this.h
        if incr {
          loop _h + 2
            this.Move(, , , ch + A_Index)
          this.h += _h + 2
        } else {
          loop _h
            this.Move(, , , ch - A_Index)
          this.h -= _h
        }
        this.extra.Move(, , , this.h - 22)
      }

      _doDelete() {
        i := this.l[1], j := this.l[2], i.GetPos(, , , &h)

        loop 50 {
          if (Mod(A_Index, 3) = 0)
            Sleep 1
          i.Move(, , , h - A_Index)
          j.Move(, , , h - A_Index)
        }

        i.Visible := false, j.Visible := false

        this.l.RemoveAt(1), this.l.RemoveAt(1)

        this.l.foreach(v => Move(v, h + 2))
        this.hh -= (h + 2), FitIfNeed(h + 2)

        Move(v, offset) {
          v.GetPos(, &y), v.Move(, y - offset)
        }

        FitIfNeed(vh) {
          if _h <= vh && this.h >= this.hh {
            Sleep 100
            _doFit(this.h - this.hh - 10, false)
            return
          }
          if this.h < this.hh {
            Sleep 100
            _doFit(_h - vh)
          }
        }
      }
    }
  }

}