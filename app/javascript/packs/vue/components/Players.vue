<template>
	<aside v-if="game" id="players" :class="playerMenuOpen && 'open'" :tabindex="playerMenuOpen ? 0 : -1" :aria-hidden="!playerMenuOpen">
		<h2>Current players:</h2>
		<ul>
			<li v-for="player in players" :key="player.id">
				{{ player.name }} - {{ player.score || 0 }}
				<a href="#" :data-player-id="player.id" @click="removePlayerFromGame">Remove from game</a>
			</li>
		</ul>

		<h2>Add to game:</h2>
		<ul>
			<li v-for="player in getRemainingPlayers" :key="player.id">
				<a href="#" :data-player-id="player.id" @click="addPlayerToGame">{{ player.name }}</a>
			</li>
			<li>
				<form @submit="createNewPlayer">
					<div class="form-group stacked">
						<label for="new-player">New player:</label>
						<input id="new-player" v-model="newPlayerName" type="text" />
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
		}
	},
	mounted() {
		axios
			.get(`/api/participants`)
			.then(response => this.allPlayers = response.data)
	},
	methods: {
		addPlayerToGame(e) {
			e.preventDefault();
			const playerID = e.target.dataset.playerId
			const data = {
				game_id: this.game.id,
				participant_id: playerID
			}
			axios
				.post(`/api/game_participants`, data)
				.then(response => {
					if (response.data.success) this.refresh()
				})
		},
		removePlayerFromGame(e) {
			e.preventDefault();
			const playerID = e.target.dataset.playerId
			axios
				.delete(`/api/game_participants/${this.game.id}?player_id=${playerID}`)
				.then(response => {
					if (response.data.success) this.refresh()
				})
		},
		createNewPlayer(e) {
			e.preventDefault();
			axios
				.post(`/api/participant/`, { name: this.newPlayerName })
				.then(response => {
					if (response.data.success) this.refresh()
				})
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
		position: absolute;
		width: 100%;
		max-width: 24rem;
		padding: 1rem;
		min-height: calc(100vh - 100px);
		background: $lightBlue;
		right: 0;
		top: 4rem;
		transform: translateX(100%);
		transition: transform .2s $easing;

		&.open {
			transform: translateX(0);
		}
	}
</style>
