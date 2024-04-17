#Requires AutoHotkey v2.0

class baseHandle {

  static Handle(parsedObj) => baseHandle.Result(true, '')
  static Succ(r, extra := '') => { flag: true, r: r, extra: extra }
  static Fail(r, extra := '') => { flag: false, r: r, extra: extra }

}