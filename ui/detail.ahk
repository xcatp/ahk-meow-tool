#Include g:\AHK\gitee_ahk2\common\Theme.ahk

class Detail extends Gui {
  __New(config, title := 'detail', readOnly := false, w := 600, h := 500) {
    super.__New('+AlwaysOnTop', title)
    this.SetFont('s16', 'Consolas')
    this.content := this.AddEdit('xp h' h ' w' w (readOnly ? ' ReadOnly' : ''), '')
    ControlFocus(this.content)
    Theme.Builder().UseTheme(config.theme).Build().Apply(this)
  }

  SetContent(content) {
    this.content.Value := content
  }
}