<template>

  <div class="pub-guess" ref="wrapper" :style="{height: height-44 + 'px'}" >
    <div class="guess-content" :style="{height: height-89 + 'px'}">
      <div class="part1">
        <textarea v-model="desc" :maxlength="textMax" class="desc-input" :class="{'desc-warn': descAcount}" placeholder="给你的竞猜想一个6个字以上的好玩的描述吧~要记得说明是猜什么哦~">
        </textarea>
        <div class="text-wrapper">
          <span class="text-count" :class="{'text-warn': descAcount}">{{desc.length}}</span>
          <span class="text-center">/</span>
          <span class="text-max">{{textMax}}</span>
        </div>
        <div class="btns-confirm">

          <div icon="Back" class="btn-add-resultimg" ref="bg0">
            <img v-show="!show0" src=""  ref="img0" class="img-show">
            <p v-show="show0">答案图</p>
            <img v-show="show0" src="../../../static/guess/fabu_button02.png" class="img-upload">
            <picture-input
              class="upload-wrapper"
              ref="pictureInput0"
              @change="onChange($event, 0)"
              accept="image/gif,image/jpeg,image/jpg,image/png,image/svg,image/webp"
              :crop="false"
              size="20">
            </picture-input>
          </div>

          <div icon="Back" class="btn-add-refferimg" ref="bg1">
            <img v-show="!show1" src=""  ref="img1" class="img-show">
            <p v-show="show1">参考图</p>
            <img v-show="show1" src="../../../static/guess/fabu_button01.png" class="img-upload">
            <picture-input
              class="upload-wrapper"
              ref="pictureInput1"
              @change="onChange($event, 1)"
              accept="image/gif,image/jpeg,image/jpg,image/png,image/svg,image/webp"
              :crop="false"
              size="20">
            </picture-input>
          </div>

          <div v-if="!show1" icon="Back" class="btn-add-refferimg" ref="bg2">
            <img v-show="!show2" src=""  ref="img2" class="img-show">
            <p v-show="show2">参考图</p>
            <img v-show="show2" src="../../../static/guess/fabu_button01.png" class="img-upload">
            <picture-input
              class="upload-wrapper"
              ref="pictureInput2"
              @change="onChange($event, 2)"
              accept="image/gif,image/jpeg,image/jpg,image/png,image/svg,image/webp"
              :crop="false"
              size="20">
            </picture-input>
          </div>

          <div v-if="!show1 && !show2" icon="Back" class="btn-add-refferimg" ref="bg3">
            <img v-show="!show3" src=""  ref="img3" class="img-show">
            <p v-show="show3">参考图</p>
            <img v-show="show3" src="../../../static/guess/fabu_button01.png" class="img-upload">
            <picture-input
              class="upload-wrapper"
              ref="pictureInput3"
              @change="onChange($event, 3)"
              accept="image/gif,image/jpeg,image/jpg,image/png,image/svg,image/webp"
              :crop="false"
              size="20">
            </picture-input>
          </div>

        </div>
      </div>

      <div class="part3">
        <div class="part3-wrapper">
          <div class="open-type">开奖方式</div>
          <div class="seperator"></div>
          <div class="type-wrapper flex-row">
            <div v-if="isAuto">
              <div class="open-text">自动开奖</div>
              <div class="open-des">提前设置答案，买满自动开奖</div>
            </div>
            <div v-else>
              <div class="open-text">手动开奖</div>
              <div class="open-des">自己选择答案开奖</div>
            </div>
            <div class="type-btn">
              <div class="type-l" :class="{type_active: !isAuto}">手</div>
              <div class="type-r" :class="{type_active: isAuto}">自</div>
              <input type="checkbox" v-model="isAuto">
            </div>
          </div>
          <div class="seperator"></div>

          <div v-if="!isAuto" class="handle-wrapper">
            <div class="time-wrapper flex-row">
              <div class="time-des">下注截止时间</div>
              <div class="flex-row">
                <div class="time-text" @click="popdatePicker">{{lockTime}}</div>
                <!-- <DatePicker/> -->
                <img src="../../../static/guess/calendar.png" alt="" class="calendar-icon" @click="popdatePicker">
              </div>
            </div>
            <div class="handle-tip">
              下注截止后24小时内，没有手动开奖，竞猜会自动开奖，冻结的金币会平均分给所有参与者
            </div>
          </div>
        </div>
      </div>

      <div class="part2">
        <div class="group">
          <input type="text" required class="result-input-true" v-model="inputRight" maxlength="6">
          <label v-if="isAuto">填写正确答案</label>
          <label v-else>填写答案A<span class="width5"></span></label>
        </div>
        <div class="group">
          <input type="text" required class="result-input-false" v-model="inputWrong" maxlength="6">
          <label v-if="isAuto">填写错误答案</label>
          <label v-else>填写答案B<span class="width5"></span></label>
        </div>
      </div>
      <div class="part3">
        <div class="notice-title">发布须知</div>
        <div class="notice-content">
          1、答案图发布后将会被模糊化处理<br>
          2、多张描述图可以吸引更多人参与<br>
          3、竞猜结束时间默认为24小时或参与人数已满<br>
          4、猜一猜为社交娱乐平台，禁止发布非法赌博内容
        </div>
      </div>
    </div>
    <f7-button class="btn-next-step" @click="nextStep">下一步</f7-button>
  </div>
