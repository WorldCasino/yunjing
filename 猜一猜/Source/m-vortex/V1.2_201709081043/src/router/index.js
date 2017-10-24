import Vue from 'vue'
// import Router from 'vue-router'
// import Hello from '@/components/Hello'

// Vue.use(Router)

// export default new Router({
//   routes: [
//     {
//       path: '/',
//       name: 'Hello',
//       component: Hello
//     }
//   ]
// })

// framework7 style router
export default [
  {
    path: '/about/',
    component: require('../pages/about.vue')
  },
  {
    path: '/homepage/',
    component: require('../pages/homepage/homepage.vue')
  },
  {
    path: '/quiz-player',
    component: require('../pages/homepage/quiz-player.vue')
  },
  {
    path: '/quiz-players',
    component: require('../pages/homepage/quiz-players.vue')
  },
  {
    path: '/quiz-detail',
    component: require('../pages/homepage/quiz-detail.vue')
  },
  {
    path: '/hello/',
    component: require('../pages/Hello.vue')
  },
  {
    path: '/mine-gold/',
    component: require('../pages/mine/mine-gold.vue')
  },
  {
    path: '/mine-goldbean/',
    component: require('../pages/mine/mine-goldbean.vue')
  },
  {
    path: '/mine-goldbean-detail/',
    component: require('../pages/mine/mine-goldbean-detail.vue')
  },
  {
    path: '/mine-gold-all',
    component: require('../pages/mine/mine-gold-all.vue')
  },
  {
    path: '/mine-info/',
    component: require('../pages/mine/mine-info.vue')
  },
  {
    path: '/mine-nickname/',
    component: require('../pages/mine/mine-nickname.vue')
  },
  {
    path: '/mine-sex/',
    component: require('../pages/mine/mine-sex.vue')
  },
  {
    path: '/mine-mobile/',
    component: require('../pages/mine/mine-mobile.vue')
  },
  {
    path: '/pub-guess-set/',
    component: require('../pages/guess/pubguess-set.vue')
  },
  {
    path: '/pub-guess-set-copy/',
    component: require('../pages/guess/pubguess-set-copy.vue')
  },
  {
    path: '/store/',
    component: require('../pages/store/store.vue')
  },
  {
    path: '/store-detail/',
    component: require('../pages/store/store-detail.vue')
  },
  {
    path: '/store-convert/',
    component: require('../pages/store/store-convert.vue')
  },
  {
    path: '/login-choose/',
    component: require('../pages/register&login/login-choose.vue')
  },
  {
    path: '/login-phone/',
    component: require('../pages/register&login/login-phone.vue')
  },
  {
    path: '/login-fill-info/',
    component: require('../pages/register&login/login-fill-info.vue')
  },
  {
    path: '/login-verify/',
    component: require('../pages/register&login/login-verify.vue')
  },
  {
    path: '/rank/',
    component: require('../pages/homepage/rank.vue')
  },
  {
    path: '/buy-gold/',
    component: require('../pages/mine/buy-gold.vue')
  },
  {
    path: '/buy-gold-iap',
    component: require('../pages/mine/buy-gold-iap.vue')
  },
  {
    path: '/buy-gold-app',
    component: require('../pages/mine/buy-gold-app.vue')
  },
  {
    path: '/setting/',
    component: require('../pages/mine/setting.vue')
  },
  {
    path: '/setting-contact/',
    component: require('../pages/mine/setting-contact.vue')
  },
  {
    path: '/setting-about/',
    component: require('../pages/mine/setting-about.vue')
  },
  {
    path: '/setting-help/',
    component: require('../pages/mine/setting-help.vue')
  },
  {
    path: '/mine-publish/',
    component: require('../pages/mine/mine-publish.vue')
  },
  {
    path: '/user-agreement/',
    component: require('../pages/mine/user-agreement.vue')
  },
  {
    path: '/setting-message/',
    component: require('../pages/mine/setting-message.vue')
  },
  {
    path: '/help-bet/',
    component: require('../pages/mine/help-bet.vue')
  },
  {
    path: '/help-exchange/',
    component: require('../pages/mine/help-exchange.vue')
  },
  {
    path: '/make-goldbean/',
    component: require('../pages/task/task-makebean.vue')
  }
]
