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
