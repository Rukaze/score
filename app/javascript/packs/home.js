import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue';
import "../src/application.scss"


Vue.use(BootstrapVue);

const app = new Vue({
    el: '#hello',
});