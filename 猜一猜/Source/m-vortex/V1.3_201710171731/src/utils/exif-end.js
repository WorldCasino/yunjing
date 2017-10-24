(function () {
  var root = this
  var EXIF = function (obj) {
    if (obj instanceof EXIF) return obj
    if (!(this instanceof EXIF)) return new EXIF(obj)
    this.EXIFwrapped = obj
  }

  if (typeof exports !== 'undefined') {
    if (typeof module !== 'undefined' && module.exports) {
      exports = module.exports = EXIF
    }
    exports.EXIF = EXIF
  } else {
    root.EXIF = EXIF
  }
  function base64ToArrayBuffer (base64) {
    // var contentType = base64.match(/^data:([^;]+);base64,/mi)[1] || '' // 返回图片类型，如【image/jpeg】可删除该行
    var _base64 = base64.replace(/^data:([^;]+);base64,/gmi, '')
    var binary = atob(_base64)
    var len = binary.length
    var buffer = new ArrayBuffer(len)
    var view = new Uint8Array(buffer)
    for (var i = 0; i < len; i++) {
      view[i] = binary.charCodeAt(i)
    }

    return buffer
  }
  function findOrientationInJPEG (file) {
    var dataView = new DataView(file)
    if ((dataView.getUint8(0) !== 0xFF) || (dataView.getUint8(1) !== 0xD8)) {
      return false // not a valid jpeg
    }
    var offset = 2
    var length = file.byteLength
    var marker
    while (offset < length) {
      if (dataView.getUint8(offset) !== 0xFF) {
        return false // not a valid marker, something is wrong
      }
      marker = dataView.getUint8(offset + 1)
      if (marker === 225) {
        return readOrientationData(dataView, offset + 4)
      } else {
        offset += 2 + dataView.getUint16(offset + 2)
      }
    }
  }
  function getStringFromDB (buffer, start, length) {
    var outstr = ''
    for (var n = start; n < start + length; n++) {
      outstr += String.fromCharCode(buffer.getUint8(n))
    }
    return outstr
  }
  function readOrientationData (file, start) {
    if (getStringFromDB(file, start, 4) !== 'Exif') {
      return false
    }
    var bigEnd
    var tiffOffset = start + 6
    if (file.getUint16(tiffOffset) === 0x4949) {
      bigEnd = false
    } else if (file.getUint16(tiffOffset) === 0x4D4D) {
      bigEnd = true
    } else {
      return false
    }
    if (file.getUint16(tiffOffset + 2, !bigEnd) !== 0x002A || file.getUint32(tiffOffset + 4, !bigEnd) < 0x00000008) {
      return false
    }
    var numValues = file.getUint32(44, !bigEnd)
    var valueOffset = file.getUint32(48, !bigEnd) + tiffOffset
    var offset
    var vals
    if (numValues === 1) {
      return file.getUint16(48, !bigEnd)
    } else {
      offset = numValues > 2 ? valueOffset : (48)
      vals = []
      for (var n = 0; n < numValues; n++) {
        vals[n] = file.getUint16(offset + 2 * n, !bigEnd)
      }
      return vals
    }
  }
  EXIF.getOrientation = function (img) {
    if (/^data:/i.test(img.src || img)) {
      var arrayBuffer = base64ToArrayBuffer(img.src || img)
      return findOrientationInJPEG(arrayBuffer)
    } else {
      return false
    }
  }
}.call(this))
