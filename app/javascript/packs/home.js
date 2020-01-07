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
