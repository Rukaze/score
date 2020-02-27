import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue'
import axios from 'axios';

Vue.use(BootstrapVue);

var min = document.getElementById('min');
var orip1 = document.getElementById('p1');
var orip2 = document.getElementById('p2');
var orip3 = document.getElementById('p3');
var orip4 = document.getElementById('p4');
var orip5 = document.getElementById('p5');
var revs = document.getElementsByClassName('reserves');
const game = new Vue({
  el: '#game',
  data() {
    return {
      min: min.innerHTML,
      sec: 0,
      timerOn: false,
      timerObj: null,
      p1Info: {},
      p2Info: {},
      p3Info: {},
      p4Info: {},
      p5Info: {},
      pChange: false,
      r0: revs[0].innerHTML
    };
  },
  created(){
    axios.get(`game/getplayerInfo/${orip1.innerHTML}.json`)
      .then(res => {
        console.log(res.data);
        this.p1Info = res.data;
      });
    axios.get(`game/getplayerInfo/${orip2.innerHTML}.json`)
      .then(res => {
        console.log(res.data);
        this.p2Info = res.data;
      });
    axios.get(`game/getplayerInfo/${orip3.innerHTML}.json`)
      .then(res => {
        console.log(res.data);
        this.p3Info = res.data;
      });
    axios.get(`game/getplayerInfo/${orip4.innerHTML}.json`)
      .then(res => {
        console.log(res.data);
        this.p4Info = res.data;
      });
    axios.get(`game/getplayerInfo/${orip5.innerHTML}.json`)
      .then(res => {
        console.log(res.data);
        this.p5Info = res.data;
      });
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
      this.timerObj = setInterval(function() {self.count()}, 1000)
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