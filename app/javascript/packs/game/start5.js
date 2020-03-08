import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue';
import axios from 'axios';

Vue.use(BootstrapVue);


var players = document.getElementsByClassName('players');
var playerArray = new Array;
Array.prototype.slice.call(players).forEach(player=> {
  axios.get(`game/getplayerInfo/${player.id}.json`)
    .then(res => {
      playerArray.push(res.data);
    });
  });
new Vue({
  el: '#start5',
  data: {
    not_chosen_players: playerArray,
    start5Array: [],
    occupied:false,
  },
  methods: {
    set_start5(id,name,position){
      if(this.start5Array.length <= 4 ){
        this.start5Array.push({id: id,name:name,position: position});
        this.not_chosen_players = this.not_chosen_players.filter((n) => n.id !== id);
      }
      if(this.start5Array.length == 5){
        this.occupied = true;
      }
    },
    
    cancell(id,name,position){
      this.start5Array = this.start5Array.filter((n) => n.id !== id);
      this.not_chosen_players.push({id:id,name:name,position});
      this.occupied = false;
    },
    start5Confirm(){
      axios.post(`game/start5_confirm/${this.start5Array[0].id}/${this.start5Array[1].id}/${this.start5Array[2].id}/${this.start5Array[3].id}/${this.start5Array[4].id}`);
      
    }
  },
  
  
  
});
 