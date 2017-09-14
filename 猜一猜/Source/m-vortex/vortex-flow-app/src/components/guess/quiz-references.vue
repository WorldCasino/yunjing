<!-- 竞猜参考图 -->
<template>
  <div>
    <div class="box-images-block">
      <!--<div class="lazy item-image" :style="{backgroundImage: 'url(' + resultPlaceholder.pic_url + ')' }" @click="showImages(0)">-->
      <div class="item-image" v-lazy:background-image="getResultSmallImage()" @click="showImages(0)">
      </div>
      <!--<div v-for="(item, index) in references" key="item" class="lazy item-image-references" :style="{backgroundImage: 'url(' + item.pic_url + ')' }" @click="showImages(index+1)">-->
      <div v-for="(item, index) in references" key="item" class="item-image-references" v-lazy:background-image="getRefSmallImage(index)" @click="showImages(index+1)">
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {

      }
    },
    props: {
//      0 不查看 1: 查看参考图 2.查看参考图和答案图
      browserMode: { type: Number, default: 0 },
      // 答案图片占位, 发布后为正确答案图片
      resultPlaceholder: { type: Object, required: true },
      // 参考图片列表
      references: {
        type: Array,
        required: true,
        validator: function (value) {
          // 参考图片有三张
          return value.length <= 3
        }
      }
    },
    computed: {

    },
    mounted () {
//      todo 图片宽高一致
//      this.$refs.result.height = this.$refs.result.width
//      for (var i = 0; i < this.$refs.refs.length; i++) {
//        let ref = this.$refs.refs[i]
//        ref.height = ref.width
//      }
    },
    methods: {
      getResultSmallImage () {
        return this.resultPlaceholder.pic_url + '/small'
      },
      getRefSmallImage (index) {
        return this.references[index].pic_url + '/small'
      },
      showImages (index) {
        console.log(index)
        console.log(this.browserMode)
        let images = []
        if (this.browserMode === 0) {
          return
        } else if (this.browserMode === 1 && index === 0) {
          return
        }

        if (this.browserMode === 1) {
          for (var i = 0; i < this.references.length; i++) {
            images.push(this.references[i].pic_url)
          }
          this.$store.state.quizDetail.isSwiper = true
          this.$store.state.quizDetail.imgs = images
          this.$store.state.quizDetail.imgIndex = index - 1
          /* let imageBrowser = this.$f7.photoBrowser({
            photos: images,
            initialSlide: index - 1
          })
          imageBrowser.open() */
        } else if (this.browserMode === 2) {
          images.push(this.resultPlaceholder.pic_url)
          for (i = 0; i < this.references.length; i++) {
            images.push(this.references[i].pic_url)
          }
          this.$store.state.quizDetail.isSwiper = true
          this.$store.state.quizDetail.imgs = images
          this.$store.state.quizDetail.imgIndex = index
          /* let imageBrowser = this.$f7.photoBrowser({
            photos: images,
            initialSlide: index
          })
          imageBrowser.open() */
        }
      }
    }
  }
</script>

<style scoped>
  .box-images-block {
    background: white;
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    margin-left: 12px;
    margin-right: 12px;
    margin-top: 8px;
  }
  .item-image {
    flex-shrink: 1;
    flex-grow: 0;
    /*flex-basis: auto;*/
    /*width: 24%;*/
    width: 2.22rem;
    height: 2.22rem;
    border: 1px #ffdd00 solid;
    /*background: url("") no-repeat center center;*/
    background: no-repeat center center;
    -webkit-background-size:cover;
    -moz-background-size:cover;
    background-size:cover;
    /*width:24vw;*/
    /*height:24vw;*/
  }
  .item-image-references {
    margin-left: 1.333%;
    flex-grow: 0;
    flex-shrink: 1;
    /*flex-basis: auto;*/
    /*width: 24%;*/
    width: 2.22rem;
    height: 2.22rem;
    background: no-repeat center center;
    -webkit-background-size:cover;
    -moz-background-size:cover;
    background-size:cover;
    /*width:24vw;*/
    /*height:24vw;*/
  }

</style>
