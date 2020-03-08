import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue';
import axios from 'axios';

Vue.use(BootstrapVue);

new Vue({
  el: '#team_page',
  data:{
    player_stuts:{},
    detailsbool: false
  },
  methods:{
    get_details(id){
      axios.get(`home/get_details/${id}.json`)
        .then(res => {
          this.player_stuts = res.data;
        });
      this.detailsbool = true;
    }
  }
})