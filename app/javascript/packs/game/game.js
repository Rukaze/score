import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue';
import axios from 'axios';

Vue.use(BootstrapVue);

var min = document.getElementById('min');

var players = document.getElementsByClassName('players');
var start5players = document.getElementsByClassName('start5player');
var start5Array = new Array;
Array.prototype.slice.call(start5players).forEach(function( startplayer ) {
  axios.get(`game/getplayerInfo/${startplayer.id}.json`)
    .then(res => {
      console.log(res.data);
      start5Array.push(res.data);
    });
  });
var playerArray = new Array;
Array.prototype.slice.call(players).forEach(function( player ) {
  axios.get(`game/getplayerInfo/${player.id}.json`)
    .then(res => {
      console.log(res.data);
      playerArray.push(res.data);
    });
  });
const game = new Vue({
  el: '#game',
  data() {
    return {
      min: min.innerHTML,
      sec: 0,
      timerOn: false,
      timerObj: null,
      playerChangebool: false,
      outPlayerbool: false,
      Scoringbool: false,
      Cancellbool:false,
      bench: playerArray,
      oncourt: start5Array,
      inPlayer: {},
      
      plays: [{kinds:"FGmake"},{kinds:"FGmiss"},{kinds:"3Pmake"},{kinds:"3Pmiss"},{kinds:"FTmake"},
              {kinds:"FTmiss"},{kinds:"DefReb"},{kinds:"OffReb"},{kinds:"Assist"},{kinds:"Block"},
              {kinds:"steal"},{kinds:"TO"},{kinds:"PF"}],
    
      playing_player:{},
      score: 0,
      opp_score: 0,
      quater: 1,
      play_record:[],
      play:{}
    };
  },
  created(){
   
    
  },
  methods: {
    count() {
      if (this.sec <= 0 && this.min >= 1) {
        this.min --;
        this.sec = 59;
      } else if(this.sec <= 0 && this.min <= 0) {
        this.complete();
      } else {
        this.sec --;
      }
    },

    start() {
      let self = this;
      this.timerObj = setInterval(function() {self.count()}, 1000);
      this.timerOn = true; 
    },

    stop() {
      clearInterval(this.timerObj);
      this.timerOn = false; 
      
    },
    
    check() {
      axios.post(`game/check/${this.min}/${this.sec}`);
    },
    complete: function() {
      clearInterval(this.timerObj);
    },
    
    playerChangebtn(){
      this.bench = playerArray.filter((n) => n.id !== this.oncourt[0].id && n.id !== this.oncourt[1].id &&
                                       n.id !== this.oncourt[2].id &&n.id !== this.oncourt[3].id &&
                                       n.id !== this.oncourt[4].id);
      this.playerChangebool = true;
      clearInterval(this.timerObj);
      this.timerOn = false;
      this.Cancellbool = true;
    },
    
    inPlayerbtn(id){
      this.inPlayer = playerArray.find((n) => n.id === id);
      this.outPlayerbool = true;
      
    },
    
    outPlayerbtn(id){
      var outPlayer = this.oncourt.find((n) => n.id === id);
      this.oncourt = this.oncourt.filter((n) => n.id !== id);
      this.oncourt.push(this.inPlayer);
      this.outPlayerbool = false;
      this.playerChangebool = false;
      var gametime_allsecond = this.min * 60 + this.sec;
      axios.post(`game/changeplayer/${this.inPlayer.id}/${outPlayer.id}/${gametime_allsecond}`);
    },
    
    Cancell(){
      this.outPlayerbool = false;
      this.playerChangebool = false;
      
      this.Scoringbool = false;
      this.Cancellbool = false;
    },
    
    scorings(id){
      this.Cancellbool = true;
      this.Scoringbool = true;
      this.playing_player = this.oncourt.find((n) => n.id === id);
    },
    
    Play(id){
      this.play = this.plays[id].kinds;
      axios.post(`game/play_record/${this.playing_player.id}/${id}`);
      if(id == 0){
        this.score += 2;
      }
      if(id == 2){
        this.score += 3;
      }
      if(id == 4){
        this.score += 1;
      }
      this.Scoringbool = false;
      this.Cancellbool = false;
      this.play_record.unshift({play:this.play,player_id:this.playing_player.id,player_name:this.playing_player.name});
    },
    
    play_delete(number){
      this.play_record = this.play_record.filter((n,index) => index !== number);
    },
    
    score_plus(){
      this.score += 1;
    },
    score_minus(){
      this.score -= 1;
    },
    opp_score_plus(){
      this.opp_score += 1;
    },
    opp_score_minus(){
      this.opp_score -= 1;
    },
    
    nextquater(){
      this.min = min.innerHTML;
      this.sec = 0;
      clearInterval(this.timerObj);
      this.timerOn = false;
      axios.post(`game/nextquater/${this.oncourt[0].id}/${this.oncourt[1].id}/${this.oncourt[2].id}/${this.oncourt[3].id}/${this.oncourt[4].id}`);
      this.quater += 1;
    }
  },
  
  computed: {
    formatTime: function() {
      let timeStrings = [
        this.min.toString(),
        this.sec.toString()
      ].map(function(str) {
        if (str.length < 2) {
          return "0" + str;
        } else {
          return str;
        }
      });
      return timeStrings[0] + ":" + timeStrings[1];
    }
  },
  
});