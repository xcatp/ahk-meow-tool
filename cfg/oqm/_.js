var t = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  , n = {
    rotl: function (e, t) {
      return e << t | e >>> 32 - t
    },
    rotr: function (e, t) {
      return e << 32 - t | e >>> t
    },
    endian: function (e) {
      if (e.constructor == Number)
        return 16711935 & n.rotl(e, 8) | 4278255360 & n.rotl(e, 24);
      for (var t = 0; t < e.length; t++)
        e[t] = n.endian(e[t]);
      return e
    },
    randomBytes: function (e) {
      for (var t = []; e > 0; e--)
        t.push(Math.floor(256 * Math.random()));
      return t
    },
    bytesToWords: function (e) {
      for (var t = [], n = 0, r = 0; n < e.length; n++,
        r += 8)
        t[r >>> 5] |= e[n] << 24 - r % 32;
      return t
    },
    wordsToBytes: function (e) {
      for (var t = [], n = 0; n < 32 * e.length; n += 8)
        t.push(e[n >>> 5] >>> 24 - n % 32 & 255);
      return t
    },
    bytesToHex: function (e) {
      for (var t = [], n = 0; n < e.length; n++)
        t.push((e[n] >>> 4).toString(16)),
          t.push((15 & e[n]).toString(16));
      return t.join("")
    },
    hexToBytes: function (e) {
      for (var t = [], n = 0; n < e.length; n += 2)
        t.push(parseInt(e.substr(n, 2), 16));
      return t
    },
    bytesToBase64: function (e) {
      for (var n = [], r = 0; r < e.length; r += 3)
        for (var o = e[r] << 16 | e[r + 1] << 8 | e[r + 2], a = 0; a < 4; a++)
          8 * r + 6 * a <= 8 * e.length ? n.push(t.charAt(o >>> 6 * (3 - a) & 63)) : n.push("=");
      return n.join("")
    },
    base64ToBytes: function (e) {
      e = e.replace(/[^A-Z0-9+\/]/gi, "");
      for (var n = [], r = 0, o = 0; r < e.length; o = ++r % 4)
        0 != o && n.push((t.indexOf(e.charAt(r - 1)) & Math.pow(2, -2 * o + 8) - 1) << 2 * o | t.indexOf(e.charAt(r)) >>> 6 - 2 * o);
      return n
    }
  };


var oo = {
  utf8: {
    stringToBytes: function (e) {
      return oo.bin.stringToBytes(unescape(encodeURIComponent(e)))
    },
    bytesToString: function (e) {
      return decodeURIComponent(escape(oo.bin.bytesToString(e)))
    }
  },
  bin: {
    stringToBytes: function (e) {
      for (var t = [], n = 0; n < e.length; n++)
        t.push(255 & e.charCodeAt(n));
      return t
    },
    bytesToString: function (e) {
      for (var t = [], n = 0; n < e.length; n++)
        t.push(String.fromCharCode(e[n]));
      return t.join("")
    }
  }
};

var r = oo.utf8, a = oo.bin;

var tt = n

