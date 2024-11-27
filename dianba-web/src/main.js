import Vue from 'vue'
import 'element-ui/lib/theme-chalk/index.css';
import App from './App.vue'
import ElementUI from 'element-ui';
import VueRouter from 'vue-router';
import router from './router';

Vue.use(VueRouter);

Vue.use(ElementUI);

Vue.config.productionTip = false

new Vue({
  render: h => h(App),
  router,
}).$mount('#app')
