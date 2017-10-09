import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import Dev from '@/components/Dev'

Vue.use Router

export default new Router(
  routes: [
    {
      path: '/'
      name: 'Hello'
      component: HelloWorld
    }
    {
      path: '/dev'
      name: 'Dev'
      component: Dev
    }
  ]
)
