#Requires AutoHotkey v2.0

#Include g:\AHK\gitee_ahk2\common\Path.ahk
#Include g:\AHK\gitee_ahk2\common\Theme.ahk

#Include ../core/handler.ahk
#Include ../core/re.ahk
#Include ../fs/history.ahk
#Include ./detail.ahk

hist := History()

up:: PlanEGui.SetContent(hist.Get())
down:: PlanEGui.SetContent(hist.Get(false))

class PlanEGui extends Gui {
  __New(config, title := '', opt := '') {
    super.__New('-Caption +Border +AlwaysOnTop +ToolWindow' opt, title, this)
    this.SetFont('s16', 'Consolas')
    this.config := config
    this.AddButton('w0 h0 xs Default').OnEvent('click', 'Handle')
    this.AddEdit('ym w300 h30 -Multi vSendBox', '')
    this.fontPixel := 23
    this.deadMsg := 30
  }

  AnimateHide(*) {
    this['MiniBtn'].GetPos(&wx, &wy, &ww, &wh)
    while GetKeyState("LButton", "P") {
      Sleep(10)
      if !GetKeyState('lButton', 'p') {
        CoordMode 'Mouse', 'Window'
        MouseGetPos(&nx, &ny)
        if nx > (wx - 10) and nx < (wx + ww + 10) and ny > (wy - 10) and ny < (wy + wh + 10) {
          this.GetClientPos(&cx, &cy, &cw, &ch)
          clientW := cw, clientH := ch
          while cw > 0
            this.Move(, , cw--,)
          WinSetTransparent(0, 'ahk_id' this.Hwnd)
          this.Move(cx, cy, clientW, clientH)
          this.Minimize()
          WinSetTransparent(255, 'ahk_id' this.Hwnd)
        }
      }
    }
  }

  static SetContent(content) {
    if content
      PlanEGui.ins['SendBox'].Text := content
  }

  static Show(config, *) {
    static ins := PlanEGui(config)
    PlanEGui.ins := ins
    ins.Show('Minimize NA')
    WinSetTransparent(0, 'ahk_id' ins.Hwnd)
    ins.Restore()
    ins.GetClientPos(, , , &ch)
    ins.Move(, A_ScreenHeight / 4, , 0)
    WinSetTransparent(255, 'ahk_id' ins.Hwnd)
    loop ch
      ins.Move(, , , A_Index)
    ins.AddText('xm+5 h800 w400 vHistory',)
    ins['History'].SetFont('s12')
    ControlFocus ins['SendBox'].Hwnd, "A"
    Theme.Builder().UseTheme(config.theme).Build().Apply(ins)
  }

  static Hide() {
    PlanEGui.ins.Hide()
  }

  static Resume() {
    PlanEGui.ins.Show()
  }

  Exit(*) {
    Sleep 1000
    this.GetClientPos(, , , &ch)
    while ch > 0
      this.Move(, , , ch--)
    ExitApp
  }

  _Reload() {
    Sleep 1000
    Reload()
  }

  Handle(*) {
    cmd := this['SendBox'].Text
    if !cmd {                                                   ; null input
      this.FitSize(this.fontPixel)
      this.AddHistory(false, '')                                ; just echo null
      return
    }
    doHist := true
    if cmd.beginWith(';') {
      doHist := false
      cmd := cmd.subString(2)
    }
    ret := Re.CheckVaild(cmd)                                   ; check vaild
    if ret.flag {                                               ; if vaild
      static h := Handler()
      this.FitSize(this.fontPixel)
      this.AddHistory(true, ret.msg)                            ; echo input
      result := h.Handle(cmd, ret.value)                        ; get handled result

      if result.needWindow || result.lineNum >= this.deadMsg / 2 {
        d := Detail(this.config, 'echo of ' ret.value, , 800)
        d.SetContent(result.msg)
        d.Show('y400')
        this.Wapper(this.fontPixel, false, 'see detail window')
      } else {                                                  ; echo result
        this.FitSize(this.fontPixel * result.lineNum)
        this.AddHistory(false, result.msg)
      }
      if doHist
        hist.AddHist(cmd)                                         ; append to history
      switch result.special {
        case 'x': this.Exit()                                   ; exit singal
        case 'r': this._Reload()                                ; reload singal
      }
    } else {                                                    ; invalid input
      TruncatedString(cmd, 10)                                 ; cut off
      this.Wapper(this.fontPixel, false, ret.msg '--' cmd)      ; print failure info
    }
    this.Clear()
  }

  Clear() {
    this['SendBox'].Text := ''
  }

  FitSize(pixel, desc := false) {
    if !pixel
      return
    this.GetClientPos(, , , &ch)
    if desc {
      if ch - pixel <= 50                     ; size of defalut state
        pixel := ch - 55
      loop pixel
        this.Move(, , , ch - A_Index)
    }
    else loop pixel
      this.Move(, , , ch + A_Index)
  }

  Wapper(size, isInput, text, operSub?) {
    this.FitSize(size, operSub?)
    this.AddHistory(isInput, text)
  }

  AddHistory(isInput, text) {
    prompt := isInput ? '<< ' : '>> '
    this['History'].Value .= prompt text '`n'
    this.AutoClearHistory()
  }

  AutoClearHistory() {
    static count := IsSet(count) || 0
    count++
    history := this['History'].Value
    newHis := SubStr(history, InStr(history, '`n') + 1,)
    if count >= this.deadMsg {
      this['History'].Value := newHis
      sleep 300
      this.FitSize(this.fontPixel * count, true)
      count := 0
    }
  }
}