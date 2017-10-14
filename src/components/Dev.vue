<template lang="pug">
div#dev
  h1 Dev
  h1 Count: {{ state.count }}
  button(@click="incrCount") Increment
  initial-test
  foobar
</template>

<script lang="coffee">
import store from './Store'
import InitialTest from 'vvpcs-initial-test' # defined by `main` in package.json
import FooBar from 'vvpcs-initial-test/FooBar'
export default
    name: 'Dev'
    data: () ->
        state: store.state
    methods:
        incrCount: ->
            store.commit 'increment'
    components:
        'initial-test': InitialTest
        'foobar': FooBar
</script>

<style lang="stylus" scoped>
h1, h2
  font-weight bold
</style>
