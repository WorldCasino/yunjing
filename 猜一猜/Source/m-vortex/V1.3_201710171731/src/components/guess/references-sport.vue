<!--　足彩篮球比赛队伍 -->
<template>
  <div class="references-sport" style="background: white">
    <div class="team team-l flex-col" v-for="(team1, index) in teams" v-if="team1.court_type === 0">
      <div class="team-logo">
        <img :src="team1.team_logo" alt="">
      </div>
      <div class="team-name"><span>[主]</span>{{team1.team_name}}</div>
    </div>

    <div class="vs-wrapper flex-col">
      <div class="title">{{title}}</div>
      <div v-if="!isPublished" class="vs">VS</div>
      <div v-else class="vs">{{quizDetail.score}}</div>
      <div class="play_type" v-if="play_type === 1">标准盘</div>
      <div class="play_type" v-if="play_type === 2">让球 ({{concede_points_show}})</div>
      <div class="play_type" v-if="play_type === 3">大小球 ({{concede_points_show}})</div>
    </div>

    <div class="team team-r flex-col" v-for="(team1, index) in teams" v-if="team1.court_type === 1">
      <div class="team-logo">
        <img :src="team1.team_logo" alt="">
      </div>
      <div class="team-name">{{team1.team_name}}<span>[客]</span></div>
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
      // 参赛队伍, 第一个主队,第二个客队
      teams: {
        type: Array,
        required: true,
        validator: function (value) {
          return value.length === 2
        }
      },
      // 英超 第8轮
      title: {
        type: String,
//        required: true,
        default: '英超第n轮了'
      },
      //  1标准盘， 2让球， 3大小球
      play_type: {
        type: Number,
//        required: true,
        default: 1
      },
      // 盘口
      concede_points_show: {
        type: String,
        default: '0'
      },
      // 是否开奖
      isPublished: {
        type: Boolean,
        default: false
      },
      quizDetail: Object
    },
    computed: {
    }
  }
</script>

<style scoped>

  .references-sport {
    margin: 5px auto 0;
    width: 175px;
    min-height: 74px;
    position: relative;
  }

  .team-l {
    position: absolute;
    left: 0;
    top: 50%;
    transform: translate(-50%, -50%);
  }

  .vs-wrapper {

    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
  }


  .team-r {
    position: absolute;
    right: 0;
    top: 50%;
    transform: translate(50%, -50%);
  }


  .team-logo img {
    width: 45px;
  }

  .team-name {
    position: relative;
    color: #333;
  }

  .team-name span{
    //line-height: 16px;
  }

  .team-l span {
    color: #E6191A;
  }

  .team-r span {
    color: #19A0FF;
  }

  .team-l .team-name span{
    position: absolute;
    top: 0;
    left: -24px;

  }

  .team-r .team-name span{
    position: absolute;
    top: 0;
    right: -24px;
  }

  .vs {
    font-size: 20px;
    color: #333;
  }

  .title, .play_type {
    font-size: 10px;
    color: #666;
  }
</style>
