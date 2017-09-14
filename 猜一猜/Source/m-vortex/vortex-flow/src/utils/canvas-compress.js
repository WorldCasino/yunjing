
export function getBlobImage (img, rate, quantity, rotate) {
  let canvas = document.createElement('canvas')
  let ctx = canvas.getContext('2d')

  console.log('原始尺寸')
  console.log(img.width)
  console.log(img.height)

  // 让图片宽高先缩放rate倍。且高或者宽最大不超过600
  /* let maxLength = 600
  let ratio = img.width / img.height

  var compWidth = img.width * rate
  var compHeight = img.height * rate
  if (compWidth > maxLength || compHeight > maxLength) {
    if (compWidth > compHeight) {
      compWidth = maxLength
      compHeight = compWidth / ratio
    } else {
      compHeight = maxLength
      compWidth = compHeight * ratio
    }
  } */

  // 让图片最大宽不超过600,高等比例缩小
  let maxLength = 640
  let ratio = img.width / img.height

  let compWidth = img.width
  let compHeight = img.height
  if (compWidth > maxLength) {
    compWidth = maxLength
    compHeight = compWidth / ratio
  }

  canvas.width = compWidth
  canvas.height = compHeight

  // console.log('canvas', rotate)
  if (rotate === Math.PI / 2) {
    canvas.width = compHeight
    canvas.height = compWidth
    ctx.translate(compHeight, 0)
    ctx.rotate(rotate)
  }

  /* 传来的rotate值与方向角的关系，日后测试遇到其他方向角问题，可添加判断
    this.rotate = false
  if (orientation === 8) {
    this.rotate = -Math.PI / 2
  } else if (orientation === 6) {
    this.rotate = Math.PI / 2
  } else if (orientation === 3) {
    this.rotate = -Math.PI
  } */

  ctx.drawImage(img, 0, 0, img.width, img.height, 0, 0, compWidth, compHeight)

  let dataUrl
  if (typeof quantity === 'undefined') {
    dataUrl = canvas.toDataURL('image/jpeg')
  } else {
    dataUrl = canvas.toDataURL('image/jpeg', quantity)
  }
  let size = dataUrl.length / 1024
  let qt = quantity || 1
  while (size > 60) {
    qt = (qt * 10 - 1) / 10
    if (qt === 0) { break }
    dataUrl = canvas.toDataURL('image/jpeg', qt)
    size = dataUrl.length / 1024
  }

  console.log('压缩后尺寸')
  console.log(compWidth)
  console.log(compHeight)

  console.log('压缩质量')
  console.log(quantity)
  console.log('压缩大小', dataUrl.length / 1024 + 'k', qt)

  // return dataUrl
  // base64 to blob
  let arr = dataUrl.split(',')
  let mime = arr[0].match(/:(.*?);/)[1]
  let bstr = atob(arr[1])
  let n = bstr.length
  let u8arr = new Uint8Array(n)
  while (n--) {
    u8arr[n] = bstr.charCodeAt(n)
  }
  return new Blob([u8arr], {type: mime})
}
