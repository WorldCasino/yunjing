<template>
  <section class="wrap">
    <div class="mask"></div>
    <div class="can" @click="output">
      <header class="d-head">
        <div class="d-head-left" @click="reduce"><p></p></div>
        <div class="d-head-year" @click="selectYear(date.getFullYear())" @touchend="selectColor(1)":class="{colorfff: flag == '1'}">{{date.getFullYear()}}</div>
        <div class="d-head-month" :class="{colorfff: flag == '2'}" @touchend="selectColor(2)" @click="selectMonth(date.getMonth())">{{date.month() | monthStr}}月</div>
        <div class="d-head-right" @click="add"><p></p></div>
      </header>
      
      <table class="d-table" v-if="selectType == 1">
        <thead>
          <tr>
            <td>日</td>
            <td>一</td>
            <td>二</td>
            <td>三</td>
            <td>四</td>
            <td>五</td>
            <td>六</td> 
          </tr>
        </thead>
        
        <tbody class="d-tbody">
          <tr v-for="item in dayAll">
            <td v-for="d in item":class="{active: active && d == dt.getDate() || d == date.getDate()}" @click="getDay(d)">{{d}}</td>
          </tr>
        </tbody>  
      </table>
      
      <div class="d-table d-can-year" v-if="selectType == 2">
        <div class="d-can-yearWrap">
          <div class="d-year-list" v-for="i in 50" @click="selYear(yearList-5+i)">{{yearList-5+i}}</div>
        </div>
      </div>
      
      <div class="d-table d-can-year" v-if="selectType == 3">
        <div class="d-can-yearWrap">
          <div class="d-year-list" v-for="i in 12" @click="selMon(i)">{{i|monthStr}}月</div>
        </div>
      </div>
      
      <div class="d-table d-can-year" v-if="selectType == 4">
        <div class="d-can-hourSec">
          
          <div class="d-select-hour">
            <p v-for="i in 24" class="d-year-list" @click="setHour(i)" :class="{active: selHour == i}">{{i-1 < 10 ? '0' + (i - 1) : i-1}}</p>
          </div>
          
          <div class="d-select-minu">
            <p class="d-year-list" v-for="i in 60" @click="setMinu(i)" :class="{active: selMinu == i}">
              {{i-1 < 10 ? '0' + (i - 1) : i-1}}
            </p>
          </div>

        </div>
      </div>
      
      <footer class="d-bottom"> 
        <button class="comfirm" @click="comfirm">确认</button>
        <button class="cancel" @click="cancel">取消</button>
      </footer>
    </div>
  </section>
</template>
<script>
  export default {
    data () {
      return {
        date: new Date(), // 点击之后改变的时间
        dt: new Date(), // 初始化选定的日期，开奖时间
        selectType: 1, // 1是显示日期 2是显示年份 3显示月份4显示小时和分钟
        storeYmr: '',
        flag: 3, // 选择年份与月份是颜色变化
        selMinu: '', // 选中分钟添加样式
        selHour: '' // 选中小时添加样式
      }
    },
    filters: {
      monthStr (v) {
        switch (parseInt(v)) {
          case 1: return '一'
          case 2: return '二'
          case 3: return '三'
          case 4: return '四'
          case 5: return '五'
          case 6: return '六'
          case 7: return '七'
          case 8: return '八'
          case 9: return '九'
          case 10: return '十'
          case 11: return '十一'
          case 12: return '十二'
        }
      }
    },
    methods: {
      output () {
        
      },
      setMinu (m) {
        this.selMinu = m
        this.date = new Date(this.date.setMinutes(m - 1))
      },
      setHour (h) {
        this.selHour = h
        this.date = new Date(this.date.setHours(h - 1))
      },
      selMon (m) {
        this.selectType = 1
        this.flag = 3
        this.date = new Date(this.date.setMonth(m - 1))
      },
      selectMonth (m) {
        this.selectType = 3
        this.flag = 2
        this.date = new Date(this.date.setMonth(m))
      },
      selYear (y) {
        this.selectType = 1
        this.flag = 3
        this.date = new Date(this.date.setFullYear(y))
      },
      selectColor (index) {
        this.flag = index
      },
      selectYear (year) {
        this.flag = 1
        this.selectType = 2
      },
      getDay (day) {
        this.selectType = 4
        this.date = new Date(this.date.setDate(day))
      },
      comfirm () {
        if (this.selectType === 2) {
          this.selectType = 1
          this.flag = 3
          return
        }
        if (this.selectType === 1 || this.selectType === 4) {
          if (typeof this.success === 'function') {
            this.success(this.date.format())
          }
          document.body.removeChild(this.$el)
        }
      },
      cancel () {
        document.body.removeChild(this.$el)
      },
      reduce () {
        var y = this.date.getFullYear()
        if (this.date.month() < 1) {
          this.date = new Date(new Date(this.date.setMonth(11)).setFullYear(y - 1))
        } else {
          this.date = new Date(this.date.setMonth(this.date.getMonth() - 1))
        }
      },
      add () {
        var y = this.date.getFullYear()
        if (this.date.month() > 12) {
          this.date = new Date(new Date(this.date.setMonth(0)).setFullYear(y + 1))
        } else {
          this.date = new Date(this.date.setMonth(this.date.getMonth() + 1))
        }
      }
    },
    computed: {
      yearList () {
        return this.date.getFullYear()
      },
      active () {
        var dt = this.dt
        var date = this.date
        if (dt.getFullYear() === date.getFullYear() && dt.getMonth() === date.getMonth() && date.getDate() === dt.getDate()) {
          return true
        }
      },
      dayAll () {
        var d = this.date
        var m = parseInt(d.month())
        var isLeap = d.isLeap()
        var d1 = d.monFirstDay()
        if (m === 1 || m === 3 || m === 5 || m === 7 || m === 8 || m === 10 || m === 12) {
          return sortD(d1, 31)
        } else if (m === 2 && isLeap) {
          return sortD(d1, 29)  
        } else if (m === 2 && !isLeap) {
          return sortD(d1, 28)
        } else {
          return sortD(d1, 30)
        }
        function sortD (d1, n) {
          var arr = []
          var k = 0
          for (var i = 0; i < 6; i++) {
            arr[i] = []
            for (var j = 0; j < 7; j++) {
              if (k < d1) {
                arr[i][j] = ''
              } else if (k < n + d1) {
                arr[i][j] = k - d1 + 1
              } else {
                arr[i][j] = ''
              } 
              k++
            }
          }
          return arr
        }
      }
    }
  }
  
  Date.prototype.format = function () {
    return this.getFullYear() + '-' +
    (this.getMonth() >= 10 ? this.getMonth() + 1 : '0' + (this.getMonth() + 1)) + '-' + 
    (this.getDate() >= 10 ? this.getDate() : '0' + this.getDate()) + ' ' + 
    (this.getHours() >= 10 ? this.getHours() : '0' + this.getHours()) + ':' + 
    (this.getMinutes() >= 10 ? this.getMinutes() : '0' + this.getMinutes())
  // + (' ' + this.getSeconds() >= 10 ? this.getSeconds() : '0' + this.getSeconds())
  }
  
  Date.prototype.month = function () {
    return this.getMonth() + 1 >= 10 ? this.getMonth() + 1 : '0' + (this.getMonth() + 1)
  }
  
  Date.prototype.isLeap = function () {
    var y = this.getFullYear()
    if (y % 100 === 0 && y % 400 === 0) {
      return true
    } else if (y % 100 === 0 && y % 400 !== 0) {
      return false
    } else if (y % 100 !== 0 && y % 4 === 0) {
      return true
    } else {
      return false
    }
  }
  
  Date.prototype.monFirstDay = function () {
    var m = this.getMonth() + 1
    var y = this.getFullYear()
    return new Date(y + '/' + m + '/' + 1).getDay()
  }
  
