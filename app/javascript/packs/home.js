import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue'

Vue.use(BootstrapVue);

const app = new Vue({
    el: '#hello',
    data: { message: 'Hello!' }
});

const reg = new Vue({
    el: '#reg',
});

const team_reg = new Vue({
    el: '#team_reg',
});

const home = new Vue({
    el: '#home',
    data: { message: 'Hello!' }
});

const team_page = new Vue({
    el: '#team_page',
});

var app104 = new Vue({
  el: '#app-104',
  data: { seen: true },
  methods: {
    change: function(e) {
      this.seen = e.target.checked
    }
  }
})

var app123 = new Vue({
  el: '#app-123',
  data: { message: 'Hello' }
})

const timer = new Vue({
  el: '#timer',
  name: 'timer',
  data() {
    return {
      min: 59,
      sec: 59,
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
})