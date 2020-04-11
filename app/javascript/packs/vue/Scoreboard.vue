<template>
  <div id="app">
    <Header :game="game" />

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
    axios.get(`/api/games/${id}`)
      .then(response => this.game = response.data)
  }
}
</script>

<style lang="scss">
@import '../../../assets/stylesheets/vars';

</style>
