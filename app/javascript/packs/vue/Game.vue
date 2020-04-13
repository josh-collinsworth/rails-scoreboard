<template>
  <div id="app">
    <transition name="fade">
      <div v-if="loading">
        <Loader />
      </div>
      <div v-else>
        <Header :game="game" :refresh="fetchGameData" :players="players" :alert="alert"/>
         <main id="scoreboard">
          <h1>{{ game.name }} </h1>
           <Scorecard v-for="player in players" :key="player.id" :player="player" :game="game" :refresh="fetchGameData" />
         </main>
         <Alert v-if="alerting" :message="alertMessage"/>
      </div>
    </transition>

  </div>
</template>

<script>
import Header from './components/Header.vue'
import Loader from './components/Loader.vue'
import Alert from './components/Alert.vue'
import Scorecard from './components/Scorecard.vue'
import axios from 'axios'

export default {
  data: () => ({
    loading: true,
    game: {},
    id: null,
    alerting: false,
    alertMessage: ''
  }),
  components: { Header, Loader, Alert, Scorecard },
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
    },
    alert(message) {
      this.alerting = true
      this.alertMessage = message

      setTimeout(() => {
        this.alerting = false
        this.alertMessage = ''
      }, 11000)
    }
  }
}
</script>

<style scoped lang="scss">
  @import '../../../assets/stylesheets/vars';

  #scoreboard {
    padding: calc(1rem + 100px) 2rem 2rem;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(16rem,  1fr));
    grid-gap: 1rem;
    background: $lightBlue;
    min-height: 100vh;

    h1 {
      grid-column: 1 / -1;
      margin: 0;
      line-height: 1;
    }
  }
</style>
