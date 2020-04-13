<template>
	<aside v-if="game" id="players" :class="playerMenuOpen && 'open'" :tabindex="playerMenuOpen ? 0 : -1" :aria-hidden="!playerMenuOpen">
		<h2>Players in Game:</h2>
		<ul>
			<li v-for="player in players" :key="player.id">
				{{ player.name }} - {{ player.score || 0 }}
				<button @click="removePlayerFromGame(player.id)">Remove from game</button>
			</li>
		</ul>

		<h2>Other Players:</h2>
		<ul>
			<li v-for="player in getRemainingPlayers" :key="player.id">
				{{ player.name }}
				<div>
					<button @click="addPlayerToGame(player.id)">Add to game</button>
					<button @click="deletePlayer(player.id)">Delete</button>
				</div>
			</li>
		</ul>

		<ul>
			<li>
				<form @submit="createNewPlayer">
					<div class="form-group">
						<label for="new-player">New player:</label>
						<input id="new-player" v-model="newPlayerName" type="text" />
						<button type="submit">Add</button>
					</div>
				</form>
			</li>
		</ul>

	</aside>
</template>

<script>
import axios from 'axios'

export default {
	data: () => ({
		allPlayers: [],
		newPlayerName: ''
	}),
	props: {
		playerMenuOpen: {
			type: Boolean,
			required: true
		},
		game: {
			type: Object,
			required: true
		},
		refresh: {
			type: Function,
			required: true
		},
		players: {
			type: Array,
			required: true
		},
		alert: {
			type: Function,
			required: true
		}
	},
	mounted() {
		this.getAllPlayers()
	},
	methods: {
		getAllPlayers() {
			axios
				.get(`/api/participants`)
				.then(response => this.allPlayers = response.data)
		},
		addPlayerToGame(playerID) {
			const data = {
				game_id: this.game.id,
				participant_id: playerID
			}
			axios
				.post(`/api/game_participants`, data)
				.then(response => {
					if (response.data.success) {
						this.refresh()
					} else {
						this.alert('Error: could not add player to game')
					}
				})
		},
		removePlayerFromGame(playerID) {
			axios
				.delete(`/api/game_participants/${this.game.id}?player_id=${playerID}`)
				.then(response => {
										if (response.data.success) {
						this.refresh()
					} else {
						this.alert('Error: could not remove player')
					}
				})
		},
		createNewPlayer(e) {
			e.preventDefault();
			axios
				.post(`/api/participants/`, { name: this.newPlayerName })
				.then(response => this.validatePlayerResponse(response, "Unable to create new player"))
				.then(success => {
					if (success) this.newPlayerName = ''
				})
		},
		deletePlayer(playerID){
			axios
				.delete(`/api/participants/${playerID}`)
				.then(response => this.validatePlayerResponse(response, "Unable to delete player"))
		},
		validatePlayerResponse(response, error) {
			if(response.data.success) {
				this.getAllPlayers()
				return true
			} else {
				this.alert(error)
				return false
			}
		}
	},
	computed: {
		getPlayerIDs() {
			return this.players.map(player => player.id)
		},
		getRemainingPlayers() {
			return this.allPlayers.filter(player => !this.getPlayerIDs.includes(player.id))
		}
	}
}
</script>

<style lang="scss" scoped>
	@import '../../../../assets/stylesheets/vars';

	#players {

		&.open {
			transform: translateX(0);
		}

		h2 {
			margin: 0;
		}

		ul {
			margin: 0.5rem 0 2rem;
		}

		form {
			display: flex;
			align-items: center;
			justify-content: space-between;
			width: 100%;

			input[type="text"] {
				margin: .25rem;
			}
		}
	}
</style>
