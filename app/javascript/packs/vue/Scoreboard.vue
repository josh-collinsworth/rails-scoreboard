<template>
  <div id="app">
    <Header :game-title="game.name" />
    <p>{{ message }}<strong> SUCKAS</strong></p>
  </div>
</template>

<script>
import Header from './components/Header.vue'
import axios from 'axios'

export default {
  data: () => ({
    message: "Hello Vue!",
    game: {}
  }),
  components: { Header },
  mounted() {
    const id = window.location.href.match(/game\/(\d+)/).pop()
    console.log(`/api/games/${id}`)
    axios.get(`/api/games/${id}`)
      .then(response => this.game = response.data)
  }
}
</script>

<style lang="scss">
@import '../../../assets/stylesheets/vars';

</style>
