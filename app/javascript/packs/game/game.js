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
      bench: playerArray,
      oncourt: start5Array,
      inPlayer: {},
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
    },
    
    inPlayerbtn(id){
      this.inPlayer = playerArray.find((n) => n.id === id);
      this.outPlayerbool = true;
    },
    
    outPlayerbtn(id){
      this.oncourt = this.oncourt.filter((n) => n.id !== id);
      this.oncourt.push(this.inPlayer);
      this.outPlayerbool = false;
      this.playerChangebool = false;
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