<template>
	<aside id="players" :class="playerMenuOpen && 'open'" :tabindex="playerMenuOpen ? 0 : -1" :aria-hidden="!playerMenuOpen">
		<h2>Players in Game:</h2>
		<p v-if="!players.length">
			<strong>None</strong>
			<i>(Create players and add them below)</i>
		</p>
		<ul>
			<li v-for="player in players" :key="player.id">
				<span>
					{{ player.name }}:&ensp;<b>{{ player.score || 0 }}</b>
				</span>
				<button @click="removePlayerFromGame(player.id)">Remove from game</button>
			</li>
		</ul>

		<h2>Available Players:</h2>
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
						<label for="new-player">Create new player:</label>
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
		players: {
			type: Array,
			required: true
		},
		alert: {
			type: Function,
			required: true
		}
	},
	created() {
		this.getAllPlayers()
	},
	mounted() {
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
						this.$emit('refresh')
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
						this.$emit('refresh')
					} else {
						this.alert('Error: could not remove player')
					}
				})
		},
		createNewPlayer(e) {
			e.preventDefault();
			axios
				.post(`/api/participants/`, { name: this.newPlayerName })
				.then(response => this.validatePlayerResponse(response, "Unable to create new player", "Successfully created new player"))
				.then(success => {
					if (success) this.newPlayerName = ''
				})
		},
		deletePlayer(playerID){
			const confirmation = confirm("Are you sure you want to delete this player?\n\nThis action is irreversible, and the player will be removed from ALL games (not just this one)!")

			if(confirmation) {
				axios
					.delete(`/api/participants/${playerID}`)
					.then(response => this.validatePlayerResponse(response, "Unable to delete player", "Successfully deleted player"))
					.catch(error => this.alert(error))
			}
		},
		validatePlayerResponse(response, error, success) {
			if(response.data.success) {
				this.alert(success, true)
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
			font-size: 1.25rem;
		}

		ul {
			margin: 0.5rem 0 2rem;

			li {
				font-style: italic;
				font-weight: normal;

				b {
					font-weight: bold;
					font-style: normal;
				}

				button:last-of-type {
					margin-right: 0;
				}
			}
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
