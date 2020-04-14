<template>
  <div id="app">
    <transition name="fade">
      <div v-if="loading">
        <Loader />
      </div>
      <div v-else>
        <Header
          :game="game"
          :players="players"
          :alert="alert"
          :options-menu-open="optionsMenuOpen"
          :player-menu-open="playerMenuOpen"
          @togglePlayerMenu="togglePlayerMenu"
          @toggleOptionsMenu="toggleOptionsMenu"
          @refresh="fetchGameData"
        />
        <main id="scoreboard" :class="maybeBlur" @click="closeMenus">
          <h1>{{ game.name }}</h1>
          <Scorecard
            v-for="player in players"
            :key="player.id"
            :player="player"
            :game="game"
            @refresh="fetchGameData"
          />
        </main>
        <transition name="fade">
          <Alert v-if="alerting" :message="alertMessage" :class="notice && 'notice'"/>
        </transition>
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
    optionsMenuOpen: false,
		playerMenuOpen: false,
    game: {},
    id: null,
    alerting: false,
    alertMessage: '',
    notice: false
  }),
  components: { Header, Loader, Alert, Scorecard },
  created() {
    this.id = window.location.href.match(/game\/(\d+)/).pop()
    this.fetchGameData()
  },
  mounted() {
  },
  methods: {
    fetchGame() {
      return axios.get(`/api/games/${this.id}`)
    },
    fetchPlayers() {
      return axios.get(`/api/games/${this.id}?participants=true`)
    },
    fetchPlayerScores() {
      return axios.get(`/api/game_participants/${this.id}`)
    },
    fetchGameData() {
      axios
        .all([this.fetchGame(), this.fetchPlayers(), this.fetchPlayerScores()])
        .then(axios.spread((game, players, scores) => {
          this.game = game.data

          players.data.forEach(player => {
            scores.data.forEach(score => {
              if (player.id == score.participant_id) player.score = score.score
            })
          })
          this.players = players.data
          this.loading = false
          if(!this.players.length) this.playerMenuOpen = true
        }))
        .catch(error => this.alert(error))
    },
    toggleOptionsMenu() {
			this.playerMenuOpen = false
			this.optionsMenuOpen = !this.optionsMenuOpen
		},
		togglePlayerMenu() {
			this.optionsMenuOpen = false
			this.playerMenuOpen = !this.playerMenuOpen
    },
    closeMenus() {
      if (!this.playerMenuOpen && !this.optionsMenuOpen) return
      this.playerMenuOpen = false
      this.optionsMenuOpen = false
    },
    alert(message, notice = false) {
      this.alerting = true
      this.alertMessage = message
      this.notice = notice

      clearTimeout(this.showAlert)

      this.showAlert = setTimeout(() => {
        this.alerting = false
        this.alertMessage = ''
      }, 7000)
    }
  },
  computed: {
    maybeBlur() {
      return (this.playerMenuOpen || this.optionsMenuOpen) && 'blurred'
    }
  }
}
</script>

<style scoped lang="scss">
  @import '../../../assets/stylesheets/vars';

  #app {
    background: $darkGray;
  }

  #scoreboard {
    padding: calc(1rem + 100px) 2rem 2rem;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(calc(10rem + 6vw),  1fr));
    grid-gap: 1rem;
    background: $lightBlue;
    min-height: 100vh;
    align-items: start;
    align-content: start;
    transition: all .2s $easing;

    &.blurred {
      opacity: 0.25;
    }

    h1 {
      grid-column: 1 / -1;
      margin: 0;
      line-height: 1;
    }
  }
</style>
