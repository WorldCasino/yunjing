// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import Vuex from 'vuex'
import App from './App'
import router from './router'
import store from './store/'
import Framework7 from 'framework7'
import Framework7Vue from 'framework7-vue'
import VueLazyLoad from 'vue-lazyload'
import VueAwesomeSwiper from 'vue-awesome-swiper'
import confirm from './plugin/confirm'
import myDate from './plugin/datepick'
import chatInput from './plugin/chatInput'

Vue.prototype.$dm = {}
Vue.prototype.$dm.confirm = confirm

Vue.use(VueAwesomeSwiper)
Vue.use(Vuex)
Vue.use(myDate)
Vue.use(chatInput)
// Import F7 iOS Theme Styles
import Framework7Theme from 'framework7/dist/css/framework7.ios.min.css'
import Framework7ThemeColors from 'framework7/dist/css/framework7.ios.colors.min.css'
// OR for Material Theme:
// import Framework7Theme from 'framework7/dist/css/framework7.material.min.css'
// import Framework7ThemeColors from 'framework7/dist/css/framework7.material.colors.min.css'

Vue.use(Framework7Vue)

Vue.use(VueLazyLoad)

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  // router,
  store,
  template: '<App/>',
  framework7: {
    root: '#app',
    routes: router
  },
  components: { App }
})

// 自定义指令

Vue.directive('@css', {
// 事件改变元素css属性的指令：传入一个对象{style: String, isUse: Boolean}
  bind (el, binding, vnode) {
    if (binding.value['isUse'] !== false) {
      // console.log('指令作用起了', binding.value['style'])
      if (binding.arg) {
        el.addEventListener(binding.arg, function () {
          el.style.cssText = binding.value['style']
        })
      }
    }
  }
})
