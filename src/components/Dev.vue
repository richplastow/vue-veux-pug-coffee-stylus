<template lang="pug">
div#dev
  h1 Dev
  h1 Count: {{ state.count }}
  button(@click="incrCount") Increment
</template>

<script lang="coffee">
import store from './Store'
export default
    name: 'Dev'
    data: () ->
        state: store.state
    methods:
        incrCount: ->
            store.commit 'increment'
</script>

<style lang="stylus" scoped>
h1, h2
  font-weight bold
</style>
