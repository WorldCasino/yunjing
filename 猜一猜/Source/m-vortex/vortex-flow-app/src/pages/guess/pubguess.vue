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
              accept="image/jpeg,image/png" 
              :crop="false"
              size="4">
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
              accept="image/jpeg,image/png"
              :crop="false" 
              size="4">
            </picture-input>
          </div>

          <div icon="Back" class="btn-add-refferimg" ref="bg2">
            <img v-show="!show2" src=""  ref="img2" class="img-show">
            <p v-show="show2">参考图</p>
            <img v-show="show2" src="../../../static/guess/fabu_button01.png" class="img-upload">
            <picture-input 
              class="upload-wrapper"
              ref="pictureInput2" 
              @change="onChange($event, 2)" 
              accept="image/jpeg,image/png"
              :crop="false"
              size="4">
            </picture-input>
          </div>

          <div icon="Back" class="btn-add-refferimg" ref="bg3">
            <img v-show="!show3" src=""  ref="img3" class="img-show">
            <p v-show="show3">参考图</p>
            <img v-show="show3" src="../../../static/guess/fabu_button01.png" class="img-upload">
            <picture-input 
              class="upload-wrapper"
              ref="pictureInput3" 
              @change="onChange($event, 3)" 
              accept="image/jpeg,image/png"
              :crop="false" 
              size="4">
            </picture-input>
          </div>

        </div>

      </div>
      <div class="part2">
        <div class="group">
          <input type="text" required class="result-input-true" v-model="inputRight" maxlength="6">
          <label>填写正确答案</label>
        </div>
        <div class="group">
          <input type="text" required class="result-input-false" v-model="inputWrong" maxlength="6">
          <label>填写错误答案</label>
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

        // 最多发布竞猜文字
        textMax: 40,
        textMin: 6,
        height: 0
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
        status: state => state.uploadData.status
      }),
      descAcount () {
        return this.desc.length >= 30 ? 'true' : false
      }
    },
    methods: {
      ...mapActions([
        'assignImages'
      ]),
      init () {
        console.log('pubguess init')
      },
      nextStep () {
//        this.assignImages(this.images)
//        let textInput = document.getElementsByClassName('desc-input').item(0)
//        let trueInput = document.getElementsByClassName('result-input-true').item(0)
//        let falseInout = document.getElementsByClassName('result-input-false').item(0)
        // 默认值为10通过
        if (this.token !== null) {
          var isNext = 10
          if (this.desc.trim().length < this.textMin) {
            isNext = 1
          } else if (this.show0) {
            isNext = 2
          } else if (this.show1 && this.show2 && this.show3) {
            isNext = 3
          } else if (this.inputRight.trim().length === 0) {
            isNext = 4
          } else if (this.inputWrong.trim().length === 0) {
            isNext = 5
          } else if (this.inputWrong.trim() === this.inputRight.trim()) {
            isNext = 6
          }
          console.log(isNext)
          if (isNext === 1) {
            this.$f7.alert('竞猜描述字数请大于' + this.textMin + '个', '友情提醒')
          } else if (isNext === 2) {
            this.$f7.alert('请上传答案图', '友情提醒')
          } else if (isNext === 3) {
            this.$f7.alert('请上传参考图', '友情提醒')
          } else if (isNext === 4) {
            this.$f7.alert('请填写正确答案', '友情提醒')
          } else if (isNext === 5) {
            this.$f7.alert('请填写错误答案', '友情提醒')
          } else if (isNext === 6) {
            this.$f7.alert('正确答案和错误答案不能一致', '友情提醒')
          } else if (isNext === 10) {
            console.log('下一步了', isNext)
            this.$store.state.uploadData.desc = this.desc
            this.$store.state.uploadData.trueAnswer = this.inputRight
            this.$store.state.uploadData.falseAnswer = this.inputWrong
            this.$f7.views.postPop.router.load({url: '/pub-guess-set/'})
          }
        } else {
          this.$f7.popup('#login-choose')
        } 
        // this.$f7.views.postPop.router.load({url: '/pub-guess-set/'})
      },
      onChange (rotate, i) {
        // rotate：拿到需旋转的角度,如果不需要旋转值为false
        // this.$refs.pictureInput.file拿到file对象
        console.log('我是图片要转的角度', rotate)
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
          if (this.status === null) {
            this.desc = ''
            this.show0 = true
            this.show1 = true
            this.show2 = true
            this.show3 = true
            this.inputRight = ''
            this.inputWrong = ''
            self.$refs.img0.src = ''
            self.$refs.img1.src = ''
            self.$refs.img2.src = ''
            self.$refs.img3.src = ''
          }
        }
      } 
    }
  }

</script>

<style scoped>

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
    margin-top: 10px;
    height: 64px;
    width: 100%;
    background-color: white;
    display: flex;
    display: -webkit-flex;
    justify-content: space-around;
    align-items: center;
  }

  .btns-confirm {
    margin-left: 2px;
    margin-right: 2px;
    display: flex;
    display: -webkit-flex;
    justify-content: space-around;
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
    padding:26px 10px 10px 20px;
    display:block;
    width:100%;
    box-sizing: border-box;
    border:none;
    background: none;
  }
  input:focus {
    outline:none;
    padding:26px 10px 10px 20px;
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
  
</style>
