import component from './index.vue'
var Input = {}

Input.install = function (Vue) {
  var ChatInput = Vue.extend(component)
  var vm = new ChatInput().$mount()
  Vue.prototype.$message = function (obj = {}) {
    Object.keys(obj).map(function (val) {
      vm[val] = obj[val]
    })
    document.getElementById('page-detail').appendChild(vm.$el)
  }
  Vue.prototype.$message.remove = function () {
    document.getElementById('page-detail').removeChild(vm.$el)
  }
}
export default Input
