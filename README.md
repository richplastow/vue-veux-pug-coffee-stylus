# Vue Veux Pug Coffee Stylus

The original [Vue Webpack,](https://github.com/vuejs-templates/webpack)
with Veux, Pug, CoffeeScript and Stylus added, as detailed below.

Each time the original Vue Webpack has a significant update, we should clone it
and run through the following instructions again. Some of the steps will need
to be changed or removed, and new steps may need to be added.




# Process for converting the the original Vue Webpack

Before starting the conversion process, install the syntax-highlighters for your
preferred code editor. Eg, in [Atom](https://atom.io/), install these packages:

- language-pug
- language-coffee-script
- language-stylus
- language-vue


### Init the project and install NPM modules.

On the command line, install `vue`, init a new Vue Webpack project, and install
Veux, Pug, Stylus and CoffeeScript:

```bash
$ sudo npm install -g vue-cli  # if not already installed
$ vue init webpack n-a-m-e     # hit return to accept all defaults
$ cd n-a-m-e/
$ npm install                  # install default vuejs-templates/webpack modules
$ npm i --save vuex            # `i` is shorthand for `install`
$ npm i --save babel-polyfill
$ npm i --save-dev pug pug-loader stylus stylus-loader
$ npm i --save-dev coffee coffee-loader coffeescript sinon@2.1.0
```

You could run `$ npm run dev` at this stage, just to check that Vue Webpack is
working as expected. Quit it with ctrl-c.


### Change the config files.

In `build/webpack.base.conf.js` comment out ES6 linting (which does not
understand CoffeeScript):

```js
// @TODO Allow ES6 linting in .js files
// @TODO Add pug and Stylus linting for .vue files
// @TODO Add CoffeeScript linting for .vue and .coffee files
// @TODO Try to get linting working in .litcoffee and .coffee.md files
/*
  {
    test: /\.(js|vue)$/,
    loader: 'eslint-loader',
    enforce: 'pre',
    include: [resolve('src'), resolve('test')],
    options: {
      formatter: require('eslint-friendly-formatter')
    }
  },
*/
```

...and while you’re there, let’s make webpack more CoffeeScript-friendly:

```js
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
```


### Translate App.vue and main.js

With Pug, CoffeeScript and Stylus, `src/App.vue` becomes:

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

...and `src/main.js` becomes `src/main.coffee`:

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


### Use Veux storage

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
div.hello
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


### Get routing working

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


### Get unit tests working

For unit tests to run, we first first need to [polyfill
Promises](https://github.com/vuejs-templates/webpack/issues/474#issuecomment-277240182)
for PhantomJS in `build/webpack.test.conf.js`:

```js
...

// no need for app entry during tests
delete webpackConfig.entry

//// Avoid “vuex requires a Promise polyfill” error during unit testing.
webpackConfig.entry = {
    app: [
        'babel-polyfill'
      , './src/main.coffee'
    ]
}

...

```

...and to make sure Karma knows how to [load the
polyfill](https://github.com/vuejs-templates/webpack/issues/474#issuecomment-322579722),
in `test/unit/karma.conf.js` change:  
`    files: ['./index.js'],`  
to  
`    files: ['../../node_modules/babel-polyfill/dist/polyfill.js','./index.js'],`

Now `$ npm run unit` will work, and correctly detect an error:  
`expected 'Hello' to equal 'Welcome to Your Vue.js App'`

In `test/unit/specs/Hello.spec.js`, change:  
`      .to.equal('Welcome to Your Vue.js App')`  
to
`      .to.equal('Hello')`

...the unit test should now pass.

@TODO Figure out if the ‘Coverage’ section is working correctly.


### Get end-to-end (e2e) tests working

For end-to-end tests to run, I needed to install the latest [Java SE Development
Kit](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).

Now `$ npm run e2e` will work, and correctly detect an error:  
`expected "Welcome to Your Vue.js App" but got: "Hello"`

In `test/e2e/specs/test.js`, change:  
`      .assert.containsText('h1', 'Welcome to Your Vue.js App')`  
to
`      .assert.containsText('h1', 'Hello')`

...the e2e test should now pass.


### Translate tests to CoffeeScript

@TODO Translate unit and e2e tests to CoffeeScript.  


### Make sure the production-builder works

`$ npm run build` should create a directory called `dist`. You’ll need a local
server to test it, eg `$ beefy --cwd dist`.




### Ready to start developing

Now you can run dev mode, test, and build for production:

```
$ npm run dev
$ npm test
$ npm run build

```




# Development and build commands

```bash

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