var u = function (e, n) {

  e.constructor == String ? e = n && "binary" === n.encoding ? a.stringToBytes(e) : r.stringToBytes(e) : o(e) ? e = Array.prototype.slice.call(e, 0) : Array.isArray(e) || e.constructor === Uint8Array || (e = e.toString());
  for (var i = tt.bytesToWords(e), l = 8 * e.length, f = 1732584193, c = -271733879, s = -1732584194, d = 271733878, p = 0; p < i.length; p++)
    i[p] = 16711935 & (i[p] << 8 | i[p] >>> 24) | 4278255360 & (i[p] << 24 | i[p] >>> 8);
  i[l >>> 5] |= 128 << l % 32,
    i[14 + (l + 64 >>> 9 << 4)] = l;
  var v = u._ff
    , h = u._gg
    , y = u._hh
    , m = u._ii;
  for (p = 0; p < i.length; p += 16) {
    var g = f
      , b = c
      , _ = s
      , w = d;
    f = v(f, c, s, d, i[p + 0], 7, -680876936),
      d = v(d, f, c, s, i[p + 1], 12, -389564586),
      s = v(s, d, f, c, i[p + 2], 17, 606105819),
      c = v(c, s, d, f, i[p + 3], 22, -1044525330),
      f = v(f, c, s, d, i[p + 4], 7, -176418897),
      d = v(d, f, c, s, i[p + 5], 12, 1200080426),
      s = v(s, d, f, c, i[p + 6], 17, -1473231341),
      c = v(c, s, d, f, i[p + 7], 22, -45705983),
      f = v(f, c, s, d, i[p + 8], 7, 1770035416),
      d = v(d, f, c, s, i[p + 9], 12, -1958414417),
      s = v(s, d, f, c, i[p + 10], 17, -42063),
      c = v(c, s, d, f, i[p + 11], 22, -1990404162),
      f = v(f, c, s, d, i[p + 12], 7, 1804603682),
      d = v(d, f, c, s, i[p + 13], 12, -40341101),
      s = v(s, d, f, c, i[p + 14], 17, -1502002290),
      f = h(f, c = v(c, s, d, f, i[p + 15], 22, 1236535329), s, d, i[p + 1], 5, -165796510),
      d = h(d, f, c, s, i[p + 6], 9, -1069501632),
      s = h(s, d, f, c, i[p + 11], 14, 643717713),
      c = h(c, s, d, f, i[p + 0], 20, -373897302),
      f = h(f, c, s, d, i[p + 5], 5, -701558691),
      d = h(d, f, c, s, i[p + 10], 9, 38016083),
      s = h(s, d, f, c, i[p + 15], 14, -660478335),
      c = h(c, s, d, f, i[p + 4], 20, -405537848),
      f = h(f, c, s, d, i[p + 9], 5, 568446438),
      d = h(d, f, c, s, i[p + 14], 9, -1019803690),
      s = h(s, d, f, c, i[p + 3], 14, -187363961),
      c = h(c, s, d, f, i[p + 8], 20, 1163531501),
      f = h(f, c, s, d, i[p + 13], 5, -1444681467),
      d = h(d, f, c, s, i[p + 2], 9, -51403784),
      s = h(s, d, f, c, i[p + 7], 14, 1735328473),
      f = y(f, c = h(c, s, d, f, i[p + 12], 20, -1926607734), s, d, i[p + 5], 4, -378558),
      d = y(d, f, c, s, i[p + 8], 11, -2022574463),
      s = y(s, d, f, c, i[p + 11], 16, 1839030562),
      c = y(c, s, d, f, i[p + 14], 23, -35309556),
      f = y(f, c, s, d, i[p + 1], 4, -1530992060),
      d = y(d, f, c, s, i[p + 4], 11, 1272893353),
      s = y(s, d, f, c, i[p + 7], 16, -155497632),
      c = y(c, s, d, f, i[p + 10], 23, -1094730640),
      f = y(f, c, s, d, i[p + 13], 4, 681279174),
      d = y(d, f, c, s, i[p + 0], 11, -358537222),
      s = y(s, d, f, c, i[p + 3], 16, -722521979),
      c = y(c, s, d, f, i[p + 6], 23, 76029189),
      f = y(f, c, s, d, i[p + 9], 4, -640364487),
      d = y(d, f, c, s, i[p + 12], 11, -421815835),
      s = y(s, d, f, c, i[p + 15], 16, 530742520),
      f = m(f, c = y(c, s, d, f, i[p + 2], 23, -995338651), s, d, i[p + 0], 6, -198630844),
      d = m(d, f, c, s, i[p + 7], 10, 1126891415),
      s = m(s, d, f, c, i[p + 14], 15, -1416354905),
      c = m(c, s, d, f, i[p + 5], 21, -57434055),
      f = m(f, c, s, d, i[p + 12], 6, 1700485571),
      d = m(d, f, c, s, i[p + 3], 10, -1894986606),
      s = m(s, d, f, c, i[p + 10], 15, -1051523),
      c = m(c, s, d, f, i[p + 1], 21, -2054922799),
      f = m(f, c, s, d, i[p + 8], 6, 1873313359),
      d = m(d, f, c, s, i[p + 15], 10, -30611744),
      s = m(s, d, f, c, i[p + 6], 15, -1560198380),
      c = m(c, s, d, f, i[p + 13], 21, 1309151649),
      f = m(f, c, s, d, i[p + 4], 6, -145523070),
      d = m(d, f, c, s, i[p + 11], 10, -1120210379),
      s = m(s, d, f, c, i[p + 2], 15, 718787259),
      c = m(c, s, d, f, i[p + 9], 21, -343485551),
      f = f + g >>> 0,
      c = c + b >>> 0,
      s = s + _ >>> 0,
      d = d + w >>> 0
  }
  return tt.endian([f, c, s, d])
};



u._ff = function (e, t, n, r, o, a, u) {
  var i = e + (t & n | ~t & r) + (o >>> 0) + u;
  return (i << a | i >>> 32 - a) + t
}

u._gg = function (e, t, n, r, o, a, u) {
  var i = e + (t & r | n & ~r) + (o >>> 0) + u;
  return (i << a | i >>> 32 - a) + t
}

u._hh = function (e, t, n, r, o, a, u) {
  var i = e + (t ^ n ^ r) + (o >>> 0) + u;
  return (i << a | i >>> 32 - a) + t
}

u._ii = function (e, t, n, r, o, a, u) {
  var i = e + (n ^ (t | ~r)) + (o >>> 0) + u;
  return (i << a | i >>> 32 - a) + t
}

u._blocksize = 16, u._digestsize = 16


const key = 'fjc_xhup'

function genSign(searchWord) {
  return tt.bytesToHex(tt.wordsToBytes(u(key + searchWord, undefined)))
}
