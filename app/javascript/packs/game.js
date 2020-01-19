import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue'
import App from '../app.vue'

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


const timer = new Vue({
  el: '#timer',
  data() {
    return {
      min: this.gon.period,
      sec: 0,
      timerOn: false,
      timerObj: null,
    }
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
      this.timerOn = true; //timerがOFFであることを状態として保持
    },

    stop: function() {
      clearInterval(this.timerObj);
      this.timerOn = false; //timerがOFFであることを状態として保持
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
  }
});
