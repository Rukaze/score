import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue';
import axios from 'axios';

Vue.use(BootstrapVue);

var min = document.getElementById('min');

var players = document.getElementsByClassName('players');
var start5players = document.getElementsByClassName('start5player');
var start5Array = new Array;
Array.prototype.slice.call(start5players).forEach(startplayer =>{
  axios.get(`game/getplayerInfo/${startplayer.id}.json`)
    .then(res => {
      console.log(res.data);
      start5Array.push(res.data);
    });
  });
var playerArray = new Array;
Array.prototype.slice.call(players).forEach(player=> {
  axios.get(`game/getplayerInfo/${player.id}.json`)
    .then(res => {
      console.log(res.data);
      playerArray.push(res.data);
    });
  });
new Vue({
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
      change_record:[],
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
      this.outPlayer = this.oncourt.find((n) => n.id === id);
      this.oncourt = this.oncourt.filter((n) => n.id !== id);
      this.oncourt.push(this.inPlayer);
      this.outPlayerbool = false;
      this.playerChangebool = false;
      this.gametime_allsecond = this.min * 60 + this.sec;
      this.change_record.push({inplayer_id:this.inPlayer.id,outplayer_id:this.outPlayer.id,clock: this.gametime_allsecond});
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
      if(this.min != 0 || this.sec != 0){
        this.gametime_allsecond = this.min * 60 + this.sec;
        this.oncourt.forEach((s) =>{
          this.change_record.push({inplayer_id: "none", outplayer_id: s.id, clock: this.gametime_allsecond});
        });
      }
      this.min = min.innerHTML;
      this.sec = 0;
      clearInterval(this.timerObj);
      this.timerOn = false;
      this.quater += 1;
      this.gametime_allsecond = min.innerHTML * 60 + this.sec;
      this.oncourt.forEach((s) =>{
        this.change_record.push({inplayer_id: s.id, outplayer_id: "none", clock: this.gametime_allsecond});
      });
    },
    
    finish(){
      if(this.min != 0 || this.sec != 0){
        this.gametime_allsecond = this.min * 60 + this.sec;
        this.oncourt.forEach((s) =>{
          this.change_record.push({inplayer_id: "none", outplayer_id: s.id, clock: this.gametime_allsecond});
        });
      }
      this.gametime_allsecond = min.innerHTML * 60 ;
      start5Array.forEach((o) => {
        this.change_record.push({inplayer_id: o.id, outplayer_id: "none", clock: this.gametime_allsecond});
      });
      axios.post(`game/finish/${this.score}/${this.opp_score}`);
      playerArray.forEach(player =>{
        this.c = [];
        this.plays.forEach((play) =>{
          this.each_play = this.play_record.filter((n) => n.player_id === player.id && n.play === play.kinds);
          this.c.push(this.each_play.length);
        });
        this.oncourt_data = this.change_record.filter((n) => n.inplayer_id === player.id);
        this.oncourt_time = 0;
        this.oncourt_data.forEach((o) =>{
          this.oncourt_time += o.clock;
        });
        this.bench_data = this.change_record.filter((n) => n.outplayer_id === player.id);
        this.bench_time = 0;
        this.bench_data.forEach((b) =>{
          this.bench_time += b.clock;
        });
        this.playing_time = this.oncourt_time - this.bench_time;
        axios.post(`game/stuts_record/${player.id}/${player.name}/${this.playing_time}/${this.c[0]}/${this.c[1]}/${this.c[2]}/${this.c[3]}/${this.c[4]}/${this.c[5]}/${this.c[6]}/${this.c[7]}/${this.c[8]}/${this.c[9]}/${this.c[10]}/${this.c[11]}/${this.c[12]}`);
      });
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