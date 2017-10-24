<!--　足彩比赛队伍 -->
<template>
  <div style="background: white">
    <div class="box-team-title-block">
      <div v-for="team in teams">
        <div v-if="team.court_type === 0" class="item-team-title">主队</div>
        <div v-else class="item-team-title">客队</div>
      </div>
      <div class="item-team-title-split">VS</div>
    </div>
    <div class="box-team-name-block">
      <div v-for="team in teams" class="item-team-name">{{team.team_name}}</div>
      <div class="item-team-name-split"></div>
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
      }
    },
    computed: {

    }
  }
</script>

<style scoped>
  .box-team-title-block {
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    align-items: center;
    margin-left: 12px;
    margin-right: 12px;
    margin-top: 8px;
    background: #fec901;
    height: 35px;
    position: relative;
  }
  .item-team-title {
    padding-top: 16px;
    padding-bottom: 16px;
  }
  .item-team-title-split {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
  }
  .box-team-name-block {
    background: white;
    display: -webkit-flex;  /* safari */
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    align-items: center;
    margin-left: 12px;
    margin-right: 12px;
    border: 1px solid #fec901;
    height: 35px;
    position: relative;
  }
  .item-team-name {
    padding-top: 16px;
    padding-bottom: 16px;
  }
  .item-team-name-split {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    height: 100%;
    width: 1px;
    background: #fec901;
  }
</style>
