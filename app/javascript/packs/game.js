import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue'
import axios from 'axios';

Vue.use(BootstrapVue);



const pregame = new Vue({
    el: '#pregame',
    data: { period_time: 10 },
    methods: {
    plus: function() {
      return this.period_time += 1;
    },
    minus: function() {
      return this.period_time -= 1;
    },
  }
});




var varUserId = document.getElementById('txtUserId');
const timer = new Vue({
  
  el: '#timer',
  data() {
    return {
      min: varUserId.innerHTML,
      sec: 0,
      timerOn: false,
      timerObj: null,
    };
  },
  methods: {
    count: function() {
      if (this.sec <= 0 && this.min >= 1) {
        this.min --;
        this.sec = 59;
      } else if(this.sec <= 0 && this.min <= 0) {
        this.complete();
      } else {
        this.sec --;
      }
    },

    start: function() {
      let self = this;
      this.timerObj = setInterval(function() {self.count()}, 1000)
      this.timerOn = true; 
    },

    stop: function() {
      clearInterval(this.timerObj);
      this.timerOn = false; 
      
    },
    
    check: function() {
      axios.post(`game/check/${this.min}/${this.sec}`);
    },
    complete: function() {
      clearInterval(this.timerObj)
    }
  },
  computed: {
    formatTime: function() {
      let timeStrings = [
        this.min.toString(),
        this.sec.toString()
      ].map(function(str) {
        if (str.length < 2) {
          return "0" + str
        } else {
          return str
        }
      })
      return timeStrings[0] + ":" + timeStrings[1]
    }
  },
  
});


const start5 = new Vue({
  el: '#start5',
  data: {
    p1Info: 'none',
    p2Info: 'none',
    p3Info: 'none',
    p4Info: 'none',
    p5Info: 'none',
    p1exist: false,
    p2exist: false,
    p3exist: false,
    p4exist: false,
    p5exist: false,
    start5: false
  },
  methods: {
    setStart5(id){
      axios.get(`game/start5/${id}.json`)
        .then(res => {
          console.log(res.data);
            if (this.p1Info == 'none' && this.p1Info.id != res.data.id && this.p2Info.id != res.data.id && this.p3Info.id != res.data.id && this.p4Info.id != res.data.id && this.p5Info.id != res.data.id){
              this.p1Info = res.data;
              this.p1exist = true;
            } else{if(this.p2Info == 'none' && this.p1Info.id != res.data.id && this.p2Info.id != res.data.id && this.p3Info.id != res.data.id && this.p4Info.id != res.data.id && this.p5Info.id != res.data.id){
              this.p2Info = res.data;
              this.p2exist = true;
              } else{if(this.p3Info == 'none' && this.p1Info.id != res.data.id && this.p2Info.id != res.data.id && this.p3Info.id != res.data.id && this.p4Info.id != res.data.id && this.p5Info.id != res.data.id){
              this.p3Info = res.data;
              this.p3exist = true;
                } else{if(this.p4Info == 'none' && this.p1Info.id != res.data.id && this.p2Info.id != res.data.id && this.p3Info.id != res.data.id && this.p4Info.id != res.data.id && this.p5Info.id != res.data.id){
              this.p4Info = res.data;
              this.p4exist = true;
                  }  else{if(this.p5Info == 'none' && this.p1Info.id != res.data.id && this.p2Info.id != res.data.id && this.p3Info.id != res.data.id && this.p4Info.id != res.data.id && this.p5Info.id != res.data.id){
              this.p5Info = res.data;
              this.p5exist = true;
            }}}}}});
    },
    p1cancel(){
      this.p1Info = 'none';
      this.p1exist = false;
      this.start5 = false;
    },
    p2cancel(){
      this.p2Info = 'none';
      this.p2exist = false;
      this.start5 = false;
    },
    p3cancel(){
      this.p3Info = 'none';
      this.p3exist = false;
      this.start5 = false;
    },
    p4cancel(){
      this.p4Info = 'none';
      this.p4exist = false;
      this.start5 = false;
    },
    p5cancel(){
      this.p5Info = 'none';
      this.p5exist = false;
      this.start5 = false;
    },
    start5Confirm(){
      axios.post(`game/start5_confirm/${this.p1Info.id}/${this.p2Info.id}/${this.p3Info.id}/${this.p4Info.id}/${this.p5Info.id}`);
      this.start5 = true;
    }
  }
  
  
  
});
 