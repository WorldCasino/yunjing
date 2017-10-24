/**
 * Created by Damon on 2017/10/9.
 * Description: 主页、体育(足球、篮球),详情页的下注逻辑公共部分
 *
 */

import { mapState, mapGetters, mapActions } from 'vuex'
import * as servConf from '../api/server-config'

export default {
  data () {
    return {
      betValue: ''
    }
  },
  computed: {

  },
  methods: {
    // 首次下注设置
    setBet () {
      const self = this
      this.$dm.confirmSet({
        title: `下注设置`,
        btnText: '确定',
        btnType: 'bet',
        checks: [
          {
            checked: true
          }, {
            checked: false
          }],
        confirmCb (checks) {
          // todo 去设置，与后端交互
          console.log(checks)
          self.isAblePop([5, 0])
          self.isAblePop([4, Number(!checks[0])])
          self.isAblePop([6, Number(checks[1])])
        }
      })
    },
    // 点击确定下注按钮后，判断金币或金豆是否充足
    isGoldEnough (goldPrefer) {
      const self = this
      switch (goldPrefer) {
        case 0 :
          // 金币是否充足
          if (this.userInfoData.avalible_coin < this.quizDetail.sale_price) {
            this.buyCoin()
          } else {
            this.goBet(goldPrefer)
          }
          break
        case 1 :
          // 金豆是否充足
          if (this.userInfoData.bean_balance < this.quizDetail.sale_price) {
            this.buyBean()
          } else {
            this.goBet(goldPrefer)
          }
          break
      }
    },
    buyBean () {
      const self = this
      this.$dm.confirm({
        title: `提示`,
        mes: `金豆不足`,
        btnText: '知道了',
        btnType: 'bet',
        confirmCb (checked) {
          console.log('购买金豆去')
        }
      })
    },
    buyCoin () {
      const self = this
      this.$dm.confirm({
        title: `提示`,
        mes: `金币不够了，购买金币后再下注`,
        btnText: '购买金币',
        btnType: 'bet',
        confirmCb (checked) {
          console.log('购买金币去')
          if (servConf.APP === 0) {
            self.$f7.mainView.router.load({url: '/buy-gold/'})
          } else if (servConf.VISITOR === 0) {
            self.$f7.mainView.router.load({url: '/buy-gold-app/'})
          } else {
            self.$f7.mainView.router.load({url: '/buy-gold-iap/'})
          }
        }
      })
    },
    chooseAnswerUnableBean (value, winGold, goldType, goldConf) {
      const self = this
      this.$dm.confirm({
        title: `选择：${value[1]}. ${value[0].answer}`,
        mes: `投<span style="color: #F95E00">${this.quizDetail.sale_price}</span> ${goldType}，猜中可得<span style="color: #F95E00">${parseInt(winGold)}</span> ${goldType}`,
        btnType: 'bet',
        enableBean: false,
        goldConf: goldConf,
        confirmCb (goldPrefer) {
          console.log(goldPrefer)
          self.isGoldEnough(goldPrefer)
        }
      })
    },
    chooseAnswer (value, winGold, goldType, goldConf) {
      const self = this
      this.$dm.confirm({
        title: `选择：${value[1]}. ${value[0].answer}`,
        mes: `投<span style="color: #F95E00">${this.quizDetail.sale_price}</span> ${goldType}，猜中可得<span style="color: #F95E00">${parseInt(winGold)}</span> ${goldType}`,
        btnType: 'bet',
        goldConf: goldConf,
        confirmCb (goldPrefer) {
          console.log(goldPrefer)
          self.isGoldEnough(goldPrefer)
        }
      })
    },
    goldNotEnoughBet (value, winGold, goldType, goldConf) {
      const self = this
      let anotherGold = ''
      if (goldType === '金币') {
        anotherGold = '金豆'
      } else if (goldType === '金豆') {
        anotherGold = '金币'
      }
      this.$dm.confirm({
        title: `${anotherGold}不足`,
        mes: `投<span style="color: #F95E00">${this.quizDetail.sale_price}</span> ${goldType}，猜中可得<span style="color: #F95E00">${parseInt(winGold)}</span> ${goldType}`,
        btnType: 'bet',
        goldConf: goldConf,
        confirmCb (goldPrefer) {
          console.log(goldPrefer)
          self.isGoldEnough(goldPrefer)
        }
      })
    },
    bet (value) {
      const self = this
//        self.isAblePop([5, 1])
      if (!this.loginCheck(false)) {
        return
      }

      if (this.isBanker) {
        this.$f7.addNotification({
          title: '提示',
          message: '不能参与自己发布的竞猜',
          closeOnClick: true,
          hold: 3000
        })
        return
      }

      if (this.userInfoData.bet_first === 1) {
        // 下注设置
        this.setBet()
        return
      }

      // 下注弹框逻辑
      // 提示文字：金豆？金币
      this.betValue = value
      let winGold = this.quizDetail.sale_price * Math.round(value[0].odds * 100) / 100
      let goldType = ''
      console.log(value)
      console.log('优先', this.userInfoData.coin_first)

      // 竞猜是否可用金豆下注
      if (this.quizDetail.like_peas === 0) {
        console.log('不可用金豆下注', this.userInfoData.coin_first)
        // 金币是否充足
        if (this.userInfoData.avalible_coin < this.quizDetail.sale_price) {
          this.buyCoin()
        } else {
          // 是否下注提示
          if (this.userInfoData.bet_tip) {
            // 金豆下注选项变灰
            goldType = '金币'
            this.chooseAnswerUnableBean(value, winGold, goldType, 0)
          } else {
            this.goBet(0)
          }
        }
      } else {
        console.log('可用金豆下注', this.userInfoData.coin_first)
        // 是否优先使用金币：以文案为准：此时beanPrefer含义为coinPrefer
        if (!this.userInfoData.coin_first) {
          // 金币是否充足
          if (this.userInfoData.avalible_coin < this.quizDetail.sale_price) {
            // 金豆是否充足
            if (this.userInfoData.bean_balance < this.quizDetail.sale_price) {
              this.buyCoin()
            } else {
              goldType = '金豆'
              this.goldNotEnoughBet(value, winGold, goldType, 1)
            }
          } else {
            // 是否下注提示
            if (this.userInfoData.bet_tip) {
              goldType = '金币'
              this.chooseAnswer(value, winGold, goldType, 0)
            } else {
              this.goBet(0)
            }
          }
        } else {
          // 金豆是否充足
          if (this.userInfoData.bean_balance < this.quizDetail.sale_price) {
            // 金币是否充足
            if (this.userInfoData.avalible_coin < this.quizDetail.sale_price) {
              this.buyCoin()
            } else {
              goldType = '金币'
              this.goldNotEnoughBet(value, winGold, goldType, 0)
            }
          } else {
            // 是否下注提示
            if (this.userInfoData.bet_tip) {
              goldType = '金豆'
              this.chooseAnswer(value, winGold, goldType, 1)
            } else {
              this.goBet(1)
            }
          }
        }
      }
    }
  },
  watch: {

  }
}
