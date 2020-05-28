import Vue from 'vue/dist/vue.esm';

import axios from 'axios';



new Vue({
  el: '#team_page',
  data:{
    player_stuts:{},
    detailsbool: false
  },
  methods:{
    get_details(id){
      axios.get(`${id}/details`)
        .then(res => {
          this.player_stuts = res.data;
        });
      this.detailsbool = true;
    }
  }
})