</script>
<style scoped>
  *{
    margin: 0; padding: 0;
  }
  
  .wrap{
    position: absolute; left: 0; top: 0;
    width:100%; height: 100%;
    font-size: 16px; color: #333; z-index: 10000000;
  }
  
  .mask{
    position: absolute; left: 0; top: 0;
    width:100%; height: 100%;
    background: rgba(0,0,0,0.5); z-index: 101;
  }
  
  .can{
    width: 320px; height: 402px;
    position: absolute; left: 50%; top: 50%;
    margin-left: -160px; margin-top: -201px;
    background: #fff; z-index: 102; 
  }
  
  .d-head{
    height: 72px; width: 100%; position: relative;
    display: -webkit-flex; display: flex;
    background: gold;
  }
  
  .d-head>div{
    line-height: 72px;text-align: center;
    font-size: 22px; color: rgb(51,51,51);
  }
  
  .d-head-left{
    flex: 2; -webkit-flex: 2; position: relative;
  }
  
  .d-head-left>p{
    width: 20px; height: 20px; position: absolute;
    border: 2px solid #fff; 
    transform: translateX(-10px) translateY(-10px) rotate(45deg);
    left: 50%; top: 50%; border-right: none; border-top: none;
  }
  
  .d-head-year{
    flex: 3; -webkit-flex: 3;
  }
  
  .d-head-month{
    flex: 3; -webkit-flex: 3;
  }
  
  .d-head-right{
    flex: 2; -webkit-flex: 2; position: relative;
  }
  
  .d-head-right p{
    width: 20px; height: 20px; position: absolute;
    border: 2px solid #fff; transform-origin: center center;
    left: 50%; top: 50%;
    transform: translateX(-10px) translateY(-10px) rotate(-45deg);
    border-top: none; border-left: none;
  }
  
  .d-table{
    height: 280px; padding: 25px; box-sizing: border-box; padding-bottom: 10px;
    width: 100%; text-align: center;
  }
  
  .d-tbody td{
    height: 34px; line-height: 34px; text-align: center;
    font-size: 15px;
  }
  
  .d-can-year{
    overflow: hidden;
  }
  
  .d-can-yearWrap{
    width: 105%; overflow: scroll; height: 100%;
    -webkit-overflow-scrolling: touch;
  }
  
  .d-can-hourSec{
    display: flex;display: -webkit-flex;height: 100%; width: 100%;
    overflow: hidden;
  }
  
  .d-select-hour,.d-select-minu{
    width: 105%; height: 100%;
    overflow: scroll;
    -webkit-overflow-scrolling: touch;
  }
  
  .d-can-hourSec > div{
    flex: 1; -webkit-flex: 1;
  }
  
  .d-bottom{
    line-height: 45px; height: 45px;
  }
  .d-bottom button{
    width: 72px;  background: #fff; line-height: 44px;
    border: none;outline: none; float: right; color: #333;
  }
  .active{
    background: gold; color: #fff;
  }
  
  .disable{
    background: #EAEAEA;
  }
  .d-year-list{
    line-height: 50px; text-align: center; font-size: 20px;
  }
  .colorfff{
    color: #fff!important;
  }
</style>

