import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue';
import axios from 'axios';

Vue.use(BootstrapVue);

var min = document.getElementById('min');

var reserves = document.getElementsByClassName('reserves');
var start5players = document.getElementsByClassName('start5player');
var start5Array = new Array;
Array.prototype.slice.call(start5players).forEach(function( startplayer ) {
  axios.get(`game/getplayerInfo/${startplayer.id}.json`)
    .then(res => {
      console.log(res.data);
      start5Array.push(res.data);
    });
  });
var reserveArray = new Array;
Array.prototype.slice.call(reserves).forEach(function( reserve ) {
  axios.get(`game/getplayerInfo/${reserve.id}.json`)
    .then(res => {
      console.log(res.data);
      reserveArray.push(res.data);
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
      pChange: false,
      bench: reserveArray,
      oncourt: start5Array
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
    
    Change(){
      this.pChange = true;
      clearInterval(this.timerObj);
      this.timerOn = false;
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