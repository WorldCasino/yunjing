import Datepick from './date.vue'
var myDate = {}
myDate.install = function (Vue) {
  var Datecomp = Vue.extend(Datepick)
  Vue.prototype.$Datepick = function (options) {
    var vm = new Datecomp().$mount()
    if (typeof options === 'object') {
      for (var k in options) {
        if (options[k]) {
          vm[k] = options[k]
        }
      }
    }
    document.body.appendChild(vm.$el)
  }
}
export default myDate