</template>

<script text="script/javascript">

  import PictureInput from '../../components/PictureInput'
  import * as ImageCompress from '../../utils/canvas-compress'
  import { mapState, mapActions } from 'vuex'
  export default {
    name: 'pub-guess',
    props: ['topBar'],
    data () {
      return {
        // 图片列表,
        fileReader: null,
        currReaderIndex: 0,
        orientation: 1000,
        show0: true,
        show1: true,
        show2: true,
        show3: true,
        imgUrl0: '',
        desc: '',
        inputRight: '',
        inputWrong: '',
        isAuto: true,

        // 最多发布竞猜文字
        textMax: 40,
        textMin: 6,
        height: 0,
        lockTime: ''
      }
    },
    components: {
      PictureInput
    },
    computed: {
      ...mapState({
        reset: state => state.uploadData.reset,
        token: state => state.token,
        shake: state => state.uploadData.shake,
        status: state => state.uploadData.status,
        result: state => state.confirm.result,
        context: state => state.confirm.context,
        userType: state => state.userInfo.data.user_type
      }),
      descAcount () {
        return this.desc.length >= 30 ? 'true' : false
      }
    },
    methods: {
      ...mapActions([
        'assignImages',
        'isAblePop'
      ]),
      init () {
        console.log('pubguess init')
      },
      next () {
        // 本组件数据储存到vuex中
        this.$store.state.uploadData.desc = escape(this.desc)
        this.$store.state.uploadData.trueAnswer = this.inputRight
        this.$store.state.uploadData.falseAnswer = this.inputWrong
        this.$store.state.uploadData.isAutoDraw = this.isAuto
        this.$store.state.uploadData.lockTime = this.lockTime
//        this.$store.state.uploadData.userType = this.userType
//        this.$store.state.uploadData.userType = 1
        if (this.isAuto) {
          this.$f7.views.postPop.router.load({url: '/pub-guess-set/?isAuto=true'})
        } else {
          this.$f7.views.postPop.router.load({url: '/pub-guess-set/?isAuto=false'})
        }  
      },
      nextStep () {
//        this.assignImages(this.images)
//        let textInput = document.getElementsByClassName('desc-input').item(0)
//        let trueInput = document.getElementsByClassName('result-input-true').item(0)
//        let falseInout = document.getElementsByClassName('result-input-false').item(0)
        // 默认值为10通过
        if (this.token !== null) {
          var isNext = 'ok'
          if (this.desc.trim().length < this.textMin) {
            isNext = 'des'
          } else if (this.inputRight.trim().length === 0) {
            isNext = 'missR'
          } else if (this.inputWrong.trim().length === 0) {
            isNext = 'missW'
          } else if (this.inputWrong.trim() === this.inputRight.trim()) {
            isNext = 'r=w'
          } else if (!this.isAuto && !this.lockTime) {
            isNext = 'missTime'
          } else if (typeof this.lockTime === 'string' && new Date().getTime() > new Date(this.lockTime.replace(/-/g, '/') + ':00').getTime() && !this.isAuto) {
            isNext = 'overdue'
          }
          console.log(isNext)
          switch (isNext) {
            case 'des':
              this.$dm.confirm({
                title: `提示`,
                mes: '竞猜描述字数请大于' + this.textMin + '个'
              })
              break
            case 'missR':
              if (!this.isAuto) {
                this.$dm.confirm({
                  title: `提示`,
                  mes: '请填写答案A'
                })
              } else {
                this.$dm.confirm({
                  title: `提示`,
                  mes: '请填写正确答案'
                })
              }
              break
            case 'missW':
              if (!this.isAuto) {
                this.$dm.confirm({
                  title: `提示`,
                  mes: '请填写答案B'
                })
              } else {
                this.$dm.confirm({
                  title: `提示`,
                  mes: '请填写错误答案'
                })
              }
              break
            case 'r=w':
              if (this.isAuto) {
                this.$dm.confirm({
                  title: `提示`,
                  mes: '正确答案和错误答案不能一致'
                })
              } else {
                this.$dm.confirm({
                  title: `提示`,
                  mes: '答案A和答案B不能一致'
                })
              }
              break
            case 'missTime':
              this.$dm.confirm({
                title: `提示`,
                mes: '请设置开奖时间'
              })
              break
            case 'overdue':
              this.$dm.confirm({
                title: `提示`,
                mes: '请选择当前时间之后的时间点作为下注截止时间。',
                confirmCb () {
                  
                }
              })
              break
            case 'ok':
              if (this.show0 && !this.$store.state.userInfo.data.default_pic) {
                this.isAblePop(2)
                this.$store.state.userInfo.data.default_pic = 1
                // （添加判断是否是第一次激活此功能）
                this.$dm.confirm({
                  title: `未上传答案图`,
                  mes: '没有上传答案图，系统将使用默认图作为答案图',
                  confirmCb: () => {
                    this.next()
                  }
                })
              } else {
                this.next()
              }
              break
          }
        } else {
          this.$f7.popup('#login-choose')
        }
        // this.$f7.views.postPop.router.load({url: '/pub-guess-set/'})
      },
      onChange (rotate, i) {
        // rotate：拿到需旋转的角度,如果不需要旋转值为false
        // this.$refs.pictureInput.file拿到file对象
        let self = this
        let oFile = this.$refs['pictureInput' + i]['file']
        // let imgCode = this.$refs['pictureInput' + i]['image']
        let oReader = new FileReader()
        oReader.readAsDataURL(oFile)
        oReader.onloadend = function () {
          let data = {}
          let img = document.createElement('img')
          img.onload = function () {
            self.$store.state.uploadData.uploadImages[i] = ImageCompress.getBlobImage(this, 0.5, 1.0, rotate)
            /* // 测试：显示画布旋转后的图
            let imgShow1 = self.$refs['test']
            imgShow1.src = ImageCompress.getBlobImage(this, 0.5, 1.0, rotate) */
          }
          img.src = this.result
          // 显示样式图片到框内
          let imgShow = self.$refs['img' + i]
          imgShow.src = this.result
          imgShow.onload = function () {
            if (imgShow.width > imgShow.height) {
              imgShow.style.cssText = 'height: 2.24rem'
            } else {
              imgShow.style.cssText = 'width: 2.24rem'
            }
          }
          self['show' + i] = false
        }
      },
      popdatePicker () {
        var dt = ''
        if (this.lockTime) {
          dt = new Date(this.lockTime.replace(/-/g, '/'))
        }
        this.$Datepick({
          date: dt,
          success: (d) => {
            this.lockTime = d
          }
        })
      }
    },
    mounted () {
      // 高度自适应满屏
      // :style="{height: height-44 + 'px'}"
      var height = document.documentElement.clientHeight
      this.height = parseInt(height)
      // this.$refs.wrapper.style.height = (this.height - 44) + 'px'
    },
    watch: {
      reset: {
        handler: function (val) {
          let self = this
          console.log('pub guess reset')
          /* this.desc = ''
          this.show0 = true
          this.show1 = true
          this.show2 = true
          this.show3 = true
          this.inputRight = ''
          this.inputWrong = ''
          self.$refs.img0.src = ''
          self.$refs.img1.src = ''
          self.$refs.img2.src = ''
          self.$refs.img3.src = '' */
        }
      },
      shake: {
        handler: function (val) {
          // 发布成功，此组件state数据清空
          let self = this
          if (this.status === null) {
            this.desc = ''
            this.show0 = true
            this.show1 = true
            this.show2 = true
            this.show3 = true
            this.inputRight = ''
            this.inputWrong = ''
            this.isAuto = true
            self.$refs.img0.src = ''
            self.$refs.img1.src = ''
            self.$refs.img2.src = ''
            self.$refs.img3.src = ''
          }
        }
      },
      isAuto (v) {
        this.lockTime = ''
      }
    }
  }

