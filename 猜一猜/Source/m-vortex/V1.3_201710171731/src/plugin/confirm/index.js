import Vue from 'vue'
import confirm from './components/confirm.vue'

let MyMsgConstructor = Vue.extend(confirm)

let instance

var MyMsg = (options = {}) => {
  // 如果confirm还在，则不再执行
  if (document.getElementsByClassName('dm-confirm').length) {
    return
  }
  instance = new MyMsgConstructor({
    data: {
      options: options,
      title: options.title || '请填写title',
      mes: options.mes || '请填写mes',
      isChecked: typeof options.checked === 'boolean' ? options.checked : 'noChecked', // 传入Boolean，默认状态是否勾选  :可选可不选
      btnType: options.btnType || 'default',  // 可选可不选，添加了'bet'的样式
      btnText: options.btnText || '确定',  // 按钮文案
      textAlign: options.textAlign || 'center',
      goldConf: !isNaN(options.goldConf) ? options.goldConf : 'noGoldConf', // 可选可不选，下注金币类型：0 金币， 1金豆
      enableBean: typeof options.enableBean === 'boolean' ? options.enableBean : true, // 传入Boolean: 默认状态可选择金豆或金币 :可选可不选
      checks: Array.isArray(options.checks) ? options.checks : 'noChecks'
    },
    methods: {
      confirmCb: options.confirmCb || function () {}, // 可选可不选
      cancelCb: options.cancelCb || function () {}  // 可选可不选
    }
  })
// 如果 Vue 实例在实例化时没有收到 el 选项，则它处于“未挂载”状态，没有关联的 DOM 元素。可以使用 vm.$mount() 手动地挂载一个未挂载的实例。
  let el = instance.$mount().$el
  document.body.appendChild(el)
  return instance
}

export default MyMsg
