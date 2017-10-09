# Vue Veux Pug Coffee Stylus

The original [Vue Webpack,](https://github.com/vuejs-templates/webpack)
with Veux, Pug, CoffeeScript and Stylus added, as detailed below. 




## Initial setup with Pug, CoffeeScript and Stylus

In Atom, install theses packages:

- language-pug
- language-coffee-script
- language-stylus
- language-vue


```
$ sudo npm install -g vue-cli # if not already installed
$ vue init webpack my-project # hit return to accept all defaults
$ cd my-project/
$ sudo npm install
$ sudo npm i --save-dev pug pug-loader coffee coffee-loader stylus stylus-loader
$ sudo npm i --save-dev coffeescript sinon@2.1.0
$ npm install vuex --save
```

Then in `build/webpack.base.conf.js` comment out ES6 linting (which does not
understand CoffeeScript):

```
 {
   test: /\.(js|vue)$/,
   loader: 'eslint-loader',
   enforce: 'pre',
   include: [resolve('src'), resolve('test')],
   options: {
     formatter: require('eslint-friendly-formatter')
   }
 },
```

...and while you’re there, let’s make webpack more CoffeeScript-friendly:

```
  entry: {
    app: './src/main.coffee'
  },

...

  resolve: {
    extensions: ['.coffee', '.js', '.vue', '.json'],

...

        options: vueLoaderConfig
      },
      {
        test: /\.coffee$/,
        loader: 'coffee-loader',
        include: [resolve('src'), resolve('test')]
      },
      {
        test: /\.js$/,
```

After restarting `$ npm run dev` (if it was running) you can use Pug,
CoffeeScript and Stylus. so `src/App.vue` becomes:

```
<template lang="pug">
div#app
    img(src="./assets/logo.png")
    router-view
    a(href="/#/") Hello
    a(href="/#/dev") Dev
</template>

<script lang="coffee">
export default
    name: 'app'
</script>

<style lang="stylus">
#app
    font-family Arial, sans-serif
    text-align: center
    color #2c3e50
    margin-top 60px
a
    display inline-block
    padding 1em
</style>
```

...and `src/main.js` becomes `src/main.coffee` like this...

```
# The Vue build version to load with the `import` command
# (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'

Vue.config.productionTip = false

# eslint-disable no-new
new Vue(
    el: '#app'
    router: router
    template: '<App/>'
    components: { App }
)

```


## Use Veux storage

Create `src/components/Store.vue` which just has a `<script>` element:

```
<!-- Set up the Veux store -->
<script lang="coffee">
import Vue from 'vue'
import Vuex from 'vuex'
Vue.use Vuex
export default new Vuex.Store({
  state:
    count: 0
  mutations:
    increment: (state) ->
      state.count++
})
</script>

```

To use it, `src/components/HelloWorld.vue` becomes this:

```
<template lang="pug">
div#hello
  h1 Hello
  h1 Count: {{ state.count }}
  button(@click="incrCount") Increment
</template>

<script lang="coffee">
import store from './Store'
export default
    name: 'HelloWorld'
    data: () ->
        state: store.state
    methods:
        incrCount: ->
            store.commit 'increment'
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style lang="stylus" scoped>
h1, h2
  font-weight normal
</style>

```


## Get routing working

`src/router/index.js` becomes `src/router/index.coffee`, and changes to:

```
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
```


## Ready to start developing

Now you can run dev mode, test, and build for production:

```
$ npm run dev
$ npm test
$ npm run build

```




# tmp-vue-test

> A Vue.js project

## Build Setup

``` bash
# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev

# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report

# run unit tests
npm run unit

# run e2e tests
npm run e2e

# run all tests
npm test
```

For a detailed explanation on how things work, check out the [guide](http://vuejs-templates.github.io/webpack/) and [docs for vue-loader](http://vuejs.github.io/vue-loader).
