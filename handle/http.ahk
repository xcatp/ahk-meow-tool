#Include baseHandle.ahk
#Include G:\AHK\git-ahk-lib\util\net\WinHttpRequest.ahk

class Http extends baseHandle {

  static Handle(parsed) {
    method := parsed.kvparams['X'] || 'GET'
    data := parsed.kvparams['d'] || unset
    header := parsed.kvparams['H'] || []
    headers := {}
    for v in header
      _ := InStr(v, ':'), headers[Trim(v.substring(1, _))] := Trim(v.substring(_ + 1))
    res := WinHttpRequest().request(parsed.target, method, data?, headers)
    return this.Succ(res, 'e')
  }

  static Echo() => '
  (
    http
    http [-X=?] [-d=?] [-H=?] url
    发送 HTTP 请求。
  )'
}