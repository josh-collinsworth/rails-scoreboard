<template>
  <div id="app">
    <transition name="fade">
      <div v-if="loading">
        <Loader />
      </div>
      <div v-else>
        <Header :game="game" :refresh="fetchGameData" :players="players" />
      </div>
    </transition>

  </div>
</template>

<script>
import Header from './components/Header.vue'
import Loader from './components/Loader.vue'
import axios from 'axios'

export default {
  data: () => ({
    loading: true,
    game: {},
    id: null
  }),
  components: { Header, Loader },
  created() {
    this.id = window.location.href.match(/game\/(\d+)/).pop()
  },
  mounted() {
    this.fetchGameData()
  },
  methods: {
    fetchGame() {
      return axios.get(`/api/games/${this.id}`)
    },
    fetchParticipants() {
      return axios.get(`/api/games/${this.id}?participants=true`)
    },
    fetchGameData() {
      axios
        .all([this.fetchGame(), this.fetchParticipants()])
        .then(axios.spread((game, players) => {
          this.game = game.data
          this.players = players.data
          this.loading = false
        }))
    }
  }
}
</script>

<style lang="scss">
/* @import '../../../assets/stylesheets/vars'; */

</style>
