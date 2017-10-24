export function numberFormat (num) {
  var str = String(num)
  if (str.length <= 3) {
    return str 
  }
  var arr = str.split('').reverse()
  for (var i = 0; i < arr.length; i++) {
    if ((i + 1) % 3 === 0 && (i + 1) !== arr.length) {
      arr[i] = ',' + arr[i]
    }
  }
  return arr.reverse().join('')
}
