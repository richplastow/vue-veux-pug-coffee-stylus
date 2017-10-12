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
