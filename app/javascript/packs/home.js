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

