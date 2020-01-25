import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue'
import axios from 'axios';

Vue.use(BootstrapVue);

new Vue({
  el: '#employees',
  data: {
    employeeInfo: {},
    employeeBool: false
  },
  methods: {
    setEmployeeInfo(id){
      axios.get(`employees/${id}.json`)
        .then(res => {
          console.log(res.data)
          this.employeeInfo = res.data;
          this.employeeBool = true;
        });
    }
  }
});