</script>

<style scoped>
  .time-position{
    position: relative;
  }
  .pub-guess {
    display: flex;
    display: -webkit-flex;
    flex-direction: column;
  }

  .guess-content {
    //flex: 1;
    overflow: auto;
  }

  p {
    margin-top: 0.2667rem;
    color: gray;
  }

  .width5{
    width: 13px; display: inline-block;
  }
  .result-input-true {
    /*margin-left: 15px;*/
    /*margin-top: -13px;*/
    /*border: 0px solid;*/
    /*background-color: gold;*/
    /*font-size: 16px;*/
  }

  .result-input-false {
    /*margin-left: 15px;*/
    /*margin-top: -13px;*/
    /*border: 0px solid;*/
    /*background-color: gold;*/
    /*font-size: 16px;*/
  }

  .image-input {
    position: absolute;
    /*background-color: aqua;*/
    opacity: 0;
    margin-top: 0px;
    width: 100%;
    height: 84px;
    top: 0px;
  }

  .uploaded-img {
    position: absolute;
    width: 100%;
    height: 100%;
    background-color: transparent;
    border-radius: 5px;
    border: 0;
    margin: 0;
    z-index: 1000;
  }

  .part1 {
    margin-top: 10px;
    background-color: white;
    position:relative;
  }

  .part2 {
    margin-top: 14px;
    height: 64px;
    width: 100%;
    background-color: white;
    display: flex;
    display: -webkit-flex;
    justify-content: space-around;
    align-items: center;
  }

  .btns-confirm {
    display: flex;
    display: -webkit-flex;
    justify-content: flex-start;
  }

  .btn-add-resultimg, .btn-add-refferimg{
    width: 2.24rem;
    height: 2.24rem;
    display: flex;
    display: -webkit-flex;
    justify-content: flex-start;
    align-items: center;
    flex-direction: column;
    border-radius: 5px;
    margin-bottom: 10px;
    position: relative;
    overflow: hidden;
    margin-left: .17rem;
  }

  div.btn-add-resultimg {
    border: 1px solid gold;
  }

  div.btn-add-refferimg {
    border: 1px solid darkgray;
  }

  .img-upload{
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%);
    margin-top: -12px;
    width: 35px;
    height: 35px;
  }

  .btn-add-refferimg p,.btn-add-resultimg p{
    color:#999;
  }

  .desc-input {
    background-color: #f6f6f6;
    border-width: 0;
    border-radius: 6px;
    border:1px solid transparent;
    width: 90%;
    max-width: 90%;
    padding: 12px 12px;
    height: 120px;
    max-height: 120px;
    /*font-size: small;*/
    margin-top: 10px;
    overflow: hidden;
    resize: none;
    font-size: 14px;
  }

  .desc-warn{
    border: 1px solid #ff3c3c;
  }

  .text-wrapper{
    position:absolute;
    right:16px;
    top:130px;
  }

  .text-count{
    color:#999;
    font-size: 12px;
  }

  span.text-warn{
    color:#ff3c3c;
  }

  .text-center{
    font-size: 16px;
    color:#999;
    vertical-align: middle;
    margin:2px -2px 0;
  }

  .text-max{
    color:#999;
    font-size: 12px;
  }

  .btn-wrapper{
    background-color: gold;
  }

  .btn-next-step {
    height: 45px;
    width: 100%;
    color: black;
    background-color: gold;
    padding-bottom: 0px;
    border-width: 0px;
    border-radius: 0px;
    font-size: large;
    display: flex;
    display: -webkit-flex;
    align-items: center;
    justify-content: center;
  }

  .group {
    position:relative;
    margin-top: 50px;
    margin-bottom:50px;
    background: gold;
    border-radius: 4px;
    width:44%;
    /* width:165px; */
  }
  input {
    font-size:14px;
    color:#333;
    text-align: left;
    padding:26px 10px 10px 15px;
    display:block;
    width:100%;
    box-sizing: border-box;
    border:none;
    background: none;
  }
  input:focus {
    outline:none;
    padding:26px 10px 10px 15px;
  }
  label {
    color:#333;
    font-size:14px;
    font-weight:normal;
    position:absolute;
    pointer-events:none;
    left:50%;
    top:50%;
    transform: translateY(-50%);
    -moz-transform: translateY(-50%);
    -webkit-transform: translateY(-50%);
    transition:0.2s ease all;
    -moz-transition:0.2s ease all;
    -webkit-transition:0.2s ease all;
    width:100%;
    text-align:center;
    margin-left: -50%;
  }

  /* active state */
  input:focus ~ label, input:valid ~ label 		{
    top:30%;
    left: 50px;
    font-size:10px;
    color:#666;
  }

  .notice-title{
    font-size:14px;
    color:#666;
    margin:12px 0 0 12px;
    text-align: left;
  }

  .notice-content{
    font-size:14px;
    color:#999;
    text-align: left;
    padding:4px 0 10px 12px;
  }

  .img-show{
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    margin: 0;
  }

  .upload-wrapper {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    top: 0;
  }

  .open-type {
    padding-left: 12px;
    font-size: 13px;
    color: #666;
    line-height: 30px;
    background: #fff;
    margin-top: 15px;
    text-align: left;
  }

  .type-wrapper, .time-wrapper {
    height: 55px;
    background: #fff;
    padding: 0 12px 0 14px;
  }

  .open-text {
    font-size: 15px;
    color: #333;
    text-align: left;
    line-height: 25px;
  }

  .open-des {
    font-size: 12px;
    color: #666;
  }

  .type-btn {
    width: 80px;
    height: 35px;
    border: 1px solid #fd0;
    position: relative;
    border-radius: 3px;
  }

  .type-l {
    position: absolute;
    left: 0;
    top: 0;
    width: 50%;
    height: 100%;
    line-height: 36px;
    background: #fff;
    color: #666;
  }

  .type-r {
    position: absolute;
    right: 0;
    top: 0;
    width: 50%;
    height: 100%;
    line-height: 36px;
    background: #fff;
    color: #666;
  }

  .type-btn input {
    position: absolute;
    width: 100%;
    height: 100%;
    opacity: 0;
  }

  .type_active {
    background: #fd0;
    color: #fff;
  }

  .time-des {
    color: #333;
    font-size: 15px;
  }

  .time-text {
    color: #666;
    font-size: 15px;
  }

  .calendar-icon {
    width: 25px;
    height: 25px;
    margin-left: 7px;
  }

  .handle-tip {
    font-size: 13px;
    color: #666;
    padding: 8px 13px 0;
    text-align: left;
  }

</style